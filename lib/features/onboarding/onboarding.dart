import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:itecotesttask/core/routes.gr.dart';
import 'package:itecotesttask/features/onboarding/widgets/TopIndicators.dart';
import '../../models/slide_data.dart';

@RoutePage()
class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key,});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();

}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  static const List<SlideData> _slides = <SlideData>[
    SlideData(
      title: 'Test task for Iteco',
      subtitle:
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi non nulla vehicula, pellentesque velit quis, iaculis ligula.',
      image: Image(image: AssetImage('assets/images/onboarding/1.jpg')),
    ),
    SlideData(
      title: 'Scrolling app',
      subtitle:
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi non nulla vehicula, pellentesque velit quis, iaculis ligula.',
      image: Image(image: AssetImage('assets/images/onboarding/2.jpg')),
    ),
    SlideData(
      title: 'Flutter app',
      subtitle:
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi non nulla vehicula, pellentesque velit quis, iaculis ligula.',
      image: Image(image: AssetImage('assets/images/onboarding/3.jpg')),
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _last(){
    if (_currentIndex == _slides.length - 1) {
      context.router.replace(const ScrollingRoute());
      return;
    }
  }

  void _next() {
    _pageController.nextPage(
      duration: const Duration(milliseconds: 280),
      curve: Curves.easeOutCubic,
    );
  }

  void _skip() {
    _pageController.animateToPage(
        _slides.length - 1,
        duration: const Duration(milliseconds: 280),
        curve: Curves.easeOutCubic
    );
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final bool isLastPage = _currentIndex == _slides.length - 1;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            const SizedBox(height: 20),
            Text(
              'Iteco',
              style: theme.textTheme.headlineMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12,),
            TopIndicators(
              itemCount: _slides.length,
              currentIndex: _currentIndex
            ),
            Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: _slides.length,
                  onPageChanged: (int index) {
                    setState(() {
                      _currentIndex = index;
                    });
                  },
                  itemBuilder: (BuildContext context, int index){
                    final SlideData slide = _slides[index];

                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                      child: Column(
                        children: <Widget>[
                          const Spacer(),
                          Expanded(
                            flex: 7,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 12),
                              child: slide.image,
                            ),
                          ),
                          const SizedBox(height: 24),
                          Text(
                            slide.title,
                            style: theme.textTheme.titleMedium,
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 12),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Text(
                              slide.subtitle,
                              style: theme.textTheme.bodyMedium,
                              textAlign: TextAlign.center,
                            ),
                          ),
                          const Spacer(),
                        ],
                      ),
                    );
                  }
                )
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 8, 24, 10),
              child: SizedBox(
                width: double.infinity,
                height: 52,
                child: FilledButton(
                  onPressed: isLastPage ? _last : _next,
                  child: Text(isLastPage ? 'Get started' : 'Next',),
                ),
              ),
            ),
            TextButton(
              onPressed: isLastPage ? _last : _skip,
              child: Text(isLastPage ? 'Finish' : 'Skip',),
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}

