import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../../core/widgets/route_vector.dart';
import '../../core/widgets/royal_button.dart';
import '../../models/flight.dart';
import '../../viewmodels/booking_viewmodel.dart';
import '../../viewmodels/navigation_viewmodel.dart';

class FlightOptionsView extends StatelessWidget {
  const FlightOptionsView({super.key});

  @override
  Widget build(BuildContext context) {
    final bookingVm = context.watch<BookingViewModel>();
    final navVm = context.watch<NavigationViewModel>();

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.only(bottom: 100),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Query Bar Capsule
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 8),
            child: Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: AppColors.surfaceContainerLow,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: AppColors.borderSubtle,
                  width: 1,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            bookingVm.originCode,
                            style: AppTypography.headlineLgMobile.copyWith(
                              fontWeight: FontWeight.w700,
                              color: AppColors.onSurface,
                            ),
                          ),
                          const SizedBox(width: 6),
                          const Icon(
                            Icons.arrow_forward_rounded,
                            size: 16,
                            color: AppColors.primary,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            bookingVm.destCode,
                            style: AppTypography.headlineLgMobile.copyWith(
                              fontWeight: FontWeight.w700,
                              color: AppColors.onSurface,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            width: 6,
                            height: 6,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.secondary,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 2),
                      Row(
                        children: [
                          Text(
                            'Fri, Oct 24',
                            style: AppTypography.labelSm.copyWith(
                              color: AppColors.onSurfaceVariant,
                            ),
                          ),
                          const Text(' • ',
                              style: TextStyle(color: Colors.white24)),
                          Text(
                            '1 Traveler',
                            style: AppTypography.labelSm.copyWith(
                              color: AppColors.onSurfaceVariant,
                            ),
                          ),
                          const Text(' • ',
                              style: TextStyle(color: Colors.white24)),
                          Text(
                            'First Suite',
                            style: AppTypography.labelSm.copyWith(
                              color: AppColors.secondary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Container(
                    width: 38,
                    height: 38,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.surfaceContainerHigh,
                    ),
                    alignment: Alignment.center,
                    child: const Icon(
                      Icons.tune_rounded,
                      size: 18,
                      color: AppColors.onSurface,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Tokyo Destination Dispatch Glimpse
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
            child: Container(
              height: 90,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                image: const DecorationImage(
                  image: NetworkImage(
                    'https://images.unsplash.com/photo-1503899036084-c55cdd92da26?auto=format&fit=crop&w=800&q=80',
                  ),
                  fit: BoxFit.cover,
                ),
              ),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  gradient: LinearGradient(
                    colors: [
                      AppColors.surface.withValues(alpha: 0.92),
                      AppColors.surface.withValues(alpha: 0.5),
                      Colors.transparent,
                    ],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                ),
                alignment: Alignment.centerLeft,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'DESTINATION DISPATCH',
                      style: AppTypography.labelSm.copyWith(
                        color: AppColors.secondary,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1.2,
                        fontSize: 9,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'Tokyo Haneda (HND)',
                      style: AppTypography.titleMd.copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppColors.onSurface,
                      ),
                    ),
                    Text(
                      'Clear skies • 19°C • UTC+9',
                      style: AppTypography.labelSm.copyWith(
                        color: AppColors.onSurfaceVariant,
                        fontSize: 10.5,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Interactive Fare Scroller
          Padding(
            padding: const EdgeInsets.only(top: 14, left: 20, right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'FLEXIBLE DATES • LOWEST FARE',
                  style: AppTypography.labelSm.copyWith(
                    color: AppColors.onSurfaceVariant,
                    letterSpacing: 1.0,
                    fontSize: 9.5,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.calendar_month,
                      size: 13,
                      color: AppColors.primary,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'Full Month',
                      style: AppTypography.labelSm.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 8),

          // Fare Calendar Horizontal Tabs
          SizedBox(
            height: 72,
            child: ListView(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 20),
              children: [
                _buildFareTab(
                  context,
                  date: 'Thu, Oct 23',
                  price: '\$6,100',
                  badge: 'Aero Nonstop',
                  isSelected: bookingVm.selectedFareDate == 'Thu, Oct 23',
                ),
                const SizedBox(width: 8),
                _buildFareTab(
                  context,
                  date: 'Fri, Oct 24',
                  price: '\$5,850',
                  badge: 'Best Price',
                  isBestPrice: true,
                  isSelected: bookingVm.selectedFareDate == 'Fri, Oct 24',
                ),
                const SizedBox(width: 8),
                _buildFareTab(
                  context,
                  date: 'Sat, Oct 25',
                  price: '\$6,400',
                  badge: '2 Left',
                  isSelected: bookingVm.selectedFareDate == 'Sat, Oct 25',
                ),
                const SizedBox(width: 8),
                _buildFareTab(
                  context,
                  date: 'Sun, Oct 26',
                  price: '\$5,920',
                  badge: 'Aero Nonstop',
                  isSelected: bookingVm.selectedFareDate == 'Sun, Oct 26',
                ),
                const SizedBox(width: 8),
                _buildFareTab(
                  context,
                  date: 'Mon, Oct 27',
                  price: '\$6,050',
                  badge: 'Available',
                  isSelected: bookingVm.selectedFareDate == 'Mon, Oct 27',
                ),
              ],
            ),
          ),

          const SizedBox(height: 12),

          // Filter Chips
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                _buildFilterChip(
                  context,
                  label: 'Nonstop only',
                  hasDot: true,
                  isSelected: bookingVm.selectedFilter == 'Nonstop only',
                ),
                const SizedBox(width: 8),
                _buildFilterChip(
                  context,
                  label: 'Lie-flat 180°',
                  icon: Icons.bed_outlined,
                  isSelected: bookingVm.selectedFilter == 'Lie-flat 180°',
                ),
                const SizedBox(width: 8),
                _buildFilterChip(
                  context,
                  label: 'Private Suites',
                  icon: Icons.door_front_door_outlined,
                  isSelected: bookingVm.selectedFilter == 'Private Suites',
                ),
                const SizedBox(width: 8),
                _buildFilterChip(
                  context,
                  label: 'Early Morning',
                  icon: Icons.wb_twilight_rounded,
                  isSelected: bookingVm.selectedFilter == 'Early Morning',
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // Results Header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      '3 Curated Departures',
                      style: AppTypography.titleMd.copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppColors.onSurface,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.surfaceContainerHighest,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        'AERO SKYSUITE',
                        style: AppTypography.labelSm.copyWith(
                          color: AppColors.secondary,
                          fontWeight: FontWeight.w700,
                          fontSize: 9,
                        ),
                      ),
                    ),
                  ],
                ),
                Text(
                  'Sorted by Concierge',
                  style: AppTypography.labelSm.copyWith(
                    color: AppColors.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 10),

          // Flight Cards List
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 20),
            itemCount: bookingVm.flights.length,
            separatorBuilder: (_, _) => const SizedBox(height: 14),
            itemBuilder: (context, index) {
              final flight = bookingVm.flights[index];
              return _buildFlightCard(context, flight, navVm, bookingVm);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildFareTab(
    BuildContext context, {
    required String date,
    required String price,
    required String badge,
    bool isBestPrice = false,
    required bool isSelected,
  }) {
    final vm = context.read<BookingViewModel>();
    return GestureDetector(
      onTap: () => vm.setFareDate(date),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 88,
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 6),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.primaryContainer
              : AppColors.surfaceContainerLow,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: isSelected
                ? AppColors.primaryContainer
                : AppColors.borderSubtle,
            width: 1,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: AppColors.primaryContainer.withValues(alpha: 0.35),
                    blurRadius: 10,
                  ),
                ]
              : null,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              date,
              style: AppTypography.labelSm.copyWith(
                color: isSelected
                    ? Colors.white.withValues(alpha: 0.85)
                    : AppColors.onSurfaceVariant,
                fontSize: 10,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              price,
              style: AppTypography.titleMd.copyWith(
                color: isSelected ? Colors.white : AppColors.onSurface,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 1),
            Text(
              badge,
              style: AppTypography.labelSm.copyWith(
                color: isSelected
                    ? (isBestPrice ? AppColors.secondary : Colors.white70)
                    : (isBestPrice
                        ? AppColors.secondary
                        : AppColors.textMuted),
                fontWeight: FontWeight.w600,
                fontSize: 9,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterChip(
    BuildContext context, {
    required String label,
    IconData? icon,
    bool hasDot = false,
    required bool isSelected,
  }) {
    final vm = context.read<BookingViewModel>();
    return GestureDetector(
      onTap: () => vm.setFilter(label),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.surfaceContainerHighest
              : AppColors.surfaceContainerLow,
          borderRadius: BorderRadius.circular(9999),
          border: Border.all(
            color: isSelected
                ? AppColors.borderHighlight
                : AppColors.borderSubtle,
            width: 1,
          ),
        ),
        child: Row(
          children: [
            if (hasDot) ...[
              Container(
                width: 6,
                height: 6,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(width: 6),
            ] else if (icon != null) ...[
              Icon(icon, size: 14, color: AppColors.onSurfaceVariant),
              const SizedBox(width: 6),
            ],
            Text(
              label,
              style: AppTypography.labelSm.copyWith(
                color: isSelected ? Colors.white : AppColors.onSurfaceVariant,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                fontSize: 11.5,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFlightCard(
    BuildContext context,
    Flight flight,
    NavigationViewModel navVm,
    BookingViewModel bookingVm,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLow,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: AppColors.borderSubtle,
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top: Flight number & Tag
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 3,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.surfaceContainerHigh,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      flight.flightNumber,
                      style: AppTypography.labelSm.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.8,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        flight.title,
                        style: AppTypography.titleMd.copyWith(
                          fontWeight: FontWeight.w600,
                          color: AppColors.onSurface,
                          fontSize: 14.5,
                        ),
                      ),
                      Text(
                        flight.aircraft,
                        style: AppTypography.labelSm.copyWith(
                          color: AppColors.onSurfaceVariant,
                          fontSize: 9.5,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 3,
                ),
                decoration: BoxDecoration(
                  color: flight.isSignature
                      ? AppColors.secondaryContainer.withValues(alpha: 0.3)
                      : AppColors.surfaceContainerHigh,
                  borderRadius: BorderRadius.circular(9999),
                ),
                child: Row(
                  children: [
                    Icon(
                      flight.isSignature
                          ? Icons.stars_rounded
                          : Icons.bedtime_rounded,
                      size: 12,
                      color: flight.isSignature
                          ? AppColors.secondary
                          : AppColors.primary,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      flight.tag,
                      style: AppTypography.labelSm.copyWith(
                        color: flight.isSignature
                            ? AppColors.secondary
                            : AppColors.primary,
                        fontWeight: FontWeight.w600,
                        fontSize: 9.5,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Route Vector
          RouteVector(
            originCode: flight.originCode,
            destCode: flight.destCode,
            originTime: flight.departureTime,
            destTime: flight.arrivalTime,
            nextDay: flight.nextDay,
            originCity: flight.originTerminalGate,
            destCity: flight.destTerminalGate,
            duration: flight.duration,
          ),

          const SizedBox(height: 14),

          // Amenity Tray
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: AppColors.surfaceContainerHigh,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: flight.amenities.map((amenity) {
                return Row(
                  children: [
                    Icon(
                      _resolveAmenityIcon(amenity.iconName),
                      size: 14,
                      color: amenity.iconName == 'restaurant'
                          ? AppColors.secondary
                          : AppColors.primary,
                    ),
                    const SizedBox(width: 5),
                    Text(
                      amenity.title,
                      style: AppTypography.labelSm.copyWith(
                        color: AppColors.onSurface,
                        fontSize: 10.5,
                      ),
                    ),
                  ],
                );
              }).toList(),
            ),
          ),

          const SizedBox(height: 14),

          // Bottom Price & Select Action
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    flight.cabinClass,
                    style: AppTypography.labelSm.copyWith(
                      color: AppColors.onSurfaceVariant,
                      fontSize: 10,
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      Text(
                        '\$${flight.price.toInt()}',
                        style: AppTypography.headlineLgMobile.copyWith(
                          fontWeight: FontWeight.bold,
                          color: AppColors.onSurface,
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
              RoyalButton(
                label: 'Select Flight',
                height: 44,
                trailingIcon: const Icon(
                  Icons.chevron_right_rounded,
                  size: 16,
                  color: Colors.white,
                ),
                onPressed: () {
                  bookingVm.selectFlight(flight);
                  navVm.setTab(2); // Navigate directly to Seats Selector
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  IconData _resolveAmenityIcon(String iconName) {
    switch (iconName) {
      case 'wifi':
        return Icons.wifi_rounded;
      case 'restaurant':
        return Icons.restaurant_rounded;
      case 'shower':
        return Icons.shower_rounded;
      case 'bed':
        return Icons.airline_seat_flat_rounded;
      case 'wine_bar':
        return Icons.wine_bar_rounded;
      case 'headphones':
        return Icons.headphones_rounded;
      case 'directions_car':
        return Icons.directions_car_rounded;
      default:
        return Icons.star_rounded;
    }
  }
}

