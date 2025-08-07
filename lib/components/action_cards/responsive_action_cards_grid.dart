import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'responsive_action_card.dart';

class ResponsiveActionCardsGrid extends StatelessWidget {
  final List<ResponsiveActionCardData> cards;

  const ResponsiveActionCardsGrid({
    super.key,
    required this.cards,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: ResponsiveActionCard(
                  iconPath: cards[0].iconPath,
                  label: cards[0].label,
                  onTap: cards[0].onTap,
                ),
              ),
              SizedBox(width: 6.w),
              Expanded(
                child: ResponsiveActionCard(
                  iconPath: cards[1].iconPath,
                  label: cards[1].label,
                  onTap: cards[1].onTap,
                ),
              ),
            ],
          ),
          SizedBox(height: 6.h),
          Row(
            children: [
              Expanded(
                child: ResponsiveActionCard(
                  iconPath: cards[2].iconPath,
                  label: cards[2].label,
                  onTap: cards[2].onTap,
                ),
              ),
              SizedBox(width: 6.w),
              Expanded(
                child: ResponsiveActionCard(
                  iconPath: cards[3].iconPath,
                  label: cards[3].label,
                  onTap: cards[3].onTap,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
} 