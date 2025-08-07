import 'package:flutter/material.dart';
import 'action_card.dart';

class ActionCardsGrid extends StatelessWidget {
  final List<ActionCardData> cards;

  const ActionCardsGrid({
    super.key,
    required this.cards,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: ActionCard(
                  iconPath: cards[0].iconPath,
                  label: cards[0].label,
                  onTap: cards[0].onTap,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: ActionCard(
                  iconPath: cards[1].iconPath,
                  label: cards[1].label,
                  onTap: cards[1].onTap,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: ActionCard(
                  iconPath: cards[2].iconPath,
                  label: cards[2].label,
                  onTap: cards[2].onTap,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: ActionCard(
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

class ActionCardData {
  final String iconPath;
  final String label;
  final VoidCallback? onTap;

  ActionCardData({
    required this.iconPath,
    required this.label,
    this.onTap,
  });
} 