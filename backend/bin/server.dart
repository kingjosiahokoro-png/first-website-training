import 'dart:convert';
import 'dart:io';

void main() async {
  final port = int.tryParse(Platform.environment['PORT'] ?? '4000') ?? 4000;
  final server = await HttpServer.bind(InternetAddress.anyIPv4, port);
  print('Royal Logistics Native Backend API listening on http://localhost:$port');

  await for (HttpRequest request in server) {
    // Add CORS headers
    request.response.headers.add('Access-Control-Allow-Origin', '*');
    request.response.headers.add('Access-Control-Allow-Methods', 'GET, POST, OPTIONS');
    request.response.headers.add('Access-Control-Allow-Headers', 'Content-Type, Authorization');
    request.response.headers.contentType = ContentType.json;

    if (request.method == 'OPTIONS') {
      request.response.statusCode = HttpStatus.ok;
      await request.response.close();
      continue;
    }

    final path = request.uri.path;

    if (path == '/api/health') {
      request.response.write(jsonEncode({
        'status': 'healthy',
        'service': 'Royal Logistics Native Dart API',
        'timestamp': DateTime.now().toIso8601String(),
      }));
    } else if (path == '/api/flights') {
      final flights = [
        {
          'flightNumber': 'AE-01',
          'title': 'Aero Flagship Nonstop',
          'aircraft': 'Airbus A350-1000 Suite • Tail #N901AE',
          'originCode': 'SFO',
          'originName': 'San Francisco International',
          'destCode': 'HND',
          'destName': 'Tokyo Haneda',
          'departureTime': '11:20 AM',
          'arrivalTime': '03:35 PM',
          'nextDay': '+1',
          'duration': '11h 15m',
          'price': 6250.0,
          'tag': 'Signature',
        },
        {
          'flightNumber': 'AE-09',
          'title': 'Tokyo Twilight Nonstop',
          'aircraft': 'Boeing 787-9 Dreamliner SkySuite',
          'originCode': 'SFO',
          'originName': 'San Francisco International',
          'destCode': 'HND',
          'destName': 'Tokyo Haneda',
          'departureTime': '05:45 PM',
          'arrivalTime': '09:55 PM',
          'nextDay': '+1',
          'duration': '11h 10m',
          'price': 5850.0,
          'tag': 'Overnight Sleeper',
        },
        {
          'flightNumber': 'AE-15',
          'title': 'Aero Dawn Express',
          'aircraft': 'Airbus A350-1000 Flagship',
          'originCode': 'SFO',
          'originName': 'San Francisco International',
          'destCode': 'HND',
          'destName': 'Tokyo Haneda',
          'departureTime': '08:15 AM',
          'arrivalTime': '12:30 PM',
          'nextDay': '+1',
          'duration': '11h 15m',
          'price': 6400.0,
          'tag': 'Morning Express',
        }
      ];
      request.response.write(jsonEncode(flights));
    } else if (path == '/api/boarding-pass') {
      request.response.write(jsonEncode({
        'pnr': 'AE-88941029',
        'flightNumber': 'AE-01',
        'passengerName': 'Mr. Alexander Vance',
        'seat': '1A',
        'zone': 'ZONE 1',
        'terminal': 'INTL 1',
        'gate': 'G14',
        'boardingTime': '10:40 AM',
        'departureDate': '24 OCT',
        'departureTime': '11:20 AM',
        'arrivalTime': '03:35 PM',
        'originCode': 'SFO',
        'destCode': 'HND',
        'duration': '11h 15m',
      }));
    } else {
      request.response.statusCode = HttpStatus.notFound;
      request.response.write(jsonEncode({'error': 'Endpoint not found'}));
    }

    await request.response.close();
  }
}

