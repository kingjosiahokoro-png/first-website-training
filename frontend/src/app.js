import { mockDestinations, mockFlights, mockSeats, mockBoardingPass } from './data/mockData.js';

// Application State
const state = {
  currentTab: 'onboarding', // 'onboarding' | 'explore' | 'flights' | 'seats' | 'passes'
  tripType: 'round', // 'round' | 'oneway'
  cabinClass: 'first', // 'first' | 'biz'
  origin: { code: 'SFO', name: 'San Francisco International' },
  dest: { code: 'HND', name: 'Tokyo Haneda' },
  flights: [...mockFlights],
  selectedFlight: mockFlights[0],
  seats: [...mockSeats],
  selectedSeat: '1A',
  boardingPass: { ...mockBoardingPass },
  isBarcodeBright: false,
};

// API Base URL (with automatic fallback to mock data)
const API_BASE = 'http://localhost:3000/api';

async function fetchFromApi(endpoint) {
  try {
    const res = await fetch(`${API_BASE}${endpoint}`);
    if (!res.ok) throw new Error(`HTTP ${res.status}`);
    return await res.json();
  } catch (err) {
    console.info(`[Aero Client] API not reachable at ${endpoint}, using built-in cache.`);
    return null;
  }
}

// Navigation & Tab Switching
function switchView(targetTab) {
  state.currentTab = targetTab;

  const views = {
    onboarding: document.getElementById('view-onboarding'),
    explore: document.getElementById('view-explore'),
    flights: document.getElementById('view-flights'),
    seats: document.getElementById('view-seats'),
    passes: document.getElementById('view-passes'),
  };

  const header = document.getElementById('app-header');
  const bottomNav = document.getElementById('bottom-nav');

  Object.entries(views).forEach(([tab, el]) => {
    if (!el) return;
    if (tab === targetTab) {
      el.classList.remove('hidden');
      el.classList.add('flex');
    } else {
      el.classList.add('hidden');
      el.classList.remove('flex');
    }
  });

  // Handle header & bottom nav visibility on onboarding
  if (targetTab === 'onboarding') {
    if (bottomNav) bottomNav.classList.add('hidden');
  } else {
    if (bottomNav) bottomNav.classList.remove('hidden');
  }

  // Update Bottom Nav active states
  document.querySelectorAll('.nav-item').forEach(button => {
    const tabName = button.getAttribute('data-tab');
    const icon = button.querySelector('.material-symbols-outlined');
    const label = button.querySelector('span:last-child');

    if (tabName === targetTab) {
      button.classList.remove('text-on-surface-variant');
      button.classList.add('text-primary');
      if (label) {
        label.classList.add('font-semibold');
      }
    } else {
      button.classList.remove('text-primary');
      button.classList.add('text-on-surface-variant');
      if (label) {
        label.classList.remove('font-semibold');
      }
    }
  });

  // Scroll to top of main container
  const mainContent = document.getElementById('main-content');
  if (mainContent) mainContent.scrollTop = 0;
}

// Render Curated Destinations
function renderDestinations() {
  const container = document.getElementById('destinations-carousel');
  if (!container) return;

  container.innerHTML = mockDestinations.map(d => `
    <div class="dest-card min-w-[210px] bg-surface-low rounded-2xl overflow-hidden border border-white/10 cursor-pointer active:scale-[0.98] transition-all flex flex-col" data-dest-id="${d.id}" data-iata="${d.iataCode}" data-city="${d.city}">
      <div class="relative h-28 w-full overflow-hidden">
        <img src="${d.imageUrl}" alt="${d.city}" class="w-full h-full object-cover transition-transform duration-500 hover:scale-105" />
        <div class="absolute inset-0 bg-gradient-to-t from-surface-low via-surface-low/30 to-transparent"></div>
        <span class="absolute top-2.5 left-2.5 glass-pill px-2 py-0.5 text-[9px] font-bold text-white uppercase">${d.iataCode}</span>
        <span class="absolute bottom-2 left-2.5 text-[11px] font-bold text-white drop-shadow">${d.aircraft}</span>
      </div>
      <div class="p-3 flex flex-col gap-1">
        <div class="flex items-center justify-between">
          <span class="text-[13px] font-bold text-white">${d.city}</span>
          <span class="text-[13px] font-bold text-secondary">$${d.fromPrice.toLocaleString()}</span>
        </div>
        <div class="flex items-center justify-between text-[10px] text-on-surface-variant">
          <span>${d.duration}</span>
          <span class="text-primary font-medium">From SFO</span>
        </div>
      </div>
    </div>
  `).join('');

  container.querySelectorAll('.dest-card').forEach(card => {
    card.addEventListener('click', () => {
      const iata = card.getAttribute('data-iata');
      const city = card.getAttribute('data-city');
      state.dest = { code: iata, name: city };

      const destCodeEl = document.getElementById('route-dest-code');
      const destNameEl = document.getElementById('route-dest-name');
      if (destCodeEl) destCodeEl.textContent = iata;
      if (destNameEl) destNameEl.textContent = city;

      switchView('flights');
    });
  });
}

