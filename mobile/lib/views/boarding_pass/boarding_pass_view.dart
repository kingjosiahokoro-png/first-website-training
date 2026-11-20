import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../../core/widgets/route_vector.dart';
import '../../core/widgets/status_beacon.dart';
import '../../viewmodels/booking_viewmodel.dart';
import '../../viewmodels/navigation_viewmodel.dart';

class BoardingPassView extends StatelessWidget {
  const BoardingPassView({super.key});

  @override
  Widget build(BuildContext context) {
    final bookingVm = context.watch<BookingViewModel>();
    final navVm = context.watch<NavigationViewModel>();
    final pass = bookingVm.boardingPass;

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 120),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Live Flight Status Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: AppColors.surfaceContainerHigh.withValues(alpha: 0.9),
                  borderRadius: BorderRadius.circular(9999),
                ),
                child: Row(
                  children: [
                    const StatusBeacon(
                      color: AppColors.secondary,
                      size: 4,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      pass.flightStatus.toUpperCase(),
                      style: AppTypography.labelSm.copyWith(
                        color: AppColors.onSurface,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.8,
                        fontSize: 9.5,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                pass.boardingCountdown,
                style: AppTypography.labelSm.copyWith(
                  color: AppColors.secondary,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),

          const SizedBox(height: 10),

          // Terminal & Gate Banner
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: AppColors.surfaceContainerLow,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'TERMINAL',
                      style: AppTypography.labelSm.copyWith(
                        color: AppColors.onSurfaceVariant,
                        fontSize: 9,
                        letterSpacing: 0.8,
                      ),
                    ),
                    Text(
                      pass.terminal,
                      style: AppTypography.headlineMd.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppColors.onSurface,
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'GATE',
                      style: AppTypography.labelSm.copyWith(
                        color: AppColors.onSurfaceVariant,
                        fontSize: 9,
                        letterSpacing: 0.8,
                      ),
                    ),
                    Text(
                      pass.gate,
                      style: AppTypography.headlineMd.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryContainer,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // Ultra-Luxe Aero Digital Boarding Pass Ticket
          Container(
            decoration: BoxDecoration(
              color: AppColors.surfaceContainerLowest,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: AppColors.borderHighlight,
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.6),
                  blurRadius: 30,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Column(
              children: [
                // Top Ticket Segment
                Padding(
                  padding: const EdgeInsets.all(18),
                  child: Column(
                    children: [
                      // Header Row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 34,
                                height: 34,
                                decoration: BoxDecoration(
                                  color: AppColors.surfaceContainerHighest,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                alignment: Alignment.center,
                                child: Transform.rotate(
                                  angle: -0.785398,
                                  child: const Icon(
                                    Icons.navigation_rounded,
                                    size: 16,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    pass.cabinTier.toUpperCase(),
                                    style: AppTypography.labelSm.copyWith(
                                      color: AppColors.secondary,
                                      fontWeight: FontWeight.w700,
                                      letterSpacing: 1.2,
                                      fontSize: 9,
                                    ),
                                  ),
                                  Text(
                                    'Seat ${bookingVm.selectedSeat.id} • ${pass.zone}',
                                    style: AppTypography.titleMd.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.onSurface,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.surfaceContainerHigh,
                              borderRadius: BorderRadius.circular(9999),
                            ),
                            child: Text(
                              'Priority Sky',
                              style: AppTypography.labelSm.copyWith(
                                color: AppColors.onSurfaceVariant,
                                fontWeight: FontWeight.w600,
                                fontSize: 9.5,
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 18),

                      // Route Vectors & Times
                      RouteVector(
                        originCode: pass.originCode,
                        destCode: pass.destCode,
                        originCity: pass.originCity,
                        destCity: pass.destCity,
                        originTime: pass.departureTime,
                        destTime: pass.arrivalTime,
                        nextDay: '+1',
                        duration: pass.duration,
                      ),

                      const SizedBox(height: 18),

                      // Meta Grid (Date, Gate, Boarding, Group)
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.surfaceContainer.withValues(alpha: 0.6),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _buildMetaCell(
                              'DATE',
                              pass.departureDate,
                              AppColors.onSurface,
                            ),
                            _buildMetaCell(
                              'GATE',
                              pass.gate,
                              AppColors.primary,
                            ),
                            _buildMetaCell(
                              'BOARDING',
                              pass.boardingTime,
                              AppColors.onSurface,
                            ),
                            _buildMetaCell(
                              'GROUP',
                              pass.zone,
                              AppColors.secondary,
                              alignEnd: true,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                // Perforation Tear-Line with Notches
                SizedBox(
                  height: 24,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      // Left notch cutout
                      Positioned(
                        left: -12,
                        child: Container(
                          width: 24,
                          height: 24,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.background,
                          ),
                        ),
                      ),
                      // Dashed line
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18),
                        child: LayoutBuilder(
                          builder: (context, constraints) {
                            const dashWidth = 5.0;
                            const dashSpace = 4.0;
                            final dashCount = (constraints.maxWidth /
                                    (dashWidth + dashSpace))
                                .floor();
                            return Row(
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                              children: List.generate(dashCount, (_) {
                                return SizedBox(
                                  width: dashWidth,
                                  height: 1,
                                  child: DecoratedBox(
                                    decoration: BoxDecoration(
                                      color: Colors.white.withValues(alpha: 0.2),
                                    ),
                                  ),
                                );
                              }),
                            );
                          },
                        ),
                      ),
                      // Right notch cutout
                      Positioned(
                        right: -12,
                        child: Container(
                          width: 24,
                          height: 24,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.background,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Bottom Ticket Segment (Passenger & Aztec Barcode)
                Padding(
                  padding: const EdgeInsets.all(18),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'PASSENGER',
                                style: AppTypography.labelSm.copyWith(
                                  color: AppColors.onSurfaceVariant,
                                  fontSize: 9,
                                  letterSpacing: 0.8,
                                ),
                              ),
                              Text(
                                pass.passengerName,
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
                                'TICKET / PNR',
                                style: AppTypography.labelSm.copyWith(
                                  color: AppColors.onSurfaceVariant,
                                  fontSize: 9,
                                  letterSpacing: 0.8,
                                ),
                              ),
                              Text(
                                pass.pnr,
                                style: AppTypography.titleMd.copyWith(
                                  fontFamily: 'monospace',
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),

                      const SizedBox(height: 16),

                      // Interactive Aztec Barcode Card
                      GestureDetector(
                        onTap: () => bookingVm.toggleBarcodeBrightness(),
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: bookingVm.isBarcodeBrightened
                                ? Colors.white
                                : AppColors.surfaceContainerHighest
                                    .withValues(alpha: 0.8),
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: bookingVm.isBarcodeBrightened
                                ? [
                                    const BoxShadow(
                                      color: Colors.white24,
                                      blurRadius: 20,
                                    ),
                                  ]
                                : null,
                          ),
                          child: Column(
                            children: [
                              CustomPaint(
                                size: const Size(160, 160),
                                painter: AztecCodePainter(
                                  color: bookingVm.isBarcodeBrightened
                                      ? Colors.black
                                      : AppColors.onSurface,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                bookingVm.isBarcodeBrightened
                                    ? 'TAP TO DIM BARCODE'
                                    : 'TAP BARCODE TO BRIGHTEN',
                                style: AppTypography.labelSm.copyWith(
                                  color: bookingVm.isBarcodeBrightened
                                      ? Colors.black54
                                      : AppColors.onSurfaceVariant,
                                  letterSpacing: 1.5,
                                  fontSize: 8.5,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: 16),

                      // Apple Wallet Button
                      GestureDetector(
                        onTap: () => bookingVm.toggleAppleWallet(),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          height: 52,
                          decoration: BoxDecoration(
                            color: bookingVm.isWalletAdded
                                ? AppColors.secondary.withValues(alpha: 0.15)
                                : AppColors.surfaceContainerHigh,
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(
                              color: bookingVm.isWalletAdded
                                  ? AppColors.secondary.withValues(alpha: 0.4)
                                  : AppColors.borderSubtle,
                              width: 1,
                            ),
                          ),
                          alignment: Alignment.center,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                bookingVm.isWalletAdded
                                    ? Icons.check_circle_rounded
                                    : Icons.account_balance_wallet_rounded,
                                color: bookingVm.isWalletAdded
                                    ? AppColors.secondary
                                    : Colors.white,
                                size: 20,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                bookingVm.isWalletAdded
                                    ? 'Added to Apple Wallet'
                                    : 'Add to Apple Wallet',
                                style: AppTypography.titleMd.copyWith(
                                  color: bookingVm.isWalletAdded
                                      ? AppColors.secondary
                                      : Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14.5,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // Concierge Privileges Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'CONCIERGE PRIVILEGES',
                style: AppTypography.labelSm.copyWith(
                  color: AppColors.onSurfaceVariant,
                  letterSpacing: 1.2,
                  fontWeight: FontWeight.w700,
                  fontSize: 9.5,
                ),
              ),
              Text(
                'Synced with Aircraft',
                style: AppTypography.labelSm.copyWith(
                  color: AppColors.secondary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),

          const SizedBox(height: 10),

          // Privilege 1: Polaris First Lounge
          _buildPrivilegeCard(
            context,
            icon: Icons.nightlife_rounded,
            iconColor: AppColors.secondary,
            title: 'Polaris First Lounge',
            subtitle: 'Keyless Pass Unlocked',
            hasAction: true,
            actionLabel: 'Show QR',
            onAction: () => navVm.openLoungeQr(),
          ),

          const SizedBox(height: 10),

          // Privilege 2: AirTag Luggage Tracker
          _buildPrivilegeCard(
            context,
            icon: Icons.luggage_rounded,
            iconColor: AppColors.primary,
            title: 'AirTag Luggage Tracker',
            subtitle: '2 Bags Loaded onto A350-1000',
            trailingWidget: const Icon(
              Icons.check_circle_rounded,
              color: AppColors.primary,
              size: 20,
            ),
          ),

          const SizedBox(height: 10),

          // Privilege 3: Haute Cuisine Pre-Order
          _buildPrivilegeCard(
            context,
            icon: Icons.restaurant_rounded,
            iconColor: AppColors.tertiary,
            title: 'Haute Cuisine Pre-Order',
            subtitle: 'Wagyu Ribeye & Royal Osetra Caviar',
            trailingWidget: const Icon(
              Icons.chevron_right_rounded,
              color: AppColors.onSurfaceVariant,
              size: 20,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMetaCell(String label, String value, Color valueColor,
      {bool alignEnd = false}) {
    return Column(
      crossAxisAlignment:
          alignEnd ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTypography.labelSm.copyWith(
            color: AppColors.onSurfaceVariant,
            fontSize: 9,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          value,
          style: AppTypography.titleMd.copyWith(
            color: valueColor,
            fontWeight: FontWeight.bold,
            fontSize: 13.5,
          ),
        ),
      ],
    );
  }

  Widget _buildPrivilegeCard(
    BuildContext context, {
    required IconData icon,
    required Color iconColor,
    required String title,
    required String subtitle,
    bool hasAction = false,
    String? actionLabel,
    VoidCallback? onAction,
    Widget? trailingWidget,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
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
          Row(
            children: [
              Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  color: AppColors.surfaceContainerHigh,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, color: iconColor, size: 20),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTypography.titleMd.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppColors.onSurface,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: AppTypography.labelSm.copyWith(
                      color: AppColors.onSurfaceVariant,
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
            ],
          ),
          if (hasAction && actionLabel != null)
            GestureDetector(
              onTap: onAction,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: AppColors.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  actionLabel,
                  style: AppTypography.labelSm.copyWith(
                    color: AppColors.onSurface,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            )
          else
            ?trailingWidget,
        ],
      ),
    );
  }
}

/// Custom Aztec 2D Matrix Painter
class AztecCodePainter extends CustomPainter {
  final Color color;

  AztecCodePainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    const gridSize = 16;
    final cellSize = size.width / gridSize;

    // Pattern for Aztec bullseye and corners
    final pattern = [
      [1, 1, 1, 1, 0, 1, 0, 1, 1, 0, 1, 0, 1, 1, 1, 1],
      [1, 0, 0, 1, 0, 0, 1, 0, 0, 1, 0, 0, 1, 0, 0, 1],
      [1, 0, 1, 1, 1, 0, 0, 1, 1, 0, 0, 1, 1, 1, 0, 1],
      [1, 1, 1, 0, 1, 1, 0, 0, 0, 0, 1, 1, 0, 1, 1, 1],
      [0, 0, 1, 1, 0, 1, 1, 1, 1, 1, 1, 0, 1, 1, 0, 0],
      [1, 0, 0, 1, 1, 1, 0, 0, 0, 0, 1, 1, 1, 0, 0, 1],
      [0, 1, 0, 0, 1, 0, 1, 1, 1, 1, 0, 1, 0, 0, 1, 0],
      [1, 0, 1, 0, 1, 0, 1, 0, 0, 1, 0, 1, 0, 1, 0, 1],
      [1, 0, 1, 0, 1, 0, 1, 0, 0, 1, 0, 1, 0, 1, 0, 1],
      [0, 1, 0, 0, 1, 0, 1, 1, 1, 1, 0, 1, 0, 0, 1, 0],
      [1, 0, 0, 1, 1, 1, 0, 0, 0, 0, 1, 1, 1, 0, 0, 1],
      [0, 0, 1, 1, 0, 1, 1, 1, 1, 1, 1, 0, 1, 1, 0, 0],
      [1, 1, 1, 0, 1, 1, 0, 0, 0, 0, 1, 1, 0, 1, 1, 1],
      [1, 0, 1, 1, 1, 0, 0, 1, 1, 0, 0, 1, 1, 1, 0, 1],
      [1, 0, 0, 1, 0, 0, 1, 0, 0, 1, 0, 0, 1, 0, 0, 1],
      [1, 1, 1, 1, 0, 1, 0, 1, 1, 0, 1, 0, 1, 1, 1, 1],
    ];

    for (int r = 0; r < gridSize; r++) {
      for (int c = 0; c < gridSize; c++) {
        if (pattern[r][c] == 1) {
          canvas.drawRRect(
            RRect.fromRectAndRadius(
              Rect.fromLTWH(
                c * cellSize + 0.5,
                r * cellSize + 0.5,
                cellSize - 1,
                cellSize - 1,
              ),
              const Radius.circular(1.5),
            ),
            paint,
          );
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant AztecCodePainter oldDelegate) =>
      oldDelegate.color != color;
}

