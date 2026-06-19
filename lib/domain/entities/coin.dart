class Coin {
  final String id;
  final String name;
  final String symbol;
  final String imageUrl;
  final double price;
  final double changePercentage24h;
  final int marketCapRank;
  final double high24h;
  final double low24h;
  final double marketCap;
  final double fullyDilutedValuation;
  final double totalVolume;
  final double circulatingSupply;
  final double totalSupply;
  final double maxSupply;

  Coin({
    required this.id,
    required this.name,
    required this.symbol,
    required this.imageUrl,
    required this.price,
    required this.changePercentage24h,
    required this.marketCapRank,
    required this.high24h,
    required this.low24h,
    required this.marketCap,
    required this.fullyDilutedValuation,
    required this.totalVolume,
    required this.circulatingSupply,
    required this.totalSupply,
    required this.maxSupply,
  });
}