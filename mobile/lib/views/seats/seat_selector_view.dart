import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../../core/widgets/royal_button.dart';
import '../../models/seat.dart';
import '../../viewmodels/booking_viewmodel.dart';
import '../../viewmodels/navigation_viewmodel.dart';

class SeatSelectorView extends StatelessWidget {
  const SeatSelectorView({super.key});

  @override
  Widget build(BuildContext context) {
    final bookingVm = context.watch<BookingViewModel>();
    final navVm = context.watch<NavigationViewModel>();

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.only(bottom: 120),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header info
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 6,
                          height: 6,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.secondary,
                          ),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          'FLIGHT ${bookingVm.selectedFlight.flightNumber} • SAN FRANCISCO TO TOKYO',
                          style: AppTypography.labelSm.copyWith(
                            color: AppColors.onSurfaceVariant,
                            letterSpacing: 1.2,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Text(
                          'Suite ${bookingVm.selectedSeat.id}',
                          style: AppTypography.headlineLgMobile.copyWith(
                            fontWeight: FontWeight.w700,
                            color: AppColors.onSurface,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 3,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.surfaceContainerHigh,
                            borderRadius: BorderRadius.circular(9999),
                          ),
                          child: Text(
                            'Selected',
                            style: AppTypography.labelSm.copyWith(
                              color: AppColors.primary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      'Airbus A350-1000 • Private First Suite 1-2-1',
                      style: AppTypography.bodyMd.copyWith(
                        color: AppColors.onSurfaceVariant,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.surfaceContainerLow,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      Text(
                        'AIRFRAME',
                        style: AppTypography.labelSm.copyWith(
                          color: AppColors.onSurfaceVariant,
                          fontSize: 8.5,
                          letterSpacing: 0.8,
                        ),
                      ),
                      Text(
                        'F-WZNN',
                        style: AppTypography.titleMd.copyWith(
                          color: AppColors.secondary,
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Cabin Deck Switcher
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: AppColors.surfaceContainerLowest,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      decoration: BoxDecoration(
                        color: AppColors.surfaceContainerHigh,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.star_rounded,
                            size: 15,
                            color: AppColors.secondary,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            'First Suites (4 Rows)',
                            style: AppTypography.labelMd.copyWith(
                              color: AppColors.onSurface,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.airline_seat_recline_extra_rounded,
                            size: 15,
                            color: AppColors.onSurfaceVariant,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            'Club World (Main)',
                            style: AppTypography.labelMd.copyWith(
                              color: AppColors.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Legend Segmented Pills
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildLegendItem(
                  color: AppColors.primaryContainer,
                  label: 'Selected',
                  hasGlow: true,
                ),
                _buildLegendItem(
                  color: AppColors.surfaceBright,
                  label: 'Available',
                ),
                _buildLegendItem(
                  color: AppColors.surfaceContainerHighest.withValues(alpha: 0.4),
                  label: 'Occupied',
                ),
                _buildLegendItem(
                  icon: Icons.wine_bar_rounded,
                  iconColor: AppColors.secondary,
                  label: 'Galley',
                ),
              ],
            ),
          ),

          const SizedBox(height: 12),

          // Interactive Fuselage Frame
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.surfaceContainerLowest,
                borderRadius: BorderRadius.circular(28),
                border: Border.all(
                  color: AppColors.borderSubtle,
                  width: 1,
                ),
              ),
              child: Column(
                children: [
                  // Cockpit Nose Cone & Horizon
                  CustomPaint(
                    size: const Size(200, 48),
                    painter: CockpitNosePainter(),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.flight_takeoff,
                        size: 13,
                        color: AppColors.onSurfaceVariant,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        'FLIGHT DECK & AVIONICS',
                        style: AppTypography.labelSm.copyWith(
                          color: AppColors.onSurfaceVariant,
                          letterSpacing: 1.5,
                          fontSize: 9,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),

                  // Forward Galley & Spa Lavatory
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.surfaceContainerLow,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildFacility(
                          icon: Icons.bathtub_outlined,
                          label: 'Spa Lav',
                          color: AppColors.secondary,
                        ),
                        _buildFacility(
                          icon: Icons.room_service_outlined,
                          label: 'Curated Galley',
                          color: AppColors.tertiary,
                        ),
                        _buildFacility(
                          icon: Icons.deck_outlined,
                          label: 'Wardrobe',
                          color: AppColors.secondary,
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 14),

                  // Aisle Identifiers
                  Row(
                    children: [
                      _buildAisleHeader('A (Win)', flex: 2),
                      _buildAisleHeader('AISLE', flex: 1, isAisleText: true),
                      _buildAisleHeader('D • G', flex: 4),
                      _buildAisleHeader('AISLE', flex: 1, isAisleText: true),
                      _buildAisleHeader('K (Win)', flex: 2),
                    ],
                  ),

                  const SizedBox(height: 8),

                  // Seat Matrix: Rows 1 to 4
                  for (int r = 1; r <= 4; r++) ...[
                    _buildSeatRow(context, r, bookingVm),
                    if (r < 4) const SizedBox(height: 10),
                  ],

                  const SizedBox(height: 14),

                  // Mid-Cabin Bar Divider
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.surfaceContainerHigh.withValues(alpha: 0.6),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.wine_bar_rounded,
                              size: 15,
                              color: AppColors.secondary,
                            ),
                            const SizedBox(width: 6),
                            Text(
                              'The Aero Loft & Bar Lounge',
                              style: AppTypography.labelSm.copyWith(
                                color: AppColors.onSurfaceVariant,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          'CLUB WORLD EXIT',
                          style: AppTypography.labelSm.copyWith(
                            color: AppColors.primary,
                            fontSize: 9,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 16),

          // Portside Window Sanctuary Suite Showcase Card
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.surfaceContainerLow,
                borderRadius: BorderRadius.circular(22),
                border: Border.all(
                  color: AppColors.borderSubtle,
                  width: 1,
                ),
              ),
              clipBehavior: Clip.antiAlias,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Photo with badge
                  Stack(
                    children: [
                      SizedBox(
                        height: 140,
                        width: double.infinity,
                        child: Image.network(
                          'https://images.unsplash.com/photo-1540959733332-eab4deabeeaf?auto=format&fit=crop&w=800&q=80',
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) => Container(
                            color: AppColors.surfaceContainerHigh,
                          ),
                        ),
                      ),
                      Container(
                        height: 140,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.transparent,
                              AppColors.surfaceContainerLow,
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                        ),
                      ),
                      Positioned(
                        top: 12,
                        left: 12,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.surface.withValues(alpha: 0.85),
                            borderRadius: BorderRadius.circular(9999),
                          ),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.stars_rounded,
                                size: 14,
                                color: AppColors.secondary,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                'Aero Master Suite ${bookingVm.selectedSeat.id}',
                                style: AppTypography.labelSm.copyWith(
                                  color: AppColors.onSurface,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 4, 16, 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Portside Window Sanctuary',
                              style: AppTypography.titleMd.copyWith(
                                fontWeight: FontWeight.w600,
                                color: AppColors.onSurface,
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.surfaceContainerHighest,
                                borderRadius: BorderRadius.circular(9999),
                              ),
                              child: Text(
                                'Forward Facing',
                                style: AppTypography.labelSm.copyWith(
                                  color: AppColors.secondary,
                                  fontSize: 9.5,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          bookingVm.selectedSeat.description,
                          style: AppTypography.bodyMd.copyWith(
                            color: AppColors.onSurfaceVariant,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 14),

          // Suite Specifications Matrix (2x2)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 2.2,
              children: [
                _buildSpecBox(
                  icon: Icons.king_bed_outlined,
                  iconColor: AppColors.primary,
                  title: 'Bed Dimension',
                  value: '82" Lie-Flat',
                  sub: 'Tuft & Needle mattress',
                ),
                _buildSpecBox(
                  icon: Icons.tv_rounded,
                  iconColor: AppColors.secondary,
                  title: 'In-Flight Cinema',
                  value: '32" 4K OLED',
                  sub: 'Spatial Audio Bluetooth',
                ),
                _buildSpecBox(
                  icon: Icons.door_front_door_outlined,
                  iconColor: AppColors.tertiary,
                  title: 'Privacy Shield',
                  value: 'Sliding Door',
                  sub: 'Full acoustic damping',
                ),
                _buildSpecBox(
                  icon: Icons.kitchen_rounded,
                  iconColor: AppColors.primary,
                  title: 'Refreshment',
                  value: 'Mini Bar',
                  sub: 'Temperature-chilled',
                ),
              ],
            ),
          ),

          const SizedBox(height: 14),

          // Starlink Included Banner
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.surfaceContainerHigh,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.secondaryContainer.withValues(alpha: 0.3),
                        ),
                        alignment: Alignment.center,
                        child: const Icon(
                          Icons.wifi_rounded,
                          size: 16,
                          color: AppColors.secondary,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Starlink Aviation High-Speed',
                            style: AppTypography.titleMd.copyWith(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: AppColors.onSurface,
                            ),
                          ),
                          Text(
                            'Complimentary unmetered streaming',
                            style: AppTypography.labelSm.copyWith(
                              color: AppColors.onSurfaceVariant,
                              fontSize: 10,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Text(
                    'Included',
                    style: AppTypography.labelSm.copyWith(
                      color: AppColors.secondary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 20),

          // Persistent Booking Summary Bottom Tray
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: AppColors.surfaceContainer,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(
                  color: AppColors.borderHighlight,
                  width: 1,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.5),
                    blurRadius: 25,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'PASSENGER ALLOCATION',
                            style: AppTypography.labelSm.copyWith(
                              color: AppColors.onSurfaceVariant,
                              fontSize: 9.5,
                            ),
                          ),
                          Text(
                            'Alex Vance • 1 Guest',
                            style: AppTypography.titleMd.copyWith(
                              fontWeight: FontWeight.w600,
                              color: AppColors.onSurface,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            'TOTAL AIRFARE',
                            style: AppTypography.labelSm.copyWith(
                              color: AppColors.onSurfaceVariant,
                              fontSize: 9.5,
                            ),
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.baseline,
                            textBaseline: TextBaseline.alphabetic,
                            children: [
                              Text(
                                '\$${bookingVm.totalAirfare.toInt()}',
                                style: AppTypography.headlineLgMobile.copyWith(
                                  color: AppColors.secondary,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(width: 4),
                              Text(
                                'USD',
                                style: AppTypography.labelSm.copyWith(
                                  color: AppColors.onSurfaceVariant,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  RoyalButton(
                    label: 'Confirm Suite ${bookingVm.selectedSeat.id}',
                    trailingIcon: const Icon(
                      Icons.arrow_forward_rounded,
                      size: 18,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      navVm.setTab(3); // Navigate directly to Boarding Pass
                    },
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.verified_user_outlined,
                        size: 13,
                        color: AppColors.onSurfaceVariant,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        'Free cancellation & lounge transfer within 24 hours',
                        style: AppTypography.labelSm.copyWith(
                          color: AppColors.onSurfaceVariant,
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLegendItem({
    Color? color,
    IconData? icon,
    Color? iconColor,
    required String label,
    bool hasGlow = false,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLow,
        borderRadius: BorderRadius.circular(9999),
      ),
      child: Row(
        children: [
          if (icon != null)
            Icon(icon, size: 12, color: iconColor)
          else
            Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: color,
                boxShadow: hasGlow
                    ? [
                        BoxShadow(
                          color: color!.withValues(alpha: 0.8),
                          blurRadius: 6,
                        ),
                      ]
                    : null,
              ),
            ),
          const SizedBox(width: 6),
          Text(
            label,
            style: AppTypography.labelSm.copyWith(
              color: AppColors.onSurfaceVariant,
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFacility({
    required IconData icon,
    required String label,
    required Color color,
  }) {
    return Row(
      children: [
        Icon(icon, size: 14, color: color),
        const SizedBox(width: 4),
        Text(
          label,
          style: AppTypography.labelSm.copyWith(
            color: AppColors.onSurfaceVariant,
            fontSize: 10,
          ),
        ),
      ],
    );
  }

  Widget _buildAisleHeader(String text,
      {required int flex, bool isAisleText = false}) {
    return Expanded(
      flex: flex,
      child: Center(
        child: Text(
          text,
          style: AppTypography.labelSm.copyWith(
            color: isAisleText
                ? AppColors.surfaceContainerHighest
                : AppColors.onSurfaceVariant,
            fontSize: 9.5,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _buildSeatRow(
    BuildContext context,
    int rowNum,
    BookingViewModel vm,
  ) {
    final seatA = vm.seats.firstWhere((s) => s.id == '${rowNum}A');
    final seatD = vm.seats.firstWhere((s) => s.id == '${rowNum}D');
    final seatG = vm.seats.firstWhere((s) => s.id == '${rowNum}G');
    final seatK = vm.seats.firstWhere((s) => s.id == '${rowNum}K');

    return Row(
      children: [
        // Column A (Window)
        Expanded(
          flex: 2,
          child: _buildSeatTile(context, seatA, vm),
        ),
        // Left Aisle
        Expanded(
          flex: 1,
          child: Center(
            child: Text(
              '$rowNum',
              style: AppTypography.labelSm.copyWith(
                color: AppColors.onSurfaceVariant.withValues(alpha: 0.3),
              ),
            ),
          ),
        ),
        // Column D & G (Center Couple Suite)
        Expanded(
          flex: 4,
          child: Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: AppColors.surfaceContainerHigh,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                Expanded(child: _buildSeatTile(context, seatD, vm)),
                Container(
                  width: 2,
                  height: 24,
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  decoration: BoxDecoration(
                    color: AppColors.secondary.withValues(alpha: 0.4),
                    borderRadius: BorderRadius.circular(1),
                  ),
                ),
                Expanded(child: _buildSeatTile(context, seatG, vm)),
              ],
            ),
          ),
        ),
        // Right Aisle
        Expanded(
          flex: 1,
          child: Center(
            child: Text(
              '$rowNum',
              style: AppTypography.labelSm.copyWith(
                color: AppColors.onSurfaceVariant.withValues(alpha: 0.3),
              ),
            ),
          ),
        ),
        // Column K (Window)
        Expanded(
          flex: 2,
          child: _buildSeatTile(context, seatK, vm),
        ),
      ],
    );
  }

  Widget _buildSeatTile(
    BuildContext context,
    Seat seat,
    BookingViewModel vm,
  ) {
    final isSelected = vm.selectedSeat.id == seat.id;

    if (seat.isOccupied) {
      return Container(
        height: 60,
        decoration: BoxDecoration(
          color: AppColors.surfaceContainer.withValues(alpha: 0.5),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              seat.id,
              style: AppTypography.labelSm.copyWith(
                color: Colors.white24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Icon(
              Icons.person,
              size: 16,
              color: Colors.white24,
            ),
            Text(
              'Occupied',
              style: AppTypography.labelSm.copyWith(
                color: Colors.white24,
                fontSize: 8,
              ),
            ),
          ],
        ),
      );
    }

    return GestureDetector(
      onTap: () => vm.selectSeat(seat),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        height: 60,
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.primaryContainer
              : AppColors.surfaceBright,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: isSelected
                ? AppColors.primary
                : AppColors.borderSubtle,
            width: 1,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: AppColors.primaryContainer.withValues(alpha: 0.5),
                    blurRadius: 16,
                  ),
                ]
              : null,
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            if (isSelected)
              Positioned(
                top: 2,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
                  decoration: BoxDecoration(
                    color: AppColors.secondary,
                    borderRadius: BorderRadius.circular(9999),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.check, size: 8, color: Colors.black),
                      Text(
                        seat.id,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 8,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (!isSelected)
                  Text(
                    seat.id,
                    style: AppTypography.labelSm.copyWith(
                      color: isSelected
                          ? Colors.white
                          : AppColors.secondary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                Icon(
                  Icons.airline_seat_flat_rounded,
                  size: 18,
                  color: isSelected
                      ? Colors.white
                      : AppColors.onSurfaceVariant,
                ),
                Text(
                  isSelected ? 'A. Vance' : 'Open',
                  style: AppTypography.labelSm.copyWith(
                    color: isSelected ? Colors.white : AppColors.onSurfaceVariant,
                    fontSize: 8.5,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSpecBox({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String value,
    required String sub,
  }) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLow,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.borderSubtle,
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.surfaceContainerHigh,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, size: 18, color: iconColor),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: AppTypography.labelSm.copyWith(
                    color: AppColors.onSurfaceVariant,
                    fontSize: 9,
                  ),
                ),
                Text(
                  value,
                  style: AppTypography.titleMd.copyWith(
                    color: AppColors.onSurface,
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                ),
                Text(
                  sub,
                  style: AppTypography.labelSm.copyWith(
                    color: AppColors.onSurfaceVariant,
                    fontSize: 8.5,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CockpitNosePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.surfaceContainerHigh
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;

    final path = Path();
    path.moveTo(10, size.height);
    path.cubicTo(
      size.width * 0.1,
      size.height * 0.1,
      size.width * 0.9,
      size.height * 0.1,
      size.width - 10,
      size.height,
    );
    canvas.drawPath(path, paint);

    // Inner filled horizon
    final fillPaint = Paint()
      ..color = AppColors.surfaceContainerHigh.withValues(alpha: 0.2)
      ..style = PaintingStyle.fill;

    final fillPath = Path();
    fillPath.moveTo(35, size.height);
    fillPath.cubicTo(
      size.width * 0.25,
      size.height * 0.35,
      size.width * 0.75,
      size.height * 0.35,
      size.width - 35,
      size.height,
    );
    canvas.drawPath(fillPath, fillPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

