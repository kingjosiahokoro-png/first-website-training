import mongoose from 'mongoose';
import dotenv from 'dotenv';
import fs from 'fs';
import path from 'path';
import { fileURLToPath } from 'url';
import { Flight } from '../models/Flight.js';
import { Seat } from '../models/Seat.js';
import { Booking } from '../models/Booking.js';

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

const flightsData = JSON.parse(fs.readFileSync(path.join(__dirname, '../data/flights.json'), 'utf8'));
const seatsData = JSON.parse(fs.readFileSync(path.join(__dirname, '../data/seats.json'), 'utf8'));

dotenv.config();

export async function connectDB() {
  const uri = process.env.MONGODB_URI;
  const dbName = process.env.DB_NAME || 'first-mobile-app';

  if (!uri) {
    console.error('❌ MONGODB_URI is not defined in environment variables.');
    return;
  }

  try {
    console.log(`⏳ Connecting to MongoDB Atlas (Database: "${dbName}")...`);
    await mongoose.connect(uri, {
      dbName: dbName,
      serverSelectionTimeoutMS: 5000,
    });
    console.log(`✅ MongoDB Connected successfully to database: "${mongoose.connection.name}"`);

    // Auto-seed if collections are empty
    await autoSeedInitialData();
  } catch (err) {
    console.error('❌ MongoDB Connection Error:', err.message);
  }
}

async function autoSeedInitialData() {
  try {
    const flightCount = await Flight.countDocuments();
    if (flightCount === 0) {
      console.log('🌱 Seeding initial flight options to "First mobile app"...');
      await Flight.insertMany(flightsData);
      console.log(`✅ Seeded ${flightsData.length} flights.`);
    }

    const seatCount = await Seat.countDocuments();
    if (seatCount === 0) {
      console.log('🌱 Seeding initial seat matrix to "First mobile app"...');
      await Seat.insertMany(seatsData);
      console.log(`✅ Seeded ${seatsData.length} suites/seats.`);
    }

    const bookingCount = await Booking.countDocuments();
    if (bookingCount === 0) {
      console.log('🌱 Seeding sample flagship booking (AE-88941029)...');
      await Booking.create({
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
        originCity: 'San Francisco',
        destCode: 'HND',
        destCity: 'Tokyo Haneda',
        duration: '11h 15m',
        flightStatus: 'Flight AE-01 • On Schedule',
        boardingCountdown: 'Boarding in 42m',
        isWalletAdded: false
      });
      console.log('✅ Sample booking seeded.');
    }
  } catch (seedErr) {
    console.warn('⚠️ Auto-seed note:', seedErr.message);
  }
}

