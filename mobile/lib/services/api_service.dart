import 'dart:convert';
import 'dart:io';
import '../models/flight.dart';
import '../models/seat.dart';
import '../models/boarding_pass.dart';

class ApiService {
  static const String _defaultBaseUrl = 'http://localhost:3000/api';

  final String baseUrl;

  ApiService({this.baseUrl = _defaultBaseUrl});

  Future<String?> _get(String url) async {
    try {
      final client = HttpClient();
      client.connectionTimeout = const Duration(seconds: 2);
      final request = await client.getUrl(Uri.parse(url));
      final response = await request.close().timeout(const Duration(seconds: 2));
      if (response.statusCode == 200) {
        final body = await response.transform(utf8.decoder).join();
        client.close();
        return body;
      }
      client.close();
    } catch (_) {}
    return null;
  }

  Future<String?> _post(String url, Map<String, dynamic> data) async {
    try {
      final client = HttpClient();
      client.connectionTimeout = const Duration(seconds: 2);
      final request = await client.postUrl(Uri.parse(url));
      request.headers.set('content-type', 'application/json');
      request.add(utf8.encode(jsonEncode(data)));
      final response = await request.close().timeout(const Duration(seconds: 2));
      if (response.statusCode == 200 || response.statusCode == 201) {
        final body = await response.transform(utf8.decoder).join();
        client.close();
        return body;
      }
      client.close();
    } catch (_) {}
    return null;
  }

  /// Check server health
  Future<Map<String, dynamic>?> checkHealth() async {
    try {
      final body = await _get('$baseUrl/health');
      if (body != null) {
        return jsonDecode(body);
      }
    } catch (_) {}
    return null;
  }

  /// Fetch flights from backend with offline fallback
  Future<List<Flight>> getFlights() async {
    try {
      final body = await _get('$baseUrl/flights');
      if (body != null) {
        final List<dynamic> data = jsonDecode(body);
        if (data.isNotEmpty) {
          return data.map((json) => _flightFromJson(json)).toList();
        }
      }
    } catch (_) {}
    return Flight.sampleFlights;
  }

  /// Fetch seat matrix from backend with offline fallback
  Future<List<Seat>> getSeats() async {
    try {
      final body = await _get('$baseUrl/seats');
      if (body != null) {
        final List<dynamic> data = jsonDecode(body);
        if (data.isNotEmpty) {
          return data.map((json) => _seatFromJson(json)).toList();
        }
      }
    } catch (_) {}
    return Seat.defaultFirstSuites;
  }

  /// Fetch active boarding pass from backend
  Future<BoardingPass?> getActiveBoardingPass() async {
    try {
      final body = await _get('$baseUrl/bookings/active');
      if (body != null) {
        final json = jsonDecode(body);
        return _boardingPassFromJson(json);
      }
    } catch (_) {}
    return null;
  }

  /// Confirm a booking on backend
  Future<BoardingPass?> createBooking({
    required String flightNumber,
    required String seatId,
    required String passengerName,
    required String originCode,
    required String destCode,
  }) async {
    try {
      final body = await _post('$baseUrl/bookings', {
        'flightNumber': flightNumber,
        'seatId': seatId,
        'passengerName': passengerName,
        'originCode': originCode,
        'destCode': destCode,
      });

      if (body != null) {
        final json = jsonDecode(body);
        return _boardingPassFromJson(json);
      }
    } catch (_) {}
    return null;
  }

  /// Request Aero Concierge service
  Future<bool> sendConciergeRequest({
    required String requestType,
    required String notes,
    required String pnr,
    required String passengerName,
  }) async {
    try {
      final body = await _post('$baseUrl/concierge/requests', {
        'requestType': requestType,
        'notes': notes,
        'pnr': pnr,
        'passengerName': passengerName,
      });
      return body != null;
    } catch (_) {
      return false;
    }
  }

