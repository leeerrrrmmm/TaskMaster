import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:task_master/core/theme/app_colors.dart';
import 'package:task_master/core/theme/app_theme.dart';
import 'package:task_master/features/onboarding/data/model/onboarding_model.dart';
import 'package:task_master/features/onboarding/domain/onboarding_data.dart';

/// [OnboardingScreen]
class OnboardingScreen extends StatefulWidget {
  /// [OnboardingScreen] constructor
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: onboardingInfo.length,
            onPageChanged: (index) {
              setState(() => _currentPage = index);
            },
            itemBuilder: (_, index) {
              final data = onboardingInfo[index];

              return Stack(
                children: [
                  // Фон
                  Container(
                    height: 500,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [AppColors.purple500, AppColors.white],
                      ),
                    ),
                  ),

                  // Изображения
                  ImgInfo(data: data),

                  // Тексты
                  TextInfo(data: data),
                ],
              );
            },
          ),

          // Индикатор и кнопки (оставлены как есть)
          Buttons(
            currentPage: _currentPage,
            onTap: () => _currentPage != 3
                ? _pageController.nextPage(
                    duration: const Duration(seconds: 1),
                    curve: Curves.linearToEaseOut,
                  )
                : context.goNamed('login'),
            onTapSkip: () => _currentPage != 3
                ? _pageController.jumpToPage(3)
                : context.goNamed('register'),
          ),
        ],
      ),
    );
  }
}

///
class ImgInfo extends StatelessWidget {
  ///
  const ImgInfo({required this.data, super.key});

  ///
  final OnboardingModel data;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Positioned(
          left: 50,
          top: 160,
          child: FadeInRight(child: Image.asset(data.sImgPath)),
        ),
        Positioned(
          left: 60,
          child: FadeInLeft(child: Image.asset(data.fImgPath)),
        ),
      ],
    );
  }
}

///
class TextInfo extends StatelessWidget {
  ///
  const TextInfo({required this.data, super.key});

  ///
  final OnboardingModel data;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 200.0, left: 24, right: 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              data.text,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              data.description,
              style: const TextStyle(fontSize: 16, color: Colors.black54),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}

///
class Buttons extends StatelessWidget {
  ///
  const Buttons({
    required int currentPage,
    this.onTap,
    this.onTapSkip,
    super.key,
  }) : _currentPage = currentPage;

  final int _currentPage;

  ///
  final void Function()? onTap;

  ///
  final void Function()? onTapSkip;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 50.0, left: 24, right: 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                onboardingInfo.length,
                (i) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 2.0),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    width: _currentPage == i ? 20 : 8,
                    height: 4,
                    decoration: BoxDecoration(
                      color: _currentPage == i
                          ? AppColors.purple500
                          : AppColors.purple100,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            InkWell(
              onTap: onTap,
              child: Container(
                width: double.infinity,
                height: 48,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      AppColors.purple500,
                      AppColors.purple600,
                      AppColors.purple800,
                    ],
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Center(
                  child: Text(
                    _currentPage != 3 ? 'Next' : 'Sign In',
                    style: const TextStyle(
                      color: AppColors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            InkWell(
              onTap: onTapSkip,
              child: Container(
                width: double.infinity,
                height: 48,
                decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xff7a5af8)),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Center(
                  child: Text(
                    _currentPage != 3 ? 'Skip' : 'Sign Up',
                    style: TextStyle(
                      color: AppTheme.lightTheme.primaryColor,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
