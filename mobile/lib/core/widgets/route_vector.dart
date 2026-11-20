import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';

/// Luxury Route Vector Graphic
/// Displays Origin - Trajectory line with airplane glyph - Destination
class RouteVector extends StatelessWidget {
  final String originCode;
  final String destCode;
  final String? originCity;
  final String? destCity;
  final String? originTime;
  final String? destTime;
  final String? nextDay;
  final String duration;
  final bool isDirect;

  const RouteVector({
    super.key,
    required this.originCode,
    required this.destCode,
    this.originCity,
    this.destCity,
    this.originTime,
    this.destTime,
    this.nextDay,
    this.duration = '11h 15m',
    this.isDirect = true,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Origin
        Expanded(
          flex: 4,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (originTime != null)
                Text(
                  originTime!,
                  style: AppTypography.headlineLgMobile.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
              Text(
                originCode,
                style: AppTypography.titleLg.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w700,
                ),
              ),
              if (originCity != null)
                Text(
                  originCity!,
                  style: AppTypography.labelSm.copyWith(
                    color: AppColors.onSurfaceVariant,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
            ],
          ),
        ),

        // Vector
        Expanded(
          flex: 5,
          child: Column(
            children: [
              Text(
                duration,
                style: AppTypography.labelSm.copyWith(
                  color: AppColors.onSurfaceVariant,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  Container(
                    width: 6,
                    height: 6,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.primary,
                    ),
                  ),
                  Expanded(
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          height: 1.5,
                          color: AppColors.surfaceContainerHighest,
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          color: Colors.transparent,
                          child: Transform.rotate(
                            angle: 1.5708, // 90 deg
                            child: const Icon(
                              Icons.flight,
                              size: 16,
                              color: AppColors.primary,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
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
              const SizedBox(height: 4),
              Text(
                isDirect ? 'NON-STOP' : 'CONNECTING',
                style: AppTypography.labelSm.copyWith(
                  color: AppColors.secondary,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.0,
                ),
              ),
            ],
          ),
        ),

        // Destination
        Expanded(
          flex: 4,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              if (destTime != null)
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      destTime!,
                      style: AppTypography.headlineLgMobile.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    if (nextDay != null) ...[
                      const SizedBox(width: 2),
                      Text(
                        nextDay!,
                        style: AppTypography.labelSm.copyWith(
                          color: AppColors.secondary,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ],
                ),
              Text(
                destCode,
                style: AppTypography.titleLg.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w700,
                ),
              ),
              if (destCity != null)
                Text(
                  destCity!,
                  style: AppTypography.labelSm.copyWith(
                    color: AppColors.onSurfaceVariant,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
            ],
          ),
        ),
      ],
    );
  }
}

