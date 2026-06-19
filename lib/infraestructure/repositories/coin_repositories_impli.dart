import 'package:crypto/domain/datasources/coin_datasource.dart';
import 'package:crypto/domain/entities/coin.dart';
import 'package:crypto/domain/repositories/coin_repositories.dart';

class CoinRepositoriesImpl extends CoinRepositories {

  final CoinDatasource coinDatasource;

  CoinRepositoriesImpl({required this.coinDatasource});

  @override
  Future<List<Coin>> getCoins({int page = 1}) {
    return coinDatasource.getCoins(page: page);
  }
  
}