import 'package:crypto/config/theme/app_theme.dart';
import 'package:crypto/domain/entities/coin.dart';
import 'package:crypto/presentation/providers/coins/ui_state_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TopMoversSection extends ConsumerWidget {
  const TopMoversSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final topMovers = ref.watch(topMoverProvider);
    final theme = Theme.of(context);

    if (topMovers.isEmpty) return const SizedBox();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text(
            "Top Movers",
            style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(
          height: 160,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: topMovers.length,
            padding: const EdgeInsets.only(left: 16),
            itemBuilder: (context, index) => TopMoverCard(coin: topMovers[index]),
          ),
        ),
      ],
    );
  }
}

class TopMoverCard extends StatelessWidget {
  final Coin coin;
  const TopMoverCard({super.key, required this.coin});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isPositive = coin.changePercentage24h >= 0;
    final bgColor = isPositive ? theme.colorScheme.primaryContainer.withValues(alpha: 0.2) : theme.colorScheme.errorContainer.withValues(alpha: 0.2);
    final borderColor = isPositive ? theme.colorScheme.primaryContainer : theme.colorScheme.errorContainer;
    final trendColor = isPositive ? AppColors.success : theme.colorScheme.error;

    return Container(
      width: 140,
      margin: const EdgeInsets.only(right: 12, bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: borderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Image.network(coin.imageUrl, width: 32, height: 32),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  coin.name.toUpperCase(),
                  style: const TextStyle(fontWeight: FontWeight.bold),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(coin.symbol.toUpperCase()),
              Text(
                "\$${coin.price.toStringAsFixed(2)}",
                style: TextStyle(color: theme.colorScheme.outline, fontSize: 13),
              ),
            ],
          ),
          Text(
            "${isPositive ? '+' : ''}${coin.changePercentage24h.toStringAsFixed(2)}%",
            style: TextStyle(color: trendColor, fontSize: 18, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}