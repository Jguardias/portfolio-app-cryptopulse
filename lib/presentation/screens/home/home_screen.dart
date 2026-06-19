import 'package:crypto/config/theme/app_theme.dart';
import 'package:crypto/presentation/providers/index.dart';
import 'package:crypto/presentation/widgets/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: Theme.of(context).colorScheme.primary,
        title:  Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.show_chart_rounded, size: 24, color: Colors.white),
            SizedBox(width: 8),
            Text(
              "CryptoPulse",
              style: TextStyle(fontWeight: FontWeight.w800, letterSpacing: 0.5, color: AppColors.textPrimary),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.star_rounded, color: Colors.white),
            onPressed: () {
              context.pushNamed('favorites-screen');
            },
          ),
        ],
        centerTitle: true,
      ),
      body: const HomeView(),
    );
  }
}

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  ConsumerState<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  final ScrollController _scrollController = ScrollController();
  bool _showBackToTop = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    final showButton = _scrollController.offset > 400;
    if (_showBackToTop != showButton) {
      setState(() => _showBackToTop = showButton);
    }

    final currentPosition = _scrollController.position.pixels;
    final maxScroll = _scrollController.position.maxScrollExtent;

    if (currentPosition >= (maxScroll - 200)) {
      ref.read(coinByGeockdbNotifierProvider.notifier).loadNextPageCoins();
    }
  }

  @override
  Widget build(BuildContext context) {
    final originalCoins = ref.watch(coinByGeockdbNotifierProvider);
    final coins = ref.watch(processedCoinsProvider);
    final theme = Theme.of(context);

    if (originalCoins.isEmpty) {
      return const Center(child: CircularProgressIndicator(strokeWidth: 2));
    }

    return Scaffold(
      floatingActionButton: _showBackToTop
          ? FloatingActionButton(
              mini: true,
              backgroundColor: theme.colorScheme.primary,
              onPressed: () {
                _scrollController.animateTo(
                  0,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOut,
                );
              },
              child: const Icon(Icons.keyboard_arrow_up, color: Colors.white),
            )
          : null,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            color: theme.scaffoldBackgroundColor,
            child: const Column(
              children: [
                SearchBarSection(),
                FilterSection(),
                SizedBox(height: 12),
              ],
            ),
          ),
          Expanded(
            child: coins.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Lottie.asset(
                            'assets/animations/Bitcoin.json',
                            width: 150,
                            repeat: true,
                          ),
                        ),
                        const Text(
                          "No coins found",
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                      ],
                    ),
                  )
                : RefreshIndicator(
                    onRefresh: () async {
                      await ref
                          .refresh(coinByGeockdbNotifierProvider.notifier)
                          .loadNextPageCoins();
                    },
                    child: CustomScrollView(
                      controller: _scrollController,
                      physics: const AlwaysScrollableScrollPhysics(),
                      slivers: [
                        const SliverToBoxAdapter(child: TopMoversSection()),
                        const SliverToBoxAdapter(
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 16,
                            ),
                            child: Text(
                              "Market Overview",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        SliverList(
                          delegate: SliverChildBuilderDelegate((context, index) {
                            final coin = coins[index];
                            return CoinHorizontal(coin: coin);
                          }, childCount: coins.length),
                        ),
                      ],
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}