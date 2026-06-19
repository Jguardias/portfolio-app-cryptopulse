import 'package:crypto/domain/entities/coin.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CoinStatsList extends StatelessWidget {
  final Coin coin;
  final NumberFormat formatter;

  const CoinStatsList({
    super.key,
    required this.coin,
    required this.formatter,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: theme.colorScheme.outlineVariant),
      ),
      child: Column(
        children: [
          _StatTile(icon: Icons.leaderboard_outlined, title: "Market Cap", value: "\$${formatter.format(coin.marketCap)}"),
          const Divider(height: 1),
          _StatTile(icon: Icons.pie_chart_outline, title: "Fully Diluted Val.", value: "\$${formatter.format(coin.fullyDilutedValuation)}"),
          const Divider(height: 1),
          _StatTile(icon: Icons.bar_chart, title: "24h Trading Vol", value: "\$${formatter.format(coin.totalVolume)}"),
          const Divider(height: 1),
          _StatTile(icon: Icons.access_time, title: "Circulating Supply", value: "${formatter.format(coin.circulatingSupply)} ${coin.symbol.toUpperCase()}"),
          const Divider(height: 1),
          _StatTile(icon: Icons.layers_outlined, title: "Total Supply", value: formatter.format(coin.totalSupply)),
          const Divider(height: 1),
          _StatTile(icon: Icons.work_outline, title: "Max Supply", value: coin.maxSupply > 0 ? formatter.format(coin.maxSupply) : "∞"),
        ],
      ),
    );
  }
}

class _StatTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;

  const _StatTile({
    required this.icon,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return ListTile(
      leading: Icon(icon, color: theme.colorScheme.primary),
      title: Text(title, style: TextStyle(fontSize: 14, color: theme.colorScheme.onSurfaceVariant)),
      trailing: Text(
        value,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: theme.colorScheme.onSurface),
      ),
    );
  }
}