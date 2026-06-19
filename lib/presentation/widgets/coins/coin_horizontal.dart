import 'package:crypto/config/theme/app_theme.dart';
import 'package:crypto/domain/entities/coin.dart';
import 'package:crypto/presentation/providers/favorites/favorites_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class CoinHorizontal extends ConsumerWidget {
  final Coin coin;

  const CoinHorizontal({super.key, required this.coin});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favIds = ref.watch(favoritesIdsProvider);
    final isFavorite = favIds.contains(coin.id);
    
    final theme = Theme.of(context);
    final isPositive = coin.changePercentage24h >= 0;
    final statusColor = isPositive ? AppColors.success : theme.colorScheme.error;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: InkWell(
        onTap: () => context.pushNamed('coin-detail', extra: coin),
        child: ListTile(
          tileColor: AppColors.cardBackground,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          leading: CircleAvatar(
            backgroundColor: theme.colorScheme.surfaceContainerHighest,
            backgroundImage: NetworkImage(coin.imageUrl),
          ),
          title: Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    Flexible(
                      child: Text(
                        coin.name,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: const TextStyle(fontWeight: FontWeight.w500),
                      ),
                    ),
                    const SizedBox(width: 4),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.surfaceContainerHighest,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        coin.symbol.toUpperCase(),
                        style: const TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Icon(isPositive ? Icons.trending_up : Icons.trending_down, color: statusColor, size: 16),
              const SizedBox(width: 2),
              Text(
                "${coin.changePercentage24h.toStringAsFixed(2)}%",
                style: TextStyle(color: statusColor, fontSize: 12),
              ),
            ],
          ),
          subtitle: Row(
            children: [
              Text("${coin.price.toStringAsFixed(2)} USD", style: const TextStyle(fontSize: 14)),
              const SizedBox(width: 8),
              Icon(Icons.arrow_upward, color: AppColors.success, size: 16),
              Text(coin.high24h.toStringAsFixed(2), style: const TextStyle(color: AppColors.success, fontSize: 12)),
              const SizedBox(width: 8),
              Icon(Icons.arrow_downward, color: theme.colorScheme.error, size: 16),
              Text(coin.low24h.toStringAsFixed(2), style: const TextStyle(color: Colors.red, fontSize: 12)),
            ],
          ),
          trailing: IconButton(
            icon: Icon(
              Icons.star_purple500_outlined,
              color: isFavorite ? AppColors.primary : theme.colorScheme.outline,
            ),
            onPressed: () => ref.read(favoritesIdsProvider.notifier).toggleFavorite(coin.id),
          ),
        ),
      ),
    );
  }
}