import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../../core/widgets/royal_header.dart';
import '../../viewmodels/navigation_viewmodel.dart';
import '../explore/explore_view.dart';
import '../flights/flight_options_view.dart';
import '../seats/seat_selector_view.dart';
import '../boarding_pass/boarding_pass_view.dart';
import 'concierge_sheet.dart';

class MainScaffoldView extends StatefulWidget {
  const MainScaffoldView({super.key});

  @override
  State<MainScaffoldView> createState() => _MainScaffoldViewState();
}

class _MainScaffoldViewState extends State<MainScaffoldView> {
  final List<Widget> _screens = const [
    ExploreView(),
    FlightOptionsView(),
    SeatSelectorView(),
    BoardingPassView(),
  ];

  @override
  Widget build(BuildContext context) {
    final navVm = context.watch<NavigationViewModel>();

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: RoyalHeader(
        onConciergeTap: () => _openConcierge(context),
        onProfileTap: () => _openConcierge(context),
      ),
      body: Stack(
        children: [
          // Screens Stack
          IndexedStack(
            index: navVm.currentTabIndex,
            children: _screens,
          ),

          // Bottom Glass Navigation Bar
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: _buildBottomNav(context, navVm),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNav(BuildContext context, NavigationViewModel navVm) {
    final bottomPadding = MediaQuery.of(context).padding.bottom;

    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 25, sigmaY: 25),
        child: Container(
          padding: EdgeInsets.only(
            bottom: bottomPadding > 0 ? bottomPadding : 12,
            top: 10,
          ),
          decoration: BoxDecoration(
            color: AppColors.surface.withValues(alpha: 0.88),
            border: const Border(
              top: BorderSide(
                color: AppColors.borderSubtle,
                width: 1,
              ),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.4),
                blurRadius: 20,
                offset: const Offset(0, -4),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(
                index: 0,
                icon: Icons.connecting_airports,
                label: 'Explore',
                isSelected: navVm.currentTabIndex == 0,
                onTap: () => navVm.setTab(0),
              ),
              _buildNavItem(
                index: 1,
                icon: Icons.travel_explore,
                label: 'Search',
                isSelected: navVm.currentTabIndex == 1,
                onTap: () => navVm.setTab(1),
              ),
              _buildNavItem(
                index: 2,
                icon: Icons.airline_seat_recline_extra,
                label: 'Seats',
                isSelected: navVm.currentTabIndex == 2,
                onTap: () => navVm.setTab(2),
              ),
              _buildNavItem(
                index: 3,
                icon: Icons.confirmation_number_outlined,
                label: 'Passes',
                isSelected: navVm.currentTabIndex == 3,
                onTap: () => navVm.setTab(3),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required int index,
    required IconData icon,
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        constraints: const BoxConstraints(minWidth: 64, minHeight: 44),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 24,
              color: isSelected
                  ? AppColors.primaryContainer
                  : AppColors.onSurfaceVariant,
            ),
            const SizedBox(height: 3),
            Text(
              label,
              style: AppTypography.labelSm.copyWith(
                color: isSelected
                    ? AppColors.primaryContainer
                    : AppColors.onSurfaceVariant,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                fontSize: 10,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _openConcierge(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const ConciergeSheet(),
    );
  }
}

