import 'package:crypto/domain/entities/coin.dart';

abstract class CoinRepositories {
  Future<List<Coin>> getCoins({int page = 1});
}
