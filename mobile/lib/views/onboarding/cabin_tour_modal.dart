import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../../core/widgets/glass_pill.dart';
import '../../core/widgets/status_beacon.dart';
import '../../viewmodels/booking_viewmodel.dart';

class CabinTourModal extends StatelessWidget {
  const CabinTourModal({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<BookingViewModel>();

    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(36)),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 25, sigmaY: 25),
        child: Container(
          decoration: BoxDecoration(
            color: const Color(0xFF131315).withValues(alpha: 0.96),
            borderRadius: const BorderRadius.vertical(top: Radius.circular(36)),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.15),
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.8),
                blurRadius: 40,
                offset: const Offset(0, -10),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Grab Handle
              Padding(
                padding: const EdgeInsets.only(top: 12, bottom: 6),
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.3),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),

              // Header bar
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const StatusBeacon(
                          color: AppColors.primaryContainer,
                          size: 6,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'AERO SUITE 1A PREVIEW',
                          style: AppTypography.titleMd.copyWith(
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.8,
                          ),
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () => vm.closeTourModal(),
                      child: Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white.withValues(alpha: 0.10),
                        ),
                        alignment: Alignment.center,
                        child: const Icon(
                          Icons.close,
                          size: 18,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const Divider(color: AppColors.borderSubtle, height: 1),

              // Interactive Viewport with Hotspots
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: AspectRatio(
                  aspectRatio: 16 / 10,
                  child: Stack(
                    children: [
                      // Interior Cabin Image
                      ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Container(
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(
                                'https://images.unsplash.com/photo-1540959733332-eab4deabeeaf?auto=format&fit=crop&w=1200&q=80',
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Colors.black.withValues(alpha: 0.5),
                                  Colors.transparent,
                                  Colors.black.withValues(alpha: 0.7),
                                ],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                              ),
                            ),
                          ),
                        ),
                      ),

                      // Hotspot 1: 82" Lie-Flat Bed (Left bottom)
                      Positioned(
                        top: 90,
                        left: 60,
                        child: _buildHotspot(
                          context,
                          index: 0,
                          title: '82″ Lie-Flat Bed',
                          category: 'ERGONOMICS',
                          subtitle:
                              'Hand-stitched Italian leather with bespoke memory foam topper.',
                        ),
                      ),

                      // Hotspot 2: 32" 4K Spatial Audio Display (Right center)
                      Positioned(
                        top: 55,
                        right: 50,
                        child: _buildHotspot(
                          context,
                          index: 1,
                          title: '32″ 4K OLED Cinema',
                          category: 'ENTERTAINMENT',
                          subtitle:
                              'Directional spatial audio and live orbital flight telemetry.',
                        ),
                      ),

                      // Hotspot 3: Acoustic Partition (Center top)
                      Positioned(
                        top: 35,
                        left: 140,
                        child: _buildHotspot(
                          context,
                          index: 2,
                          title: 'Walnut Acoustic Partition',
                          category: 'ACOUSTICS',
                          subtitle:
                              'Triple-sealed active noise dampening suite door.',
                        ),
                      ),

                      // Bottom Scrub / Media Control Overlay Bar
                      Positioned(
                        left: 8,
                        right: 8,
                        bottom: 8,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.black.withValues(alpha: 0.7),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: Colors.white.withValues(alpha: 0.12),
                              width: 1,
                            ),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              // Timeline Scrubber
                              GestureDetector(
                                onHorizontalDragUpdate: (details) {
                                  final box = context.findRenderObject() as RenderBox?;
                                  if (box != null) {
                                    vm.setTourProgress(
                                      (vm.tourProgress + details.delta.dx / 200)
                                          .clamp(0.0, 1.0),
                                    );
                                  }
                                },
                                child: Container(
                                  height: 4,
                                  decoration: BoxDecoration(
                                    color: Colors.white.withValues(alpha: 0.2),
                                    borderRadius: BorderRadius.circular(2),
                                  ),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: FractionallySizedBox(
                                      widthFactor: vm.tourProgress,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: AppColors.primaryContainer,
                                          borderRadius:
                                              BorderRadius.circular(2),
                                          boxShadow: const [
                                            BoxShadow(
                                              color: AppColors.primaryContainer,
                                              blurRadius: 6,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 6),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      GestureDetector(
                                        onTap: () => vm.toggleTourPlay(),
                                        child: Icon(
                                          vm.isTourPlaying
                                              ? Icons.pause_rounded
                                              : Icons.play_arrow_rounded,
                                          color: Colors.white,
                                          size: 18,
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        '0:24 / 1:15',
                                        style: AppTypography.labelSm.copyWith(
                                          fontFamily: 'monospace',
                                          color: Colors.white70,
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      const GlassPill(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 6,
                                          vertical: 1,
                                        ),
                                        child: Text(
                                          'HDR10',
                                          style: TextStyle(
                                            color: AppColors.primary,
                                            fontSize: 9,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  GestureDetector(
                                    onTap: () => vm.toggleSpatialAudio(),
                                    child: Row(
                                      children: [
                                        Icon(
                                          vm.isSpatialAudioOn
                                              ? Icons.volume_up_rounded
                                              : Icons.volume_off_rounded,
                                          size: 15,
                                          color: vm.isSpatialAudioOn
                                              ? AppColors.primary
                                              : Colors.white54,
                                        ),
                                        const SizedBox(width: 4),
                                        Text(
                                          vm.isSpatialAudioOn
                                              ? 'Spatial On'
                                              : 'Muted',
                                          style: AppTypography.labelSm.copyWith(
                                            color: Colors.white70,
                                            fontSize: 10,
                                          ),
                                        ),
                                      ],
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
                ),
              ),
              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHotspot(
    BuildContext context, {
    required int index,
    required String title,
    required String category,
    required String subtitle,
  }) {
    final vm = context.watch<BookingViewModel>();
    final isSelected = vm.activeHotspotIndex == index;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (isSelected)
          Container(
            width: 170,
            margin: const EdgeInsets.only(bottom: 6),
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.9),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.2),
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.6),
                  blurRadius: 15,
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  category,
                  style: AppTypography.labelSm.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.8,
                  ),
                ),
                Text(
                  title,
                  style: AppTypography.labelMd.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: AppTypography.labelSm.copyWith(
                    color: Colors.white60,
                    fontSize: 9.5,
                  ),
                ),
              ],
            ),
          ),
        GestureDetector(
          onTap: () => vm.selectHotspot(index),
          child: Container(
            width: 28,
            height: 28,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isSelected
                  ? AppColors.primaryContainer
                  : Colors.white.withValues(alpha: 0.2),
              border: Border.all(
                color: Colors.white,
                width: 2,
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primaryContainer.withValues(alpha: 0.6),
                  blurRadius: 10,
                  spreadRadius: 2,
                ),
              ],
            ),
            alignment: Alignment.center,
            child: Container(
              width: 8,
              height: 8,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

