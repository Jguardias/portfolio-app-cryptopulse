import 'package:crypto/domain/entities/coin.dart';
import 'package:crypto/presentation/providers/coins/coin_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


final coinByGeockdbNotifierProvider =
    StateNotifierProvider<CoinByGeockdbNotifier, List<Coin>>((ref) {
      final coinRepository = ref.watch(coinRepositoryProvider);
      return CoinByGeockdbNotifier(coinRepository: coinRepository);
    });

class CoinByGeockdbNotifier extends StateNotifier<List<Coin>> {
  final dynamic coinRepository;
  int _currentPage = 0;
  bool _isLoading = false;
  CoinByGeockdbNotifier({required this.coinRepository}) : super([]);

  Future<void> loadNextPageCoins() async {
    if (_isLoading) return;
    _isLoading = true;
    _currentPage++;
    try {
      final newCoins = await coinRepository.getCoins(page: _currentPage);
      state = [...state, ...newCoins];
    } catch (e) {
      _currentPage--;
    } finally {
      _isLoading = false;
    }
  }
}

