class BoardingPass {
  final String flightNumber;
  final String flightTitle;
  final String pnr;
  final String passengerName;
  final String seat;
  final String zone;
  final String cabinTier;
  final String terminal;
  final String gate;
  final String boardingTime;
  final String departureDate;
  final String departureTime;
  final String arrivalTime;
  final String originCode;
  final String originCity;
  final String destCode;
  final String destCity;
  final String duration;
  final String flightStatus;
  final String boardingCountdown;
  final bool isWalletAdded;

  const BoardingPass({
    required this.flightNumber,
    required this.flightTitle,
    required this.pnr,
    required this.passengerName,
    required this.seat,
    required this.zone,
    required this.cabinTier,
    required this.terminal,
    required this.gate,
    required this.boardingTime,
    required this.departureDate,
    required this.departureTime,
    required this.arrivalTime,
    required this.originCode,
    required this.originCity,
    required this.destCode,
    required this.destCity,
    required this.duration,
    required this.flightStatus,
    required this.boardingCountdown,
    this.isWalletAdded = false,
  });

  BoardingPass copyWith({
    String? flightNumber,
    String? flightTitle,
    String? pnr,
    String? passengerName,
    String? seat,
    String? zone,
    String? cabinTier,
    String? terminal,
    String? gate,
    String? boardingTime,
    String? departureDate,
    String? departureTime,
    String? arrivalTime,
    String? originCode,
    String? originCity,
    String? destCode,
    String? destCity,
    String? duration,
    String? flightStatus,
    String? boardingCountdown,
    bool? isWalletAdded,
  }) {
    return BoardingPass(
      flightNumber: flightNumber ?? this.flightNumber,
      flightTitle: flightTitle ?? this.flightTitle,
      pnr: pnr ?? this.pnr,
      passengerName: passengerName ?? this.passengerName,
      seat: seat ?? this.seat,
      zone: zone ?? this.zone,
      cabinTier: cabinTier ?? this.cabinTier,
      terminal: terminal ?? this.terminal,
      gate: gate ?? this.gate,
      boardingTime: boardingTime ?? this.boardingTime,
      departureDate: departureDate ?? this.departureDate,
      departureTime: departureTime ?? this.departureTime,
      arrivalTime: arrivalTime ?? this.arrivalTime,
      originCode: originCode ?? this.originCode,
      originCity: originCity ?? this.originCity,
      destCode: destCode ?? this.destCode,
      destCity: destCity ?? this.destCity,
      duration: duration ?? this.duration,
      flightStatus: flightStatus ?? this.flightStatus,
      boardingCountdown: boardingCountdown ?? this.boardingCountdown,
      isWalletAdded: isWalletAdded ?? this.isWalletAdded,
    );
  }

  static BoardingPass get sample => const BoardingPass(
        flightNumber: 'AE-01',
        flightTitle: 'Aero Flagship Nonstop',
        pnr: 'AE-88941029',
        passengerName: 'Mr. Alexander Vance',
        seat: '1A',
        zone: 'ZONE 1',
        cabinTier: 'First Class Suite',
        terminal: 'INTL 1',
        gate: 'G14',
        boardingTime: '10:40 AM',
        departureDate: '24 OCT',
        departureTime: '11:20 AM',
        arrivalTime: '03:35 PM',
        originCode: 'SFO',
        originCity: 'San Francisco',
        destCode: 'HND',
        destCity: 'Tokyo Haneda',
        duration: '11h 15m',
        flightStatus: 'Flight AE-01 • On Schedule',
        boardingCountdown: 'Boarding in 42m',
        isWalletAdded: false,
      );
}

