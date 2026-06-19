import "package:crypto/domain/entities/coin.dart";
import "package:crypto/infraestructure/models/coin_model.dart";

class CoinMapper {
  static Coin coinToEntity(CoinModelGecko coin) {
    return Coin(
      id: coin.id,
      name: coin.name,
      symbol: coin.symbol,
      imageUrl: coin.image,
      price: coin.currentPrice.toDouble(),
      changePercentage24h: coin.priceChangePercentage24H.toDouble(),
      marketCapRank: coin.marketCapRank,
      high24h: coin.high24H.toDouble(),
      low24h: coin.low24H.toDouble(),
      marketCap: (coin.marketCap ?? 0).toDouble(),
      fullyDilutedValuation: (coin.fullyDilutedValuation ?? 0).toDouble(),
      totalVolume: (coin.totalVolume ?? 0).toDouble(),
      circulatingSupply: (coin.circulatingSupply ?? 0).toDouble(),
      totalSupply: (coin.totalSupply ?? 0).toDouble(),
      maxSupply: (coin.maxSupply ?? 0).toDouble(),
    );
  }
}
