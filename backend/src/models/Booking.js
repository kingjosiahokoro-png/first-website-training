import mongoose from 'mongoose';

const bookingSchema = new mongoose.Schema({
  pnr: { type: String, required: true, unique: true }, // e.g. 'AE-88941029'
  flightNumber: { type: String, required: true },
  flightTitle: { type: String, default: 'Aero Flagship Nonstop' },
  passengerName: { type: String, required: true },
  seat: { type: String, required: true },
  zone: { type: String, default: 'ZONE 1' },
  cabinTier: { type: String, default: 'First Class Suite' },
  terminal: { type: String, default: 'INTL 1' },
  gate: { type: String, default: 'G14' },
  boardingTime: { type: String, default: '10:40 AM' },
  departureDate: { type: String, required: true },
  departureTime: { type: String, required: true },
  arrivalTime: { type: String, required: true },
  originCode: { type: String, required: true },
  originCity: { type: String, default: 'San Francisco' },
  destCode: { type: String, required: true },
  destCity: { type: String, default: 'Tokyo Haneda' },
  duration: { type: String, default: '11h 15m' },
  flightStatus: { type: String, default: 'Flight AE-01 • On Schedule' },
  boardingCountdown: { type: String, default: 'Boarding in 42m' },
  isWalletAdded: { type: Boolean, default: false }
}, {
  timestamps: true
});

export const Booking = mongoose.model('Booking', bookingSchema);

