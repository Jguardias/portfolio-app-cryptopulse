import 'package:crypto/domain/entities/coin.dart';

abstract class CoinDatasource {
  Future<List<Coin>> getCoins({int page = 1});
}
