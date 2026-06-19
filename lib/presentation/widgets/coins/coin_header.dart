import 'package:crypto/domain/entities/coin.dart';
import 'package:flutter/material.dart';

class CoinHeader extends StatelessWidget {
  final Coin coin;
  const CoinHeader({super.key, required this.coin});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: theme.colorScheme.shadow.withValues(alpha: 0.05),
                blurRadius: 4,
              )
            ],
          ),
          child: Image.network(coin.imageUrl, width: 32, height: 32),
        ),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              coin.name,
              style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            Text(
              coin.symbol.toUpperCase(),
              style: TextStyle(
                color: theme.colorScheme.outline, 
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ],
    );
  }
}