// Render Flights List
function renderFlights() {
  const container = document.getElementById('flights-container');
  if (!container) return;

  container.innerHTML = state.flights.map((flight, idx) => `
    <div class="flight-card glass-panel p-4 border ${flight.isSignature ? 'border-primary/40 bg-surface-low/90' : 'border-white/10 bg-surface-low/60'} rounded-2xl cursor-pointer active:scale-[0.99] transition-all flex flex-col gap-3" data-flight-index="${idx}">
      ${flight.isSignature ? `
        <div class="flex items-center justify-between">
          <span class="glass-pill px-2.5 py-0.5 text-[9px] font-bold text-primary uppercase tracking-wider flex items-center gap-1">
            <span class="w-1.5 h-1.5 rounded-full bg-primary-container"></span>
            Aero Flagship Signature
          </span>
          <span class="text-[10px] font-semibold text-secondary">Private Atelier</span>
        </div>
      ` : `
        <div class="flex items-center justify-between">
          <span class="px-2 py-0.5 rounded-md bg-surface-high text-[9px] font-medium text-on-surface-variant">${flight.flightNumber}</span>
          <span class="text-[10px] text-on-surface-variant">${flight.aircraft}</span>
        </div>
      `}

      <!-- Timing row -->
      <div class="flex items-center justify-between">
        <div class="flex flex-col">
          <span class="text-[20px] font-bold text-white leading-none">${flight.departureTime}</span>
          <span class="text-[10px] text-on-surface-variant mt-0.5">${flight.originCode} • ${flight.originName.split(' ')[0]}</span>
        </div>
        
        <div class="flex flex-col items-center px-2 flex-1">
          <span class="text-[9.5px] text-on-surface-variant font-medium">${flight.duration}</span>
          <div class="w-full flex items-center gap-1 my-0.5">
            <span class="w-1 h-1 rounded-full bg-primary"></span>
            <div class="flex-1 h-[1px] bg-white/20"></div>
            <span class="material-symbols-outlined text-[13px] text-primary">flight</span>
            <div class="flex-1 h-[1px] bg-white/20"></div>
            <span class="w-1 h-1 rounded-full bg-secondary"></span>
          </div>
          <span class="text-[8.5px] font-bold text-secondary uppercase">${flight.isDirect ? 'Non-Stop' : '1 Stop'}</span>
        </div>

        <div class="flex flex-col items-end">
          <span class="text-[20px] font-bold text-white leading-none">${flight.arrivalTime} <span class="text-[11px] text-secondary font-bold">${flight.nextDay || ''}</span></span>
          <span class="text-[10px] text-on-surface-variant mt-0.5">${flight.destCode} • ${flight.destName.split(' ')[0]}</span>
        </div>
      </div>

      <!-- Amenities & Fare -->
      <div class="flex items-center justify-between pt-2 border-t border-white/[0.06]">
        <div class="flex items-center gap-2">
          ${flight.amenities ? flight.amenities.map(a => `
            <span class="inline-flex items-center gap-1 text-[9.5px] text-on-surface-variant bg-surface-lowest px-2 py-0.5 rounded-lg border border-white/5">
              <span class="material-symbols-outlined text-[11px] text-primary">${a.icon}</span>
              ${a.title.split(' ')[0]}
            </span>
          `).join('') : ''}
        </div>
        <div class="text-right">
          <span class="text-[16px] font-black text-white">$${flight.price.toLocaleString()}</span>
        </div>
      </div>
    </div>
  `).join('');

  container.querySelectorAll('.flight-card').forEach(card => {
    card.addEventListener('click', () => {
      const idx = parseInt(card.getAttribute('data-flight-index'), 10);
      state.selectedFlight = state.flights[idx];
      switchView('seats');
    });
  });
}

