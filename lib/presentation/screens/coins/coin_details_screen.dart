import 'package:crypto/domain/entities/coin.dart';
import 'package:crypto/presentation/widgets/index.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class CoinDetailScreen extends StatelessWidget {
  final Coin coin;

  const CoinDetailScreen({super.key, required this.coin});

  @override
  Widget build(BuildContext context) {
   
    final priceFormatter = NumberFormat("#,##0.00", "en_US");
    final intFormatter = NumberFormat("#,##0", "en_US");

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FB),
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text("Market Details", style: TextStyle(color: Colors.black)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CoinHeader(coin: coin),
            
            const SizedBox(height: 24),

            Align(
              alignment: Alignment.centerLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("\$${priceFormatter.format(coin.price)}", 
                    style: const TextStyle(fontSize: 40, fontWeight: FontWeight.w900)),
                  Text("${coin.changePercentage24h}% (24h)",
                    style: TextStyle(
                      color: coin.changePercentage24h >= 0 ? Colors.green : Colors.red,
                      fontWeight: FontWeight.bold, fontSize: 18)),
                ],
              ),
            ),

            const SizedBox(height: 24),

            CoinRangeBar(coin: coin),
            
            const SizedBox(height: 24),

            CoinStatsList(coin: coin, formatter: intFormatter),
          ],
        ),
      ),
    );
  }
}