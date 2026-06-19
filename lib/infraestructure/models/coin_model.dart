class CoinModelGecko {
  final String id;
  final String symbol;
  final String name;
  final String image;
  final double currentPrice;
  final int marketCapRank;
  final double high24H;
  final double low24H;
  final double priceChangePercentage24H;
  final double? marketCap;
  final double? fullyDilutedValuation;
  final double? totalVolume;
  final double? circulatingSupply;
  final double? totalSupply;
  final double? maxSupply;

  CoinModelGecko({
    required this.id,
    required this.symbol,
    required this.name,
    required this.image,
    required this.currentPrice,
    required this.marketCapRank,
    required this.high24H,
    required this.low24H,
    required this.priceChangePercentage24H,
    required this.marketCap,
    required this.fullyDilutedValuation,
    required this.totalVolume,
    required this.circulatingSupply,
    required this.totalSupply,
    required this.maxSupply,
  });

  factory CoinModelGecko.fromJson(Map<String, dynamic> json) => CoinModelGecko(
    id: json["id"] ?? '',
    symbol: json["symbol"] ?? '',
    name: json["name"] ?? '',
    image: json["image"] ?? '',
    currentPrice: (json["current_price"] ?? 0).toDouble(),
    marketCapRank: json["market_cap_rank"] ?? 0,
    high24H: (json["high_24h"] ?? 0).toDouble(),
    low24H: (json["low_24h"] ?? 0).toDouble(),
    priceChangePercentage24H: (json["price_change_percentage_24h"] ?? 0)
        .toDouble(),

    // Mapeo desde el JSON
    marketCap: (json["market_cap"] ?? 0).toDouble(),
    fullyDilutedValuation: (json["fully_diluted_valuation"] ?? 0).toDouble(),
    totalVolume: (json["total_volume"] ?? 0).toDouble(),
    circulatingSupply: (json["circulating_supply"] ?? 0).toDouble(),
    totalSupply: (json["total_supply"] ?? 0).toDouble(),
    maxSupply: (json["max_supply"] ?? 0).toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "symbol": symbol,
    "name": name,
    "image": image,
    "current_price": currentPrice,
    "market_cap_rank": marketCapRank,
    "high_24h": high24H,
    "low_24h": low24H,
    "price_change_percentage_24h": priceChangePercentage24H,
    "market_cap": marketCap,
    "fully_diluted_valuation": fullyDilutedValuation,
    "total_volume": totalVolume,
    "circulating_supply": circulatingSupply,
    "total_supply": totalSupply,
    "max_supply": maxSupply,
  };
}
