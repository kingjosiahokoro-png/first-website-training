import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../../core/widgets/royal_button.dart';
import '../../core/widgets/status_beacon.dart';

class ConciergeSheet extends StatelessWidget {
  const ConciergeSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
        border: Border.all(color: AppColors.borderHighlight, width: 1),
      ),
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 38,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const StatusBeacon(color: AppColors.secondary, size: 5),
                  const SizedBox(width: 8),
                  Text(
                    'AERO 24/7 CONCIERGE LINE',
                    style: AppTypography.labelSm.copyWith(
                      color: AppColors.secondary,
                      letterSpacing: 1.2,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  width: 28,
                  height: 28,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withValues(alpha: 0.1),
                  ),
                  child: const Icon(Icons.close, size: 16, color: Colors.white),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            'Your Dedicated Aviation Attendant',
            style: AppTypography.titleLg.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColors.onSurface,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Direct access to private charter dispatch, in-flight dining requests, and curbside Rolls-Royce transfers.',
            style: AppTypography.bodyMd.copyWith(
              color: AppColors.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 18),
          _buildQuickService(
            icon: Icons.directions_car_rounded,
            title: 'Tarmac Rolls-Royce Transfer',
            subtitle: 'Direct tarmac pickup upon touchdown at Tokyo Haneda.',
          ),
          const SizedBox(height: 10),
          _buildQuickService(
            icon: Icons.wine_bar_rounded,
            title: 'Reserve Dom Pérignon Vintage',
            subtitle: 'Chilled in Suite 1A private cellar before departure.',
          ),
          const SizedBox(height: 10),
          _buildQuickService(
            icon: Icons.luggage_rounded,
            title: 'White-Glove Baggage Delivery',
            subtitle: 'Direct to your penthouse suite or hotel.',
          ),
          const SizedBox(height: 20),
          RoyalButton(
            label: 'Call Direct Concierge',
            leadingIcon: const Icon(Icons.call, color: Colors.white, size: 18),
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Connecting to Aero Private Concierge...'),
                  backgroundColor: AppColors.primaryContainer,
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildQuickService({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLow,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.borderSubtle, width: 1),
      ),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: AppColors.surfaceContainerHigh,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: AppColors.secondary, size: 18),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTypography.titleMd.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                    color: AppColors.onSurface,
                  ),
                ),
                Text(
                  subtitle,
                  style: AppTypography.labelSm.copyWith(
                    color: AppColors.onSurfaceVariant,
                    fontSize: 10,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

