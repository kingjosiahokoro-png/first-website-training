import mongoose from 'mongoose';

const amenitySchema = new mongoose.Schema({
  title: { type: String, required: true },
  iconName: { type: String, required: true }
}, { _id: false });

const flightSchema = new mongoose.Schema({
  flightNumber: { type: String, required: true, unique: true },
  title: { type: String, required: true },
  aircraft: { type: String, required: true },
  originCode: { type: String, required: true },
  originName: { type: String, required: true },
  originTerminalGate: { type: String, required: true },
  destCode: { type: String, required: true },
  destName: { type: String, required: true },
  destTerminalGate: { type: String, required: true },
  departureTime: { type: String, required: true },
  arrivalTime: { type: String, required: true },
  nextDay: { type: String, default: null },
  duration: { type: String, required: true },
  isDirect: { type: Boolean, default: true },
  price: { type: Number, required: true },
  tag: { type: String, required: true },
  isSignature: { type: Boolean, default: false },
  cabinClass: { type: String, default: 'First Suite • All-Inclusive' },
  amenities: [amenitySchema]
}, {
  timestamps: true
});

export const Flight = mongoose.model('Flight', flightSchema);

