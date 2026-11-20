class FlightAmenity {
  final String title;
  final String iconName;

  const FlightAmenity({required this.title, required this.iconName});
}

class Flight {
  final String flightNumber;
  final String title;
  final String aircraft;
  final String originCode;
  final String originName;
  final String originTerminalGate;
  final String destCode;
  final String destName;
  final String destTerminalGate;
  final String departureTime;
  final String arrivalTime;
  final String? nextDay;
  final String duration;
  final bool isDirect;
  final double price;
  final String tag;
  final bool isSignature;
  final String cabinClass;
  final List<FlightAmenity> amenities;

  const Flight({
    required this.flightNumber,
    required this.title,
    required this.aircraft,
    required this.originCode,
    required this.originName,
    required this.originTerminalGate,
    required this.destCode,
    required this.destName,
    required this.destTerminalGate,
    required this.departureTime,
    required this.arrivalTime,
    this.nextDay,
    required this.duration,
    required this.isDirect,
    required this.price,
    required this.tag,
    this.isSignature = false,
    required this.cabinClass,
    required this.amenities,
  });

  static List<Flight> get sampleFlights => const [
        Flight(
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
            FlightAmenity(title: 'Starlink 250Mbps', iconName: 'wifi'),
            FlightAmenity(title: 'Chef Omakase', iconName: 'restaurant'),
            FlightAmenity(title: 'Private Shower', iconName: 'shower'),
          ],
        ),
        Flight(
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
            FlightAmenity(title: 'Lie-flat 82"', iconName: 'bed'),
            FlightAmenity(title: 'Sommelier Cellar', iconName: 'wine_bar'),
            FlightAmenity(title: 'Bespoke Audio', iconName: 'headphones'),
          ],
        ),
        Flight(
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
            FlightAmenity(title: 'Starlink 250Mbps', iconName: 'wifi'),
            FlightAmenity(title: 'Gourmet Breakfast', iconName: 'restaurant'),
            FlightAmenity(title: 'Chauffeur Service', iconName: 'directions_car'),
          ],
        ),
      ];
}

