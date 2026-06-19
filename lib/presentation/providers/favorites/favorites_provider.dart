import 'package:crypto/domain/entities/coin.dart';
import 'package:crypto/presentation/providers/coins/coin_by_geockdb_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final favoritesIdsProvider = StateNotifierProvider<FavoritesIdsNotifier, Set<String>>((ref) {
  return FavoritesIdsNotifier();
});

class FavoritesIdsNotifier extends StateNotifier<Set<String>> {
  FavoritesIdsNotifier() : super({}) { _loadFavorites(); }

  Future<void> _loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String>? saved = prefs.getStringList('favorites');
    if (saved != null) state = saved.toSet();
  }

  Future<void> _saveFavorites(Set<String> favorites) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('favorites', favorites.toList());
  }

  void toggleFavorite(String coinId) {
    state = state.contains(coinId) 
        ? ({...state}..remove(coinId)) 
        : ({...state}..add(coinId));
    _saveFavorites(state);
  }
}

final favoriteCoinsProvider = Provider<List<Coin>>((ref) {
  final allCoins = ref.watch(coinByGeockdbNotifierProvider);
  final favIds = ref.watch(favoritesIdsProvider);
  return allCoins.where((coin) => favIds.contains(coin.id)).toList();
});