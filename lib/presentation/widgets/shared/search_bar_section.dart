import 'package:crypto/presentation/providers/coins/ui_state_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SearchBarSection extends ConsumerWidget {
  const SearchBarSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SearchBar(
        hintText: "Search by name or symbol...(BTC, Ethereum, TRON...)",
        elevation: WidgetStateProperty.all(0),
        leading: Icon(Icons.search, color: theme.colorScheme.outline),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
        onChanged: (value) {
          ref.read(coinSearchQueryProvider.notifier).state = value;
        },
      ),
    );
  }
}