  static Flight _flightFromJson(Map<String, dynamic> json) {
    List<FlightAmenity> amenitiesList = const [
      FlightAmenity(title: 'Starlink 250Mbps', iconName: 'wifi'),
      FlightAmenity(title: 'Chef Omakase', iconName: 'restaurant'),
      FlightAmenity(title: 'Private Shower', iconName: 'shower'),
    ];

    if (json['amenities'] is List) {
      final list = json['amenities'] as List<dynamic>;
      amenitiesList = list.map((a) {
        if (a is Map) {
          return FlightAmenity(
            title: a['title'] as String? ?? 'Amenity',
            iconName: a['iconName'] as String? ?? a['icon'] as String? ?? 'star',
          );
        }
        return const FlightAmenity(title: 'Premium Amenity', iconName: 'star');
      }).toList();
    }

    return Flight(
      flightNumber: json['flightNumber'] as String? ?? 'AE-01',
      title: json['title'] as String? ?? 'Aero Flagship Nonstop',
      aircraft: json['aircraft'] as String? ?? 'Airbus A350-1000 Suite',
      originCode: json['originCode'] as String? ?? 'SFO',
      originName: json['originName'] as String? ?? 'San Francisco International',
      originTerminalGate: json['originTerminalGate'] as String? ?? 'Terminal I • Gate G98',
      destCode: json['destCode'] as String? ?? 'HND',
      destName: json['destName'] as String? ?? 'Tokyo Haneda',
      destTerminalGate: json['destTerminalGate'] as String? ?? 'Terminal 3 • Private Salon',
      departureTime: json['departureTime'] as String? ?? '11:20 AM',
      arrivalTime: json['arrivalTime'] as String? ?? '03:35 PM',
      nextDay: json['nextDay'] as String?,
      duration: json['duration'] as String? ?? '11h 15m',
      isDirect: json['isDirect'] as bool? ?? true,
      price: (json['price'] as num?)?.toDouble() ?? 6250.0,
      tag: json['tag'] as String? ?? 'Signature',
      isSignature: json['isSignature'] as bool? ?? false,
      cabinClass: json['cabinClass'] as String? ?? 'First Suite • All-Inclusive',
      amenities: amenitiesList,
    );
  }

  static Seat _seatFromJson(Map<String, dynamic> json) {
    final bool occupied = json['isOccupied'] as bool? ??
        (json['isAvailable'] != null ? !(json['isAvailable'] as bool) : false);

    return Seat(
      id: json['id'] as String? ?? '1A',
      row: (json['row'] as num?)?.toInt() ?? 1,
      column: json['column'] as String? ?? 'A',
      isWindow: json['isWindow'] as bool? ?? true,
      isAisle: json['isAisle'] as bool? ?? true,
      isOccupied: occupied,
      priceDelta: (json['priceDelta'] as num?)?.toDouble() ?? 0.0,
      passengerName: json['passengerName'] as String?,
      description: json['description'] as String? ??
          'First Class Private Suite with direct aisle ingress.',
    );
  }

  static BoardingPass _boardingPassFromJson(Map<String, dynamic> json) {
    return BoardingPass(
      pnr: json['pnr'] as String? ?? 'AE-88941029',
      flightNumber: json['flightNumber'] as String? ?? 'AE-01',
      flightTitle: json['flightTitle'] as String? ?? 'Aero Flagship Nonstop',
      passengerName: json['passengerName'] as String? ?? 'Mr. Alexander Vance',
      seat: json['seat'] as String? ?? '1A',
      zone: json['zone'] as String? ?? 'ZONE 1',
      cabinTier: json['cabinTier'] as String? ?? 'First Class Suite',
      terminal: json['terminal'] as String? ?? 'INTL 1',
      gate: json['gate'] as String? ?? 'G14',
      boardingTime: json['boardingTime'] as String? ?? '10:40 AM',
      departureDate: json['departureDate'] as String? ?? '24 OCT',
      departureTime: json['departureTime'] as String? ?? '11:20 AM',
      arrivalTime: json['arrivalTime'] as String? ?? '03:35 PM',
      originCode: json['originCode'] as String? ?? 'SFO',
      originCity: json['originCity'] as String? ?? 'San Francisco',
      destCode: json['destCode'] as String? ?? 'HND',
      destCity: json['destCity'] as String? ?? 'Tokyo',
      duration: json['duration'] as String? ?? '11h 15m',
      flightStatus: json['flightStatus'] as String? ?? 'Flight AE-01 • On Schedule',
      boardingCountdown: json['boardingCountdown'] as String? ?? 'Boarding in 42m',
      isWalletAdded: json['isWalletAdded'] as bool? ?? false,
    );
  }
}
