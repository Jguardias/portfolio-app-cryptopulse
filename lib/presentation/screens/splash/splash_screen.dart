import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:crypto/presentation/providers/coins/coin_by_geockdb_provider.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Transform.scale(
          scale: 1.5,
          child: Lottie.asset(
            'assets/animations/splash.json',
            controller: _controller,
            fit: BoxFit.cover,
            onLoaded: (composition) async {
              _controller.duration = composition.duration;

              final animationFuture = _controller.forward();
              final apiFuture = ref
                  .read(coinByGeockdbNotifierProvider.notifier)
                  .loadNextPageCoins();

              await animationFuture;
              await apiFuture;

              if (mounted) {
                context.go('/home');
              }
            },
          ),
        ),
      ),
    );
  }
}