// Render Seat Fuselage Matrix
function renderSeatMatrix() {
  const container = document.getElementById('seat-matrix-container');
  if (!container) return;

  const rows = ['1', '2', '3', '4'];
  const columns = ['A', 'D', 'G', 'K'];

  container.innerHTML = rows.map(row => {
    const getSeat = col => {
      const found = state.seats.find(s => s.id === `${row}${col}`);
      if (!found) return { id: `${row}${col}`, isAvailable: true };
      const isAvailable = found.isAvailable !== undefined ? found.isAvailable : !found.isOccupied;
      return { ...found, isAvailable };
    };

    const seatA = getSeat('A');
    const seatD = getSeat('D');
    const seatG = getSeat('G');
    const seatK = getSeat('K');

    const renderSeatBtn = s => {
      const isSelected = state.selectedSeat === s.id;
      let btnClasses = 'w-10 h-11 rounded-xl flex flex-col items-center justify-center font-bold text-[11px] transition-all relative ';
      
      if (!s.isAvailable) {
        btnClasses += 'bg-surface-lowest/40 text-white/20 border border-white/5 cursor-not-allowed';
      } else if (isSelected) {
        btnClasses += 'bg-primary-container text-white border-2 border-white shadow-[0_0_12px_rgba(0,113,227,0.7)] scale-105';
      } else {
        btnClasses += 'bg-surface-low hover:bg-surface-high text-white border border-white/15 cursor-pointer active:scale-95';
      }

      return `
        <button class="seat-btn ${btnClasses}" data-seat-id="${s.id}" ${!s.isAvailable ? 'disabled' : ''}>
          <span>${s.id}</span>
          ${isSelected ? '<span class="w-1 h-1 rounded-full bg-secondary absolute bottom-1"></span>' : ''}
        </button>
      `;
    };

    return `
      <div class="grid grid-cols-5 gap-2 items-center w-full">
        <div class="flex justify-center">${renderSeatBtn(seatA)}</div>
        <div class="flex justify-center text-[10px] text-white/20 font-mono">${row}</div>
        <div class="flex justify-center gap-1.5">
          ${renderSeatBtn(seatD)}
          ${renderSeatBtn(seatG)}
        </div>
        <div class="flex justify-center text-[10px] text-white/20 font-mono">${row}</div>
        <div class="flex justify-center">${renderSeatBtn(seatK)}</div>
      </div>
    `;
  }).join('');

  // Update label
  const label = document.getElementById('selected-seat-label');
  if (label) label.textContent = state.selectedSeat;

  const confirmBtn = document.getElementById('confirm-suite-btn');
  if (confirmBtn) {
    confirmBtn.innerHTML = `<span>Confirm Suite ${state.selectedSeat}</span><span class="material-symbols-outlined text-[16px]">arrow_forward</span>`;
  }

  // Seat click listeners
  container.querySelectorAll('.seat-btn:not([disabled])').forEach(btn => {
    btn.addEventListener('click', () => {
      state.selectedSeat = btn.getAttribute('data-seat-id');
      renderSeatMatrix();
    });
  });
}

