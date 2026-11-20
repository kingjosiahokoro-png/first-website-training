import express from 'express';
import cors from 'cors';
import dotenv from 'dotenv';
import fs from 'fs';
import path from 'path';
import { fileURLToPath } from 'url';
import { S3Client, PutObjectCommand, ListObjectsV2Command } from '@aws-sdk/client-s3';
import { connectDB } from './config/db.js';
import { Flight } from './models/Flight.js';
import { Seat } from './models/Seat.js';
import { Booking } from './models/Booking.js';
import { ConciergeRequest } from './models/ConciergeRequest.js';

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

dotenv.config({ path: path.join(__dirname, '../.env') });

const flightsFallback = JSON.parse(fs.readFileSync(path.join(__dirname, './data/flights.json'), 'utf8'));
const seatsFallback = JSON.parse(fs.readFileSync(path.join(__dirname, './data/seats.json'), 'utf8'));

const app = express();
const PORT = process.env.PORT || 3000;

app.use(cors());
app.use(express.json());

// Initialize MongoDB Connection
connectDB();

// AWS S3 & CloudFront Setup
const s3Region = process.env.AWS_REGION || 'eu-north-1';
const s3Bucket = process.env.AWS_S3_BUCKET || 'royal-logistics-storage2026';
const cloudFrontUrl = (process.env.CLOUDFRONT_URL || 'https://d3cu62h552pbin.cloudfront.net').replace(/\/$/, '');

let s3Client = null;
if (process.env.AWS_ACCESS_KEY_ID && process.env.AWS_SECRET_ACCESS_KEY) {
  s3Client = new S3Client({
    region: s3Region,
    credentials: {
      accessKeyId: process.env.AWS_ACCESS_KEY_ID.trim(),
      secretAccessKey: process.env.AWS_SECRET_ACCESS_KEY.trim(),
    },
  });
}

// -------------------------------------------------------------
// Diagnostic & Cloud Health Endpoint
// -------------------------------------------------------------
app.get('/api/health', (req, res) => {
  res.json({
    status: 'healthy',
    service: 'Royal Logistics API',
    database: process.env.DB_NAME || 'first-mobile-app',
    s3Bucket,
    cloudFrontUrl,
    timestamp: new Date().toISOString(),
  });
});

// -------------------------------------------------------------
// 1. Flights Endpoints
// -------------------------------------------------------------
app.get('/api/flights', async (req, res) => {
  try {
    const { origin, dest } = req.query;
    const filter = {};
    if (origin) filter.originCode = new RegExp(`^${origin}$`, 'i');
    if (dest) filter.destCode = new RegExp(`^${dest}$`, 'i');

    const flights = await Flight.find(filter).lean();
    if (flights.length > 0) {
      return res.json(flights);
    }
    let fallback = flightsFallback;
    if (origin) fallback = fallback.filter(f => f.originCode.toLowerCase() === origin.toLowerCase());
    if (dest) fallback = fallback.filter(f => f.destCode.toLowerCase() === dest.toLowerCase());
    res.json(fallback);
  } catch (err) {
    res.json(flightsFallback);
  }
});

