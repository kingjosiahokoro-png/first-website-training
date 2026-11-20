import 'package:flutter/foundation.dart';
import '../models/flight.dart';
import '../models/seat.dart';
import '../models/destination.dart';
import '../models/boarding_pass.dart';
import '../services/api_service.dart';

enum TripType { roundTrip, oneWay }
enum CabinExperience { firstSuite, businessPod }

class BookingViewModel extends ChangeNotifier {
  final ApiService _apiService = ApiService();

  // Search state
  TripType _tripType = TripType.roundTrip;
  String _originCode = 'SFO';
  String _originName = 'San Francisco International';
  String _destCode = 'HND';
  String _destName = 'Tokyo Haneda';
  final String _departureDate = 'Oct 24, 2025';
  final String _departureDay = 'Friday';
  final String _returnDate = 'Nov 04, 2025';
  final String _returnDay = 'Tuesday';
  final int _guestCount = 1;
  CabinExperience _cabinExperience = CabinExperience.firstSuite;

  // Filter & Fare date
  String _selectedFareDate = 'Fri, Oct 24';
  String _selectedFilter = 'Nonstop only';

  // Flights
  List<Flight> _flights = List.from(Flight.sampleFlights);
  late Flight _selectedFlight;
  bool _isLoadingFlights = false;

  // Seats
  List<Seat> _seats = List.from(Seat.defaultFirstSuites);
  late Seat _selectedSeat;
  String _activeDeck = 'suites';
  bool _isLoadingSeats = false;

  // Boarding Pass
  late BoardingPass _boardingPass;
  bool _isWalletAdded = false;
  bool _isBarcodeBrightened = false;

  // Interactive Cabin Tour Modal
  bool _isTourModalOpen = false;
  bool _isTourPlaying = true;
  bool _isSpatialAudioOn = true;
  int? _activeHotspotIndex;
  double _tourProgress = 0.32;

  // Online Cloud Status
  bool _isBackendConnected = false;

  BookingViewModel() {
    _selectedFlight = _flights.first;
    _selectedSeat = _seats.firstWhere((s) => s.id == '1A');
    _boardingPass = BoardingPass.sample;
    initCloudData();
  }

  // Getters
  TripType get tripType => _tripType;
  String get originCode => _originCode;
  String get originName => _originName;
  String get destCode => _destCode;
  String get destName => _destName;
  String get departureDate => _departureDate;
  String get departureDay => _departureDay;
  String get returnDate => _returnDate;
  String get returnDay => _returnDay;
  int get guestCount => _guestCount;
  CabinExperience get cabinExperience => _cabinExperience;
  String get selectedFareDate => _selectedFareDate;
  String get selectedFilter => _selectedFilter;
  List<Flight> get flights => _flights;
  Flight get selectedFlight => _selectedFlight;
  List<Seat> get seats => _seats;
  Seat get selectedSeat => _selectedSeat;
  String get activeDeck => _activeDeck;
  BoardingPass get boardingPass => _boardingPass;
  bool get isWalletAdded => _isWalletAdded;
  bool get isBarcodeBrightened => _isBarcodeBrightened;
  bool get isTourModalOpen => _isTourModalOpen;
  bool get isTourPlaying => _isTourPlaying;
  bool get isSpatialAudioOn => _isSpatialAudioOn;
  int? get activeHotspotIndex => _activeHotspotIndex;
  double get tourProgress => _tourProgress;
  bool get isBackendConnected => _isBackendConnected;
  bool get isLoadingFlights => _isLoadingFlights;
  bool get isLoadingSeats => _isLoadingSeats;

  List<Destination> get curatedDestinations => Destination.curatedDestinations;

  double get totalAirfare {
    return _selectedFlight.price + _selectedSeat.priceDelta;
  }

  // Cloud Synchronization
  Future<void> initCloudData() async {
    final health = await _apiService.checkHealth();
    if (health != null && health['status'] == 'healthy') {
      _isBackendConnected = true;
      notifyListeners();
      await Future.wait([refreshFlights(), refreshSeats(), refreshActiveBooking()]);
    }
  }

  Future<void> refreshFlights() async {
    _isLoadingFlights = true;
    notifyListeners();
    try {
      final fetchedFlights = await _apiService.getFlights();
      if (fetchedFlights.isNotEmpty) {
        _flights = fetchedFlights;
        if (!_flights.any((f) => f.flightNumber == _selectedFlight.flightNumber)) {
          _selectedFlight = _flights.first;
        }
      }
    } finally {
      _isLoadingFlights = false;
      notifyListeners();
    }
  }

