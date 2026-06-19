import 'package:crypto/domain/entities/coin.dart';
import 'package:flutter/material.dart';

class CoinRangeBar extends StatelessWidget {
  final Coin coin;
  const CoinRangeBar({super.key, required this.coin});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    final double range = coin.high24h - coin.low24h;
    final double progress = range != 0 ? (coin.price - coin.low24h) / range : 0;

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("24h Range", style: TextStyle(color: theme.colorScheme.outline)),
            const Text(""),
          ],
        ),
        const SizedBox(height: 8),
        LinearProgressIndicator(
          value: progress.clamp(0.0, 1.0),
          minHeight: 8,
          borderRadius: BorderRadius.circular(4), 
          backgroundColor: theme.colorScheme.surfaceContainerHighest,
          valueColor: AlwaysStoppedAnimation(theme.colorScheme.primary),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("\$${coin.low24h.toStringAsFixed(2)}"),
            Text("\$${coin.high24h.toStringAsFixed(2)}"),
          ],
        ),
      ],
    );
  }
}