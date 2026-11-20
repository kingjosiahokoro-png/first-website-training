import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../../core/widgets/glass_card.dart';
import '../../core/widgets/glass_pill.dart';
import '../../core/widgets/royal_button.dart';
import '../../core/widgets/status_beacon.dart';
import '../../viewmodels/navigation_viewmodel.dart';
import 'cabin_tour_modal.dart';

class WelcomeView extends StatelessWidget {
  const WelcomeView({super.key});

  void _showTourDrawer(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const CabinTourModal(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final navVm = context.watch<NavigationViewModel>();

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          // Background Hero: Twilight Aviation Wing & Clouds
          Positioned.fill(
            child: Image.network(
              'https://images.unsplash.com/photo-1540959733332-eab4deabeeaf?auto=format&fit=crop&w=1200&q=80',
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                color: const Color(0xFF0D0E12),
                child: Center(
                  child: Icon(
                    Icons.flight,
                    size: 100,
                    color: Colors.white.withValues(alpha: 0.05),
                  ),
                ),
              ),
            ),
          ),

          // Top Vignette
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: 180,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColors.background.withValues(alpha: 0.95),
                    AppColors.background.withValues(alpha: 0.4),
                    Colors.transparent,
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
          ),

          // Bottom Vignette
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            height: 520,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.transparent,
                    AppColors.background.withValues(alpha: 0.7),
                    AppColors.background.withValues(alpha: 0.95),
                    AppColors.background,
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
          ),

          // Foreground Content
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Luxury Brand Header Bar
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 36,
                              height: 36,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white.withValues(alpha: 0.08),
                                border: Border.all(
                                  color: Colors.white.withValues(alpha: 0.12),
                                  width: 1,
                                ),
                              ),
                              alignment: Alignment.center,
                              child: Transform.rotate(
                                angle: -0.785398, // -45 deg
                                child: const Icon(
                                  Icons.navigation_rounded,
                                  size: 16,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Text(
                              'AERO',
                              style: AppTypography.titleMd.copyWith(
                                fontWeight: FontWeight.w800,
                                letterSpacing: 3.0,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        GlassPill(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 5,
                          ),
                          child: Text(
                            'PRIVATE AVIATION',
                            style: AppTypography.labelSm.copyWith(
                              letterSpacing: 1.8,
                              color: Colors.white70,
                              fontSize: 9.5,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const Spacer(),

                  // Micro Category Label
                  Row(
                    children: [
                      const StatusBeacon(
                        color: AppColors.primaryContainer,
                        size: 5,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        'FIRST CLASS WITHOUT COMPROMISE',
                        style: AppTypography.labelSm.copyWith(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 1.2,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 8),

                  // Main Headline
                  Text(
                    'Fly beyond\nexpectation.',
                    style: AppTypography.displayLgMobile.copyWith(
                      color: Colors.white,
                      height: 1.08,
                      fontWeight: FontWeight.w700,
                    ),
                  ),

                  const SizedBox(height: 8),

                  // Subtitle
                  Text(
                    'Effortless global booking, private suites, and bespoke 24/7 concierge service at your fingertips.',
                    style: AppTypography.bodyMd.copyWith(
                      color: Colors.white70,
                      height: 1.4,
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Interactive Cabin Tour Preview Card
                  GestureDetector(
                    onTap: () => _showTourDrawer(context),
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.06),
                        borderRadius: BorderRadius.circular(18),
                        border: Border.all(
                          color: Colors.white.withValues(alpha: 0.14),
                          width: 1,
                        ),
                      ),
                      child: Row(
                        children: [
                          // Thumbnail with play button
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                SizedBox(
                                  width: 80,
                                  height: 54,
                                  child: Image.network(
                                    'https://images.unsplash.com/photo-1540959733332-eab4deabeeaf?auto=format&fit=crop&w=400&q=80',
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) => Container(
                                      color: Colors.black45,
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 26,
                                  height: 26,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: AppColors.primaryContainer,
                                    boxShadow: [
                                      BoxShadow(
                                        color: AppColors.primaryGlow,
                                        blurRadius: 8,
                                      ),
                                    ],
                                  ),
                                  child: const Icon(
                                    Icons.play_arrow_rounded,
                                    color: Colors.white,
                                    size: 16,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    const StatusBeacon(
                                      color: Colors.redAccent,
                                      size: 4,
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      '360° IMMERSIVE TOUR',
                                      style: AppTypography.labelSm.copyWith(
                                        color: Colors.white,
                                        fontSize: 9,
                                        fontWeight: FontWeight.w700,
                                        letterSpacing: 0.6,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  'Aero Suite 1A Experience',
                                  style: AppTypography.labelMd.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  'Lie-Flat • Spatial Audio • Mini Bar',
                                  style: AppTypography.labelSm.copyWith(
                                    color: Colors.white54,
                                    fontSize: 9.5,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Icon(
                            Icons.arrow_forward_ios_rounded,
                            color: AppColors.primary,
                            size: 14,
                          ),
                          const SizedBox(width: 4),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // 3 Value Pillars
                  Row(
                    children: [
                      _buildPillar(
                        icon: Icons.public,
                        title: '120+ Global',
                        subtitle: 'Destinations',
                        iconColor: AppColors.primary,
                      ),
                      const SizedBox(width: 8),
                      _buildPillar(
                        icon: Icons.king_bed_outlined,
                        title: 'Private Suite',
                        subtitle: '1-to-1 Lie-Flat',
                        iconColor: Colors.white70,
                      ),
                      const SizedBox(width: 8),
                      _buildPillar(
                        icon: Icons.bolt,
                        title: '60s Reserve',
                        subtitle: 'Instant Departure',
                        iconColor: Colors.white70,
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // Slide Indicator (Apple Style Pills)
                  Row(
                    children: [
                      Container(
                        width: 24,
                        height: 4,
                        decoration: BoxDecoration(
                          color: AppColors.primaryContainer,
                          borderRadius: BorderRadius.circular(2),
                          boxShadow: const [
                            BoxShadow(
                              color: AppColors.primaryContainer,
                              blurRadius: 6,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 6),
                      Container(
                        width: 6,
                        height: 4,
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                      const SizedBox(width: 6),
                      Container(
                        width: 6,
                        height: 4,
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // Primary CTA Button
                  RoyalButton(
                    label: 'Begin Journey',
                    onPressed: () {
                      navVm.completeOnboarding();
                    },
                    trailingIcon: const Icon(
                      Icons.arrow_forward_rounded,
                      color: Colors.white,
                      size: 16,
                    ),
                  ),

                  const SizedBox(height: 10),

                  // Secondary Action Sign In
                  Center(
                    child: TextButton(
                      onPressed: () {
                        navVm.completeOnboarding();
                      },
                      child: RichText(
                        text: TextSpan(
                          text: 'Already an Aero Member? ',
                          style: AppTypography.bodyMd.copyWith(
                            color: Colors.white70,
                            fontSize: 13,
                          ),
                          children: [
                            TextSpan(
                              text: 'Sign In',
                              style: AppTypography.bodyMd.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                decoration: TextDecoration.underline,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 8),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPillar({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color iconColor,
  }) {
    return Expanded(
      child: GlassCard(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        borderRadius: 16,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, size: 16, color: iconColor),
            const SizedBox(height: 6),
            Text(
              title,
              style: AppTypography.labelSm.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 11,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              subtitle,
              style: AppTypography.labelSm.copyWith(
                color: Colors.white54,
                fontSize: 9.5,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}

