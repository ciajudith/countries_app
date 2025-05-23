import 'package:animations/animations.dart';
import 'package:countries_app/constants/colors.dart';
import 'package:countries_app/constants/poppins_text_style.dart';
import 'package:countries_app/views/country_search_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _scaleAnim;
  late final Animation<double> _fadeAnim;
  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _scaleAnim = Tween(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutBack),
    );
    _fadeAnim = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );

    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) _controller.forward();
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
      body: Stack(
        children: [
          Positioned.fill(
            child: LottieBuilder.asset("assets/json/countries.json",
                repeat: true,
                fit: BoxFit.cover,
                alignment: Alignment.center,
                animate: true),
          ),
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.black.withOpacity(0.6),
                    Colors.black.withOpacity(0.2)
                  ],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              ),
            ),
          ),
          Positioned.fill(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ScaleTransition(
                    scale: _scaleAnim,
                    child: FadeTransition(
                      opacity: _fadeAnim,
                      child: Text(
                        'Bienvenue sur WorldLens',
                        textAlign: TextAlign.center,
                        style: PoppinsTextStyle.medium.copyWith(
                          color: AppColors.white,
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          shadows: [
                            const Shadow(
                              blurRadius: 8,
                              color: Colors.black45,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Sous-titre
                  FadeTransition(
                    opacity: _fadeAnim,
                    child: Text(
                      'Explorez les pays du monde en un instant',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.adamina(
                        color: AppColors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        shadows: [
                          const Shadow(
                            blurRadius: 8,
                            color: Colors.black45,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 40),
                  FadeTransition(
                    opacity: _fadeAnim,
                    child: OpenContainer(
                      transitionType: ContainerTransitionType.fadeThrough,
                      openBuilder: (_, __) {
                        return const CountrySearchScreen();
                      },
                      closedElevation: 6,
                      closedShape: const StadiumBorder(),
                      closedColor: AppColors.green,
                      closedBuilder: (ctx, action) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: SizedBox(
                            width: double.infinity,
                            height: 48,
                            child: Center(
                              child: Text(
                                'Commencer',
                                style: GoogleFonts.adamina(
                                  color: AppColors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                  shadows: [
                                    const Shadow(
                                      blurRadius: 8,
                                      color: Colors.black45,
                                      offset: Offset(0, 2),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
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
