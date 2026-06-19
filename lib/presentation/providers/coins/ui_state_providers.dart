import 'package:crypto/domain/entities/coin.dart';
import 'package:crypto/presentation/providers/coins/coin_by_geockdb_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final coinSearchQueryProvider = StateProvider<String>((ref) => '');

final coinFilterTypeProvider = StateProvider<String>((ref) => 'Rank');

final processedCoinsProvider = Provider<List<Coin>>((ref) {
  final allCoins = ref.watch(coinByGeockdbNotifierProvider);
  final activeFilter = ref.watch(coinFilterTypeProvider);
  final searchQuery = ref.watch(coinSearchQueryProvider).toLowerCase();

  List<Coin> filteredList = allCoins.where((coin) {
    return (coin.name.toLowerCase().contains(searchQuery)) ||
        (coin.symbol.toLowerCase().contains(searchQuery));
  }).toList();

  List<Coin> sortedList = List.from(filteredList);

  switch (activeFilter) {
    case 'Price':
      sortedList.sort((a, b) => b.price.compareTo(a.price));
      break;
    case '24h Change':
    case 'Highest 24h':
      sortedList.sort((a, b) => b.changePercentage24h.compareTo(a.changePercentage24h));
      break;
    case 'Lowest 24h':
      sortedList.sort((a, b) => a.changePercentage24h.compareTo(b.changePercentage24h));
      break;
    case 'Name':
      sortedList.sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));
      break;
    case 'Rank':
    default:
      break;
  }
  return sortedList;
});

final topMoverProvider = Provider<List<Coin>>((ref) {
  final allCoins = ref.watch(coinByGeockdbNotifierProvider);
  if (allCoins.isEmpty) return [];

  List<Coin> gainers = List.from(allCoins);
  gainers.sort((a, b) => b.changePercentage24h.compareTo(a.changePercentage24h));
  final topGainers = gainers.take(5).toList();

  List<Coin> losers = List.from(allCoins);
  losers.sort((a, b) => a.changePercentage24h.compareTo(b.changePercentage24h));
  final topLosers = losers.take(5).toList();

  return [...topGainers, ...topLosers];
});