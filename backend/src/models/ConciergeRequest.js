import mongoose from 'mongoose';

const conciergeRequestSchema = new mongoose.Schema({
  requestId: { type: String, required: true, unique: true },
  pnr: { type: String, default: 'AE-88941029' },
  passengerName: { type: String, default: 'Mr. Alexander Vance' },
  requestType: {
    type: String,
    required: true,
    enum: ['rolls_royce_transfer', 'dom_perignon_cellar', 'white_glove_baggage', 'general_concierge']
  },
  notes: { type: String, default: '' },
  status: {
    type: String,
    default: 'Dispatched to Personal Attendant',
    enum: ['Pending', 'Dispatched to Personal Attendant', 'Confirmed', 'Completed']
  }
}, {
  timestamps: true
});

export const ConciergeRequest = mongoose.model('ConciergeRequest', conciergeRequestSchema);