app.get('/api/flights/:flightNumber', async (req, res) => {
  try {
    const flight = await Flight.findOne({
      flightNumber: new RegExp(`^${req.params.flightNumber}$`, 'i'),
    }).lean();
    if (flight) return res.json(flight);

    const fallback = flightsFallback.find(
      f => f.flightNumber.toLowerCase() === req.params.flightNumber.toLowerCase(),
    );
    if (!fallback) return res.status(404).json({ error: 'Flight not found' });
    res.json(fallback);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

// -------------------------------------------------------------
// 2. Seat Matrix Endpoints
// -------------------------------------------------------------
app.get('/api/seats', async (req, res) => {
  try {
    const seats = await Seat.find({}).sort({ row: 1, column: 1 }).lean();
    if (seats.length > 0) return res.json(seats);
    res.json(seatsFallback);
  } catch (err) {
    res.json(seatsFallback);
  }
});

app.post('/api/seats/select', async (req, res) => {
  const { seatId, passengerName } = req.body;
  try {
    const seat = await Seat.findOne({ id: seatId });
    if (!seat) return res.status(404).json({ error: 'Seat not found' });
    if (seat.isOccupied) return res.status(400).json({ error: 'Seat is already occupied' });

    seat.passengerName = passengerName || 'A. Vance';
    await seat.save();
    res.json({ success: true, selectedSeat: seat });
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

// -------------------------------------------------------------
// 3. Bookings & Boarding Pass Endpoints
// -------------------------------------------------------------
app.get('/api/bookings/active', async (req, res) => {
  try {
    const latest = await Booking.findOne({}).sort({ createdAt: -1 }).lean();
    if (latest) return res.json(latest);
    res.json({
      pnr: 'AE-88941029',
      flightNumber: 'AE-01',
      flightTitle: 'Aero Flagship Nonstop',
      passengerName: 'Mr. Alexander Vance',
      seat: '1A',
      zone: 'ZONE 1',
      cabinTier: 'First Class Suite',
      terminal: 'INTL 1',
      gate: 'G14',
      boardingTime: '10:40 AM',
      departureDate: '24 OCT',
      departureTime: '11:20 AM',
      arrivalTime: '03:35 PM',
      originCode: 'SFO',
      destCode: 'HND',
      duration: '11h 15m',
      flightStatus: 'Flight AE-01 • On Schedule',
      boardingCountdown: 'Boarding in 42m',
      isWalletAdded: false,
    });
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

app.get('/api/boarding-pass/:pnr', async (req, res) => {
  try {
    const booking = await Booking.findOne({
      pnr: new RegExp(`^${req.params.pnr}$`, 'i'),
    }).lean();
    if (!booking) return res.status(404).json({ error: 'Booking reference not found' });
    res.json(booking);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

app.post('/api/bookings', async (req, res) => {
  try {
    const { flightNumber, seatId, passengerName, originCode, destCode } = req.body;
    const pnr = `AE-${Math.floor(10000000 + Math.random() * 90000000)}`;

    const newBooking = await Booking.create({
      pnr,
      flightNumber: flightNumber || 'AE-01',
      flightTitle: 'Aero Flagship Nonstop',
      passengerName: passengerName || 'Mr. Alexander Vance',
      seat: seatId || '1A',
      zone: 'ZONE 1',
      cabinTier: 'First Class Suite',
      terminal: 'INTL 1',
      gate: 'G14',
      boardingTime: '10:40 AM',
      departureDate: '24 OCT',
      departureTime: '11:20 AM',
      arrivalTime: '03:35 PM',
      originCode: originCode || 'SFO',
      destCode: destCode || 'HND',
      duration: '11h 15m',
      flightStatus: 'Flight AE-01 • On Schedule',
      boardingCountdown: 'Boarding in 42m',
      isWalletAdded: false,
    });

    if (seatId) {
      await Seat.findOneAndUpdate({ id: seatId }, { isOccupied: true, passengerName: passengerName || 'A. Vance' });
    }

    res.status(201).json(newBooking);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

// -------------------------------------------------------------
// 4. Concierge Dispatch Endpoints
// -------------------------------------------------------------
app.post('/api/concierge/requests', async (req, res) => {
  try {
    const { requestType, notes, pnr, passengerName } = req.body;
    const requestId = `REQ-${Date.now()}`;

    const newRequest = await ConciergeRequest.create({
      requestId,
      pnr: pnr || 'AE-88941029',
      passengerName: passengerName || 'Mr. Alexander Vance',
      requestType,
      notes: notes || '',
      status: 'Dispatched to Personal Attendant',
    });

    res.status(201).json(newRequest);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

// -------------------------------------------------------------
// 5. AWS S3 & CloudFront Media Endpoints
// -------------------------------------------------------------
app.get('/api/media/assets', async (req, res) => {
  if (!s3Client) {
    return res.status(503).json({ error: 'AWS S3 is not configured.' });
  }

  try {
    const listRes = await s3Client.send(new ListObjectsV2Command({ Bucket: s3Bucket }));
    const objects = (listRes.Contents || []).map(obj => ({
      key: obj.Key,
      size: obj.Size,
      lastModified: obj.LastModified,
      directS3Url: `https://${s3Bucket}.s3.${s3Region}.amazonaws.com/${obj.Key}`,
      cloudFrontUrl: `${cloudFrontUrl}/${obj.Key}`,
    }));
    res.json({ bucket: s3Bucket, region: s3Region, cloudFrontUrl, objects });
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

app.post('/api/media/upload-text', async (req, res) => {
  if (!s3Client) {
    return res.status(503).json({ error: 'AWS S3 is not configured.' });
  }

  const { fileName, content, contentType } = req.body;
  if (!fileName || !content) {
    return res.status(400).json({ error: 'fileName and content are required.' });
  }

  const key = `user-uploads/${Date.now()}-${fileName}`;
  try {
    await s3Client.send(new PutObjectCommand({
      Bucket: s3Bucket,
      Key: key,
      Body: typeof content === 'object' ? JSON.stringify(content, null, 2) : String(content),
      ContentType: contentType || 'application/json',
    }));

    res.json({
      success: true,
      key,
      s3Url: `https://${s3Bucket}.s3.${s3Region}.amazonaws.com/${key}`,
      cdnUrl: `${cloudFrontUrl}/${key}`,
    });
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

app.listen(PORT, () => {
  console.log(`✨ Royal Logistics API Server running on port ${PORT}`);
  console.log(`🌐 MongoDB: database "${process.env.DB_NAME || 'first-mobile-app'}"`);
  console.log(`☁️  AWS CloudFront CDN: ${cloudFrontUrl}`);
});
