import 'package:crypto/presentation/providers/index.dart';
import 'package:crypto/presentation/widgets/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FavoritesScreen extends ConsumerWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    
    final favoriteCoins = ref.watch(favoriteCoinsProvider);

    return Scaffold(
      appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.primary,
        title: const Text("Favorites")),
      body: favoriteCoins.isEmpty
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.favorite_border, size: 64, color: Colors.grey),
                  SizedBox(height: 16),
                  Text("No favorites yet, Add coins to your list to track them here."),
                ],
              ),
            )
          : ListView.builder(
              itemCount: favoriteCoins.length,
              itemBuilder: (context, index) {
                final coin = favoriteCoins[index];
                return CoinHorizontal(coin: coin);
              },
            ),
    );
  }
}
