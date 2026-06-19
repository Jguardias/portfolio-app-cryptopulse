import 'package:crypto/config/constants/Enviroment.dart';
import 'package:crypto/domain/datasources/coin_datasource.dart';
import 'package:crypto/domain/entities/coin.dart';
import 'package:crypto/infraestructure/mappers/coin_mapper.dart';
import 'package:crypto/infraestructure/models/coin_model.dart';
import 'package:dio/dio.dart';

class CoinGeckodbDataSource extends CoinDatasource {
  final dio = Dio(
    BaseOptions(
      baseUrl: 'https://api.coingecko.com/api/v3/',
      queryParameters: {'x_cg_demo_api_key': Environment.apiKey},
    ),
  );

  @override
  Future<List<Coin>> getCoins({int page = 1}) async {
    final response = await dio.get(
      "coins/markets",
      queryParameters: {
        "vs_currency": "usd",
        "order": "market_cap_desc",
        "per_page": 20,
        "page": page,
        "sparkline": false,
      },
    );
    final List<dynamic> data = response.data;
    final List<Coin> coins = data
        .map((coinJson) => CoinModelGecko.fromJson(coinJson))
        .map((coinModel) => CoinMapper.coinToEntity(coinModel))
        .toList();

    return coins;
  }
}
