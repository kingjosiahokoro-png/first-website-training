import mongoose from 'mongoose';
import dotenv from 'dotenv';
import fs from 'fs';
import path from 'path';
import { fileURLToPath } from 'url';
import { Flight } from '../models/Flight.js';
import { Seat } from '../models/Seat.js';
import { Booking } from '../models/Booking.js';
import { ConciergeRequest } from '../models/ConciergeRequest.js';

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

const flightsData = JSON.parse(fs.readFileSync(path.join(__dirname, '../data/flights.json'), 'utf8'));
const seatsData = JSON.parse(fs.readFileSync(path.join(__dirname, '../data/seats.json'), 'utf8'));

dotenv.config();

const uri = process.env.MONGODB_URI;
const dbName = process.env.DB_NAME || 'first-mobile-app';

async function seed() {
  if (!uri) {
    console.error('❌ MONGODB_URI not found.');
    process.exit(1);
  }

  try {
    console.log(`Connecting to database "${dbName}"...`);
    await mongoose.connect(uri, { dbName });
    console.log('Connected.');

    console.log('Clearing existing data...');
    await Flight.deleteMany({});
    await Seat.deleteMany({});
    await Booking.deleteMany({});
    await ConciergeRequest.deleteMany({});

    console.log('Inserting flights...');
    await Flight.insertMany(flightsData);

    console.log('Inserting seat matrix...');
    await Seat.insertMany(seatsData);

    console.log('Inserting initial confirmed booking...');
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

    console.log(`🎉 Seeding complete for database: "${dbName}"!`);
    process.exit(0);
  } catch (err) {
    console.error('Error during seed:', err);
    process.exit(1);
  }
}

seed();