  Future<void> refreshSeats() async {
    _isLoadingSeats = true;
    notifyListeners();
    try {
      final fetchedSeats = await _apiService.getSeats();
      if (fetchedSeats.isNotEmpty) {
        _seats = fetchedSeats;
        if (!_seats.any((s) => s.id == _selectedSeat.id)) {
          _selectedSeat = _seats.firstWhere((s) => !s.isOccupied, orElse: () => _seats.first);
        }
      }
    } finally {
      _isLoadingSeats = false;
      notifyListeners();
    }
  }

  Future<void> refreshActiveBooking() async {
    final active = await _apiService.getActiveBoardingPass();
    if (active != null) {
      _boardingPass = active;
      _isWalletAdded = active.isWalletAdded;
      notifyListeners();
    }
  }

  // Actions
  void setTripType(TripType type) {
    if (_tripType != type) {
      _tripType = type;
      notifyListeners();
    }
  }

  void swapAirports() {
    final tempCode = _originCode;
    final tempName = _originName;
    _originCode = _destCode;
    _originName = _destName;
    _destCode = tempCode;
    _destName = tempName;
    notifyListeners();
  }

  void setCabinExperience(CabinExperience experience) {
    if (_cabinExperience != experience) {
      _cabinExperience = experience;
      notifyListeners();
    }
  }

  void setFareDate(String fareDate) {
    _selectedFareDate = fareDate;
    notifyListeners();
  }

  void setFilter(String filter) {
    _selectedFilter = filter;
    notifyListeners();
  }

  void selectFlight(Flight flight) {
    _selectedFlight = flight;
    _syncBoardingPass();
    notifyListeners();
  }

  void selectSeat(Seat seat) {
    if (seat.isOccupied) return;
    _selectedSeat = seat;
    _syncBoardingPass();
    notifyListeners();
  }

  Future<void> confirmCurrentBooking() async {
    final confirmed = await _apiService.createBooking(
      flightNumber: _selectedFlight.flightNumber,
      seatId: _selectedSeat.id,
      passengerName: 'Mr. Alexander Vance',
      originCode: _originCode,
      destCode: _destCode,
    );

    if (confirmed != null) {
      _boardingPass = confirmed;
      await refreshSeats();
    } else {
      _syncBoardingPass();
    }
    notifyListeners();
  }

  Future<bool> requestConciergeService(String requestType, {String notes = ''}) async {
    return await _apiService.sendConciergeRequest(
      requestType: requestType,
      notes: notes,
      pnr: _boardingPass.pnr,
      passengerName: _boardingPass.passengerName,
    );
  }

  void setActiveDeck(String deck) {
    _activeDeck = deck;
    notifyListeners();
  }

  void toggleAppleWallet() {
    _isWalletAdded = !_isWalletAdded;
    _boardingPass = _boardingPass.copyWith(isWalletAdded: _isWalletAdded);
    notifyListeners();
  }

  void toggleBarcodeBrightness() {
    _isBarcodeBrightened = !_isBarcodeBrightened;
    notifyListeners();
  }

  void openTourModal() {
    _isTourModalOpen = true;
    _isTourPlaying = true;
    _activeHotspotIndex = 0;
    notifyListeners();
  }

  void closeTourModal() {
    _isTourModalOpen = false;
    _isTourPlaying = false;
    notifyListeners();
  }

  void toggleTourPlay() {
    _isTourPlaying = !_isTourPlaying;
    notifyListeners();
  }

  void toggleTourPlayPause() {
    _isTourPlaying = !_isTourPlaying;
    notifyListeners();
  }

  void setTourProgress(double progress) {
    _tourProgress = progress;
    notifyListeners();
  }

  void selectHotspot(int index) {
    _activeHotspotIndex = index;
    notifyListeners();
  }

  void toggleSpatialAudio() {
    _isSpatialAudioOn = !_isSpatialAudioOn;
    notifyListeners();
  }

  void setActiveHotspot(int index) {
    _activeHotspotIndex = index;
    notifyListeners();
  }

  void _syncBoardingPass() {
    _boardingPass = _boardingPass.copyWith(
      flightNumber: _selectedFlight.flightNumber,
      flightTitle: _selectedFlight.title,
      originCode: _originCode,
      destCode: _destCode,
      seat: _selectedSeat.id,
      departureTime: _selectedFlight.departureTime,
      arrivalTime: _selectedFlight.arrivalTime,
      duration: _selectedFlight.duration,
    );
  }
}
