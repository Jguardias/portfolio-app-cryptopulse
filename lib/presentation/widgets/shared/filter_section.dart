import 'package:crypto/presentation/providers/coins/ui_state_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FilterSection extends ConsumerWidget {
  const FilterSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeFilter = ref.watch(coinFilterTypeProvider);
    final theme = Theme.of(context);
    final filters = [
      'Rank', 'Price', '24h Change', 'Name', 
      'Highest 24h', 'Lowest 24h', 'Volume 24h'
    ];

    return SizedBox(
      height: 40,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: filters.length,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        itemBuilder: (context, index) {
          final filter = filters[index];
          final isSelected = activeFilter == filter;
          
          return Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: FilterChip(
              selectedColor: theme.colorScheme.primaryContainer,
              checkmarkColor: theme.colorScheme.onPrimaryContainer,
              labelStyle: TextStyle(
                color: isSelected 
                    ? theme.colorScheme.onPrimaryContainer 
                    : theme.colorScheme.onSurfaceVariant
              ),
              selected: isSelected,
              label: Text(filter),
              onSelected: (selected) {
                ref.read(coinFilterTypeProvider.notifier).state = filter;
              },
            ),
          );
        },
      ),
    );
  }
}