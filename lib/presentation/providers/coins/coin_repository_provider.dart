import 'package:crypto/infraestructure/datasources/coin_gecko_datasource.dart';
import 'package:crypto/infraestructure/repositories/coin_repositories_impli.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final coinRepositoryProvider = Provider((ref) {
  return CoinRepositoriesImpl(coinDatasource: CoinGeckodbDataSource());
});
