import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:special_exam_permit/main_home.dart';

void main() {
  runApp(const UMApp());
}

class UMApp extends StatelessWidget {
  const UMApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'University of Mindanao',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF6D1A24)),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  static const Color maroon = Color(0xFF6D1A24);
  static const Color maroonDark = Color(0xFF4A0F18);

  late final AnimationController _controller;
  late final Animation<double> _logoFade;
  late final Animation<double> _logoScale;
  late final Animation<double>
  _reveal; // gibutang ang text -> ma-push ang logo pa-left
  late final Animation<double> _textFade;

  @override
  void initState() {
    super.initState();

    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarColor: maroon,
        systemNavigationBarIconBrightness: Brightness.light,
      ),
    );

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3000),
    );

    // 1) Logo mo-gawas sa tunga
    _logoFade = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.00, 0.30, curve: Curves.easeOut),
    );
    _logoScale = Tween<double>(begin: 0.72, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.00, 0.38, curve: Curves.easeOutBack),
      ),
    );

    // 2) Mo-abli ang space sa text -> automatic mo-slide pa-left ang logo
    _reveal = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.42, 0.80, curve: Curves.easeInOutCubic),
    );

    // 3) Mo-fade in ang UM + University of Mindanao
    _textFade = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.58, 0.90, curve: Curves.easeIn),
    );

    _controller.forward();

    // Adto sa sunod nga screen human sa splash
    Future.delayed(const Duration(milliseconds: 3600), () {
      if (!mounted) return;
      Navigator.of(context).pushReplacement(
        PageRouteBuilder(
          transitionDuration: const Duration(milliseconds: 600),
          pageBuilder: (_, __, ___) => const MainHome(),
          transitionsBuilder: (_, animation, __, child) =>
              FadeTransition(opacity: animation, child: child),
        ),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            center: Alignment.center,
            radius: 1.1,
            colors: [maroon, maroonDark],
          ),
        ),
        child: Center(
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // ---- LOGO ----
                  FadeTransition(
                    opacity: _logoFade,
                    child: ScaleTransition(
                      scale: _logoScale,
                      child: Image.asset(
                        'assets/um_seal.png',
                        width: 130,
                        height: 130,
                        filterQuality: FilterQuality.high,
                      ),
                    ),
                  ),

                  // ---- TEXT (mo-abli gikan sa wala paingon sa tuo) ----
                  SizeTransition(
                    sizeFactor: _reveal,
                    axis: Axis.horizontal,
                    axisAlignment: -1.0,
                    child: FadeTransition(
                      opacity: _textFade,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 18),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(bottom: 2),
                              child: const Text(
                                'UM',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 68,
                                  height: 1.0,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 2,
                                ),
                              ),
                            ),
                            const SizedBox(height: 6),
                            Container(
                              width: 150,
                              height: 1.2,
                              color: Colors.white.withOpacity(0.45),
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              'The University of Mindanao',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                letterSpacing: 0.8,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
