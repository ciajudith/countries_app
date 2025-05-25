import 'package:animations/animations.dart';
import 'package:countries_app/constants/colors.dart';
import 'package:countries_app/constants/poppins_text_style.dart';
import 'package:countries_app/constants/text.dart';
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
            child: LottieBuilder.asset(AppStrings.countriesJsonPath,
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
                    AppColors.black.withValues(alpha: 0.6),
                    AppColors.black.withValues(alpha: 0.2),
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
                        AppStrings.welcomeTitle,
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
                  FadeTransition(
                    opacity: _fadeAnim,
                    child: Text(
                      AppStrings.welcomeSubtitle,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.inter(
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
                  const SizedBox(height: 32),
                  FadeTransition(
                    opacity: _fadeAnim,
                    child: OpenContainer(
                      transitionType: ContainerTransitionType.fadeThrough,
                      openBuilder: (ctx, _) => const CountrySearchScreen(),
                      closedElevation: 6,
                      closedShape: StadiumBorder(),
                      closedColor: AppColors.green,
                      closedBuilder: (ctx, openContainer) {
                        return SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: openContainer,
                            style: ElevatedButton.styleFrom(
                              shape: const StadiumBorder(),
                              elevation: 6,
                              backgroundColor: AppColors.green,
                            ),
                            child: Text(
                              AppStrings.startButton,
                              style: GoogleFonts.inter(
                                color: AppColors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
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
