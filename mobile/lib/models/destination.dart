class Destination {
  final String id;
  final String city;
  final String airportName;
  final String iataCode;
  final String duration;
  final double fromPrice;
  final String aircraft;
  final String cabinTier;
  final String imageUrl;

  const Destination({
    required this.id,
    required this.city,
    required this.airportName,
    required this.iataCode,
    required this.duration,
    required this.fromPrice,
    required this.aircraft,
    required this.cabinTier,
    required this.imageUrl,
  });

  static List<Destination> get curatedDestinations => const [
        Destination(
          id: 'hnd',
          city: 'Tokyo Haneda',
          airportName: 'Haneda International',
          iataCode: 'HND',
          duration: '11h 15m • Nonstop',
          fromPrice: 4850,
          aircraft: 'Airbus A350-1000',
          cabinTier: 'Private Suite',
          imageUrl:
              'https://images.unsplash.com/photo-1503899036084-c55cdd92da26?auto=format&fit=crop&w=800&q=80',
        ),
        Destination(
          id: 'zrh',
          city: 'Zurich Kloten',
          airportName: 'Kloten Airport',
          iataCode: 'ZRH',
          duration: '10h 40m • Nonstop',
          fromPrice: 5220,
          aircraft: 'Boeing 787-9 Dreamliner',
          cabinTier: 'Private Bar',
          imageUrl:
              'https://images.unsplash.com/photo-1515488764276-beab7607c1e6?auto=format&fit=crop&w=800&q=80',
        ),
        Destination(
          id: 'lhr',
          city: 'London Heathrow',
          airportName: 'Heathrow Airport',
          iataCode: 'LHR',
          duration: '9h 55m • Nonstop',
          fromPrice: 4400,
          aircraft: 'Airbus A350-1000',
          cabinTier: 'Studio First',
          imageUrl:
              'https://images.unsplash.com/photo-1513635269975-59663e0ac1ad?auto=format&fit=crop&w=800&q=80',
        ),
        Destination(
          id: 'sin',
          city: 'Singapore Changi',
          airportName: 'Changi International',
          iataCode: 'SIN',
          duration: '15h 20m • Nonstop',
          fromPrice: 6100,
          aircraft: 'Airbus A350-900ULR',
          cabinTier: 'First Suite',
          imageUrl:
              'https://images.unsplash.com/photo-1525625293386-3f8f99389edd?auto=format&fit=crop&w=800&q=80',
        ),
      ];
}

