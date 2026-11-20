import mongoose from 'mongoose';

const seatSchema = new mongoose.Schema({
  id: { type: String, required: true, unique: true }, // e.g. '1A', '1D'
  row: { type: Number, required: true },
  column: { type: String, required: true },
  isWindow: { type: Boolean, default: false },
  isAisle: { type: Boolean, default: false },
  isOccupied: { type: Boolean, default: false },
  priceDelta: { type: Number, default: 0.0 },
  passengerName: { type: String, default: null },
  description: { type: String, default: 'First Class Private Suite with direct aisle ingress.' }
}, {
  timestamps: true
});

export const Seat = mongoose.model('Seat', seatSchema);