// Modal Drawer Controls
function setupModals() {
  // 360 Cabin Tour Modal
  const tourModal = document.getElementById('tour-modal');
  const tourBackdrop = document.getElementById('tour-backdrop');
  const triggerTourBtn = document.getElementById('trigger-tour-modal');
  const closeTourBtn = document.getElementById('close-tour-modal-btn');

  function openTour() {
    if (!tourModal) return;
    tourModal.classList.remove('pointer-events-none', 'opacity-0');
    tourModal.classList.add('pointer-events-auto', 'opacity-100');
    const drawer = tourModal.querySelector('div.transform');
    if (drawer) drawer.classList.remove('translate-y-full');
  }

  function closeTour() {
    if (!tourModal) return;
    const drawer = tourModal.querySelector('div.transform');
    if (drawer) drawer.classList.add('translate-y-full');
    tourModal.classList.add('opacity-0', 'pointer-events-none');
    tourModal.classList.remove('opacity-100', 'pointer-events-auto');
  }

  if (triggerTourBtn) triggerTourBtn.addEventListener('click', openTour);
  if (closeTourBtn) closeTourBtn.addEventListener('click', closeTour);
  if (tourBackdrop) tourBackdrop.addEventListener('click', closeTour);

  // Concierge Modal
  const conciergeModal = document.getElementById('concierge-modal');
  const conciergeBackdrop = document.getElementById('concierge-backdrop');
  const openConciergeBtn = document.getElementById('open-concierge-btn');
  const closeConciergeBtn = document.getElementById('close-concierge-modal-btn');

  function openConcierge() {
    if (!conciergeModal) return;
    conciergeModal.classList.remove('pointer-events-none', 'opacity-0');
    conciergeModal.classList.add('pointer-events-auto', 'opacity-100');
    const drawer = conciergeModal.querySelector('div.transform');
    if (drawer) drawer.classList.remove('translate-y-full');
  }

  function closeConcierge() {
    if (!conciergeModal) return;
    const drawer = conciergeModal.querySelector('div.transform');
    if (drawer) drawer.classList.add('translate-y-full');
    conciergeModal.classList.add('opacity-0', 'pointer-events-none');
    conciergeModal.classList.remove('opacity-100', 'pointer-events-auto');
  }

  if (openConciergeBtn) openConciergeBtn.addEventListener('click', openConcierge);
  if (closeConciergeBtn) closeConciergeBtn.addEventListener('click', closeConcierge);
  if (conciergeBackdrop) conciergeBackdrop.addEventListener('click', closeConcierge);
}

// Barcode Brightness Toggle
function setupBarcodeToggle() {
  const barcodeCard = document.getElementById('barcode-card');
  const barcodeHint = document.getElementById('barcode-hint');
  const aztecSvg = document.getElementById('aztec-svg');

  if (barcodeCard) {
    barcodeCard.addEventListener('click', () => {
      state.isBarcodeBright = !state.isBarcodeBright;
      if (state.isBarcodeBright) {
        barcodeCard.classList.remove('bg-surface-highest/80');
        barcodeCard.classList.add('bg-white', 'p-6', 'shadow-[0_0_30px_rgba(255,255,255,0.8)]');
        if (aztecSvg) aztecSvg.classList.replace('text-on-surface', 'text-black');
        if (barcodeHint) {
          barcodeHint.textContent = 'Maximum Brightness (Scanner Ready)';
          barcodeHint.classList.replace('text-on-surface-variant', 'text-gray-800');
        }
      } else {
        barcodeCard.classList.add('bg-surface-highest/80');
        barcodeCard.classList.remove('bg-white', 'p-6', 'shadow-[0_0_30px_rgba(255,255,255,0.8)]');
        if (aztecSvg) aztecSvg.classList.replace('text-black', 'text-on-surface');
        if (barcodeHint) {
          barcodeHint.textContent = 'Tap barcode to brighten';
          barcodeHint.classList.replace('text-gray-800', 'text-on-surface-variant');
        }
      }
    });
  }

  const walletBtn = document.getElementById('wallet-btn');
  if (walletBtn) {
    walletBtn.addEventListener('click', () => {
      const origHtml = walletBtn.innerHTML;
      walletBtn.innerHTML = `
        <span class="material-symbols-outlined text-[18px] text-secondary">check_circle</span>
        <span class="text-secondary font-bold">Pass Added to Wallet</span>
      `;
      setTimeout(() => {
        walletBtn.innerHTML = origHtml;
      }, 2500);
    });
  }
}

