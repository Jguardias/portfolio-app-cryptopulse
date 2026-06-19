import 'package:crypto/domain/entities/coin.dart';
import 'package:crypto/presentation/screens/index.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: "/",
  routes: <GoRoute>[
    GoRoute(
      path: "/",
      name: "splash-screen",
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: '/favorites',
      name: "favorites-screen",
      builder: (context, state) => const FavoritesScreen(),
    ),
    GoRoute(
      path: '/details',
      name: 'coin-detail',
      builder: (context, state) {
        final coin = state.extra as Coin;
        return CoinDetailScreen(coin: coin);
      },
    ),
    GoRoute(
      path: '/home',
      name: 'home-screen',
      pageBuilder: (context, state) {
        return CustomTransitionPage(
          key: state.pageKey,
          child: const HomeScreen(),
          transitionDuration: const Duration(milliseconds: 400),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: CurveTween(curve: Curves.easeOut).animate(animation),
              child: child,
            );
          },
        );
      },
    ),
  ],
);
