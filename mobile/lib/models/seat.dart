class Seat {
  final String id;
  final int row;
  final String column;
  final bool isWindow;
  final bool isAisle;
  final bool isOccupied;
  final double priceDelta;
  final String? passengerName;
  final String description;

  const Seat({
    required this.id,
    required this.row,
    required this.column,
    required this.isWindow,
    required this.isAisle,
    required this.isOccupied,
    this.priceDelta = 0.0,
    this.passengerName,
    this.description = 'First Class Private Suite with direct aisle ingress.',
  });

  Seat copyWith({
    String? id,
    int? row,
    String? column,
    bool? isWindow,
    bool? isAisle,
    bool? isOccupied,
    double? priceDelta,
    String? passengerName,
    String? description,
  }) {
    return Seat(
      id: id ?? this.id,
      row: row ?? this.row,
      column: column ?? this.column,
      isWindow: isWindow ?? this.isWindow,
      isAisle: isAisle ?? this.isAisle,
      isOccupied: isOccupied ?? this.isOccupied,
      priceDelta: priceDelta ?? this.priceDelta,
      passengerName: passengerName ?? this.passengerName,
      description: description ?? this.description,
    );
  }

  static List<Seat> get defaultFirstSuites => const [
        // Row 1
        Seat(
          id: '1A',
          row: 1,
          column: 'A',
          isWindow: true,
          isAisle: true,
          isOccupied: false,
          passengerName: 'A. Vance',
          description:
              'Portside Window Sanctuary with dual panoramic dimmable windows, zero-gravity sleep mode, and direct aisle ingress.',
        ),
        Seat(
          id: '1D',
          row: 1,
          column: 'D',
          isWindow: false,
          isAisle: true,
          isOccupied: false,
          description:
              'Center Honeymoon Atelier with retractable walnut privacy partition and 82" lie-flat bed.',
        ),
        Seat(
          id: '1G',
          row: 1,
          column: 'G',
          isWindow: false,
          isAisle: true,
          isOccupied: false,
          description:
              'Center Honeymoon Atelier with retractable walnut privacy partition and 82" lie-flat bed.',
        ),
        Seat(
          id: '1K',
          row: 1,
          column: 'K',
          isWindow: true,
          isAisle: true,
          isOccupied: true,
        ),

        // Row 2
        Seat(
          id: '2A',
          row: 2,
          column: 'A',
          isWindow: true,
          isAisle: true,
          isOccupied: false,
        ),
        Seat(
          id: '2D',
          row: 2,
          column: 'D',
          isWindow: false,
          isAisle: true,
          isOccupied: true,
        ),
        Seat(
          id: '2G',
          row: 2,
          column: 'G',
          isWindow: false,
          isAisle: true,
          isOccupied: true,
        ),
        Seat(
          id: '2K',
          row: 2,
          column: 'K',
          isWindow: true,
          isAisle: true,
          isOccupied: false,
        ),

        // Row 3
        Seat(
          id: '3A',
          row: 3,
          column: 'A',
          isWindow: true,
          isAisle: true,
          isOccupied: true,
        ),
        Seat(
          id: '3D',
          row: 3,
          column: 'D',
          isWindow: false,
          isAisle: true,
          isOccupied: false,
        ),
        Seat(
          id: '3G',
          row: 3,
          column: 'G',
          isWindow: false,
          isAisle: true,
          isOccupied: false,
        ),
        Seat(
          id: '3K',
          row: 3,
          column: 'K',
          isWindow: true,
          isAisle: true,
          isOccupied: true,
        ),

        // Row 4
        Seat(
          id: '4A',
          row: 4,
          column: 'A',
          isWindow: true,
          isAisle: true,
          isOccupied: false,
        ),
        Seat(
          id: '4D',
          row: 4,
          column: 'D',
          isWindow: false,
          isAisle: true,
          isOccupied: false,
        ),
        Seat(
          id: '4G',
          row: 4,
          column: 'G',
          isWindow: false,
          isAisle: true,
          isOccupied: false,
        ),
        Seat(
          id: '4K',
          row: 4,
          column: 'K',
          isWindow: true,
          isAisle: true,
          isOccupied: false,
        ),
      ];
}