// Setup Interactive Action Listeners
function setupActions() {
  // Onboarding -> Explore
  const beginBtn = document.getElementById('begin-journey-btn');
  if (beginBtn) {
    beginBtn.addEventListener('click', () => switchView('explore'));
  }

  // Explore -> Flights
  const searchBtn = document.getElementById('search-routes-btn');
  if (searchBtn) {
    searchBtn.addEventListener('click', () => switchView('flights'));
  }

  // Seats -> Passes
  const confirmSuiteBtn = document.getElementById('confirm-suite-btn');
  if (confirmSuiteBtn) {
    confirmSuiteBtn.addEventListener('click', () => switchView('passes'));
  }

  // Swap Airports
  const swapBtn = document.getElementById('swap-airports-btn');
  if (swapBtn) {
    swapBtn.addEventListener('click', () => {
      const temp = { ...state.origin };
      state.origin = { ...state.dest };
      state.dest = temp;

      const originCodeEl = document.getElementById('route-origin-code');
      const originNameEl = document.getElementById('route-origin-name');
      const destCodeEl = document.getElementById('route-dest-code');
      const destNameEl = document.getElementById('route-dest-name');

      if (originCodeEl) originCodeEl.textContent = state.origin.code;
      if (originNameEl) originNameEl.textContent = state.origin.name;
      if (destCodeEl) destCodeEl.textContent = state.dest.code;
      if (destNameEl) destNameEl.textContent = state.dest.name;
    });
  }

  // Trip Type Toggles
  const tripRound = document.getElementById('trip-round');
  const tripOneway = document.getElementById('trip-oneway');
  const returnDateBox = document.getElementById('return-date-box');

  if (tripRound && tripOneway) {
    tripRound.addEventListener('click', () => {
      state.tripType = 'round';
      tripRound.className = 'px-3 py-1 rounded-full text-[11px] font-semibold bg-surface-high text-white transition-all';
      tripOneway.className = 'px-3 py-1 rounded-full text-[11px] font-medium text-on-surface-variant transition-all';
      if (returnDateBox) returnDateBox.style.opacity = '1';
    });

    tripOneway.addEventListener('click', () => {
      state.tripType = 'oneway';
      tripOneway.className = 'px-3 py-1 rounded-full text-[11px] font-semibold bg-surface-high text-white transition-all';
      tripRound.className = 'px-3 py-1 rounded-full text-[11px] font-medium text-on-surface-variant transition-all';
      if (returnDateBox) returnDateBox.style.opacity = '0.35';
    });
  }

  // Cabin Experience Toggles
  const cabinFirst = document.getElementById('cabin-first');
  const cabinBiz = document.getElementById('cabin-biz');

  if (cabinFirst && cabinBiz) {
    cabinFirst.addEventListener('click', () => {
      state.cabinClass = 'first';
      cabinFirst.className = 'p-2.5 rounded-xl bg-surface-lowest border border-secondary/40 text-left flex items-center justify-between opacity-100';
      cabinBiz.className = 'p-2.5 rounded-xl bg-surface-lowest/50 border border-transparent text-left flex items-center justify-between opacity-60';
    });

    cabinBiz.addEventListener('click', () => {
      state.cabinClass = 'biz';
      cabinBiz.className = 'p-2.5 rounded-xl bg-surface-lowest border border-primary/40 text-left flex items-center justify-between opacity-100';
      cabinFirst.className = 'p-2.5 rounded-xl bg-surface-lowest/50 border border-transparent text-left flex items-center justify-between opacity-60';
    });
  }

  // Bottom Navigation item clicks
  document.querySelectorAll('.nav-item').forEach(btn => {
    btn.addEventListener('click', () => {
      const tab = btn.getAttribute('data-tab');
      if (tab) switchView(tab);
    });
  });
}

// Initializer
async function init() {
  setupActions();
  setupModals();
  setupBarcodeToggle();

  renderDestinations();
  renderFlights();
  renderSeatMatrix();

  // Try asynchronous fetch to MongoDB-backed server if running
  const apiFlights = await fetchFromApi('/flights');
  if (apiFlights && Array.isArray(apiFlights) && apiFlights.length > 0) {
    state.flights = apiFlights;
    renderFlights();
  }

  const apiSeats = await fetchFromApi('/seats');
  if (apiSeats && Array.isArray(apiSeats) && apiSeats.length > 0) {
    state.seats = apiSeats;
    renderSeatMatrix();
  }

  // Default to onboarding screen
  switchView('onboarding');
}

document.addEventListener('DOMContentLoaded', init);
