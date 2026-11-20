export const mockDestinations = [
  {
    id: 'hnd',
    city: 'Tokyo Haneda',
    airportName: 'Haneda International',
    iataCode: 'HND',
    duration: '11h 15m • Nonstop',
    fromPrice: 4850,
    aircraft: 'Airbus A350-1000',
    cabinTier: 'Private Suite',
    imageUrl: 'https://images.unsplash.com/photo-1503899036084-c55cdd92da26?auto=format&fit=crop&w=800&q=80'
  },
  {
    id: 'zrh',
    city: 'Zurich Kloten',
    airportName: 'Kloten Airport',
    iataCode: 'ZRH',
    duration: '10h 40m • Nonstop',
    fromPrice: 5220,
    aircraft: 'Boeing 787-9 Dreamliner',
    cabinTier: 'Private Bar',
    imageUrl: 'https://images.unsplash.com/photo-1515488764276-beab7607c1e6?auto=format&fit=crop&w=800&q=80'
  },
  {
    id: 'lhr',
    city: 'London Heathrow',
    airportName: 'Heathrow Airport',
    iataCode: 'LHR',
    duration: '9h 55m • Nonstop',
    fromPrice: 4400,
    aircraft: 'Airbus A350-1000',
    cabinTier: 'Studio First',
    imageUrl: 'https://images.unsplash.com/photo-1513635269975-59663e0ac1ad?auto=format&fit=crop&w=800&q=80'
  },
  {
    id: 'sin',
    city: 'Singapore Changi',
    airportName: 'Changi International',
    iataCode: 'SIN',
    duration: '15h 20m • Nonstop',
    fromPrice: 6100,
    aircraft: 'Airbus A350-900ULR',
    cabinTier: 'First Suite',
    imageUrl: 'https://images.unsplash.com/photo-1525625293386-3f8f99389edd?auto=format&fit=crop&w=800&q=80'
  }
];

export const mockFlights = [
  {
    flightNumber: 'AE-01',
    title: 'Aero Flagship Nonstop',
    aircraft: 'Airbus A350-1000 Suite • Tail #N901AE',
    originCode: 'SFO',
    originName: 'San Francisco International',
    originTerminalGate: 'Terminal I • Gate G98',
    destCode: 'HND',
    destName: 'Tokyo Haneda',
    destTerminalGate: 'Terminal 3 • Private Salon',
    departureTime: '11:20 AM',
    arrivalTime: '03:35 PM',
    nextDay: '+1',
    duration: '11h 15m',
    isDirect: true,
    price: 6250.0,
    tag: 'Signature',
    isSignature: true,
    cabinClass: 'First Suite • All-Inclusive',
    amenities: [
      { title: 'Starlink 250Mbps', icon: 'wifi' },
      { title: 'Chef Omakase', icon: 'restaurant' },
      { title: 'Private Shower', icon: 'shower' }
    ]
  },
  {
    flightNumber: 'AE-09',
    title: 'Tokyo Twilight Nonstop',
    aircraft: 'Boeing 787-9 Dreamliner SkySuite',
    originCode: 'SFO',
    originName: 'San Francisco International',
    originTerminalGate: 'Terminal I • Gate G102',
    destCode: 'HND',
    destName: 'Tokyo Haneda',
    destTerminalGate: 'Terminal 3 • Fast Track',
    departureTime: '05:45 PM',
    arrivalTime: '09:55 PM',
    nextDay: '+1',
    duration: '11h 10m',
    isDirect: true,
    price: 5850.0,
    tag: 'Overnight Sleeper',
    isSignature: false,
    cabinClass: 'First Suite',
    amenities: [
      { title: 'Lie-flat 82"', icon: 'bed' },
      { title: 'Sommelier Cellar', icon: 'wine_bar' },
      { title: 'Bespoke Audio', icon: 'headphones' }
    ]
  },
  {
    flightNumber: 'AE-15',
    title: 'Aero Dawn Express',
    aircraft: 'Airbus A350-1000 Flagship',
    originCode: 'SFO',
    originName: 'San Francisco International',
    originTerminalGate: 'Terminal I • Gate G92',
    destCode: 'HND',
    destName: 'Tokyo Haneda',
    destTerminalGate: 'Terminal 3 • Private Salon',
    departureTime: '08:15 AM',
    arrivalTime: '12:30 PM',
    nextDay: '+1',
    duration: '11h 15m',
    isDirect: true,
    price: 6400.0,
    tag: 'Morning Express',
    isSignature: false,
    cabinClass: 'First Suite • All-Inclusive',
    amenities: [
      { title: 'Starlink 250Mbps', icon: 'wifi' },
      { title: 'Gourmet Breakfast', icon: 'restaurant' },
      { title: 'Chauffeur Service', icon: 'directions_car' }
    ]
  }
];

export const mockSeats = [
  { id: '1A', row: 1, col: 'A', isWindow: true, isAisle: true, isOccupied: false, passenger: 'A. Vance', delta: 0, desc: 'Portside Window Sanctuary with dual panoramic dimmable windows, zero-gravity sleep mode, and direct aisle ingress.' },
  { id: '1D', row: 1, col: 'D', isWindow: false, isAisle: true, isOccupied: false, delta: 0, desc: 'Center Honeymoon Atelier with retractable walnut privacy partition and 82" lie-flat bed.' },
  { id: '1G', row: 1, col: 'G', isWindow: false, isAisle: true, isOccupied: false, delta: 0, desc: 'Center Honeymoon Atelier with retractable walnut privacy partition and 82" lie-flat bed.' },
  { id: '1K', row: 1, col: 'K', isWindow: true, isAisle: true, isOccupied: true, delta: 0 },
  { id: '2A', row: 2, col: 'A', isWindow: true, isAisle: true, isOccupied: false, delta: 0 },
  { id: '2D', row: 2, col: 'D', isWindow: false, isAisle: true, isOccupied: true, delta: 0 },
  { id: '2G', row: 2, col: 'G', isWindow: false, isAisle: true, isOccupied: true, delta: 0 },
  { id: '2K', row: 2, col: 'K', isWindow: true, isAisle: true, isOccupied: false, delta: 0 },
  { id: '3A', row: 3, col: 'A', isWindow: true, isAisle: true, isOccupied: true, delta: 0 },
  { id: '3D', row: 3, col: 'D', isWindow: false, isAisle: true, isOccupied: false, delta: 0 },
  { id: '3G', row: 3, col: 'G', isWindow: false, isAisle: true, isOccupied: false, delta: 0 },
  { id: '3K', row: 3, col: 'K', isWindow: true, isAisle: true, isOccupied: true, delta: 0 },
  { id: '4A', row: 4, col: 'A', isWindow: true, isAisle: true, isOccupied: false, delta: 0 },
  { id: '4D', row: 4, col: 'D', isWindow: false, isAisle: true, isOccupied: false, delta: 0 },
  { id: '4G', row: 4, col: 'G', isWindow: false, isAisle: true, isOccupied: false, delta: 0 },
  { id: '4K', row: 4, col: 'K', isWindow: true, isAisle: true, isOccupied: false, delta: 0 }
];
