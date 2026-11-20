# Royal Logistics — Backend Services

This directory contains the backend REST API services for the Royal Logistics aviation booking platform.

## Architecture

- **`src/`**: Node.js / Express API service with JSON mock datastore.
- **`bin/server.dart`**: Standalone zero-dependency Dart HTTP server utilizing `dart:io`.

## Endpoints

### 1. Flights
- `GET /api/flights`: Retrieve curated flights with optional `origin` and `dest` query parameters.
- `GET /api/flights/:flightNumber`: Get detailed flight profile, aircraft airframe, and amenities.

### 2. Seats
- `GET /api/seats`: Retrieve real-time fuselage seat map (4x4 matrix, couple suites, and window sanctuaries).
- `POST /api/seats/select`: Reserve a suite (e.g. `1A`) for a passenger.

### 3. Bookings & Boarding Passes
- `GET /api/boarding-pass/:pnr`: Fetch confirmed digital boarding pass with gate, terminal, and departure telemetry.
- `POST /api/bookings`: Create a new reservation and generate a unique PNR.

### 4. Concierge Dispatch
- `POST /api/concierge/requests`: Submit white-glove service requests (Tarmac Rolls-Royce transfer, Vintage Dom Pérignon cellar, Penthouse luggage delivery).

## Running the Backend

### Option A: Using Node.js
```bash
npm install
npm start
```
Runs by default on port `3000`.

### Option B: Using Standalone Dart Server
```bash
& "C:\Users\USER\Downloads\flutter\bin\cache\dart-sdk\bin\dart.exe" run bin/server.dart
```
Runs by default on port `4000`.

