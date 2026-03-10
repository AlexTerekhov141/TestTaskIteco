import 'package:flutter/material.dart';
import 'package:itecotesttask/features/onboarding/widgets/TopIndicators.dart';

import '../../core/constants.dart';
import '../../models/slide_data.dart';

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

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme colorScheme = theme.colorScheme;
    final bool isLastPage = _currentIndex == _slides.length - 1;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            const SizedBox(height: 20),
            Text(
              'Iteco',
              textAlign: TextAlign.center,
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w700,
                color: Base.c950,
              ),),
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
                            textAlign: TextAlign.center,
                            style: theme.textTheme.headlineSmall?.copyWith(
                              fontWeight: FontWeight.w700,
                              color: Base.c950,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Text(
                              slide.subtitle,
                              textAlign: TextAlign.center,
                              style: theme.textTheme.bodyMedium?.copyWith(
                                height: 1.45,
                                color: Base.c700,
                              ),
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
                  onPressed: ()=><dynamic, dynamic>{},
                  style: FilledButton.styleFrom(
                    backgroundColor: Green.c500,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: Text(
                    isLastPage ? 'Get started' : 'Next',
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: colorScheme.onPrimary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
            TextButton(
              onPressed: ()=><dynamic, dynamic>{},
              child: Text(
                isLastPage ? 'Finish' : 'Skip',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: Base.c700,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}

