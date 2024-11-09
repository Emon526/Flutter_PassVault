import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import '../consts/consts.dart';
import '../provider/onboardprovider.dart';
import '../utils/utils.dart';
import '../widgets/customelevatedbutton.dart';
import 'auth/register.dart';

class OnBoardingSceen extends StatefulWidget {
  const OnBoardingSceen({super.key});

  @override
  State<OnBoardingSceen> createState() => _OnBoardingSceenState();
}

class _OnBoardingSceenState extends State<OnBoardingSceen> {
  PageController _controller = PageController();
  @override
  void initState() {
    _controller = PageController(
      initialPage: 0,
    );
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Consumer<OnBoardingProvider>(builder: (context, provider, child) {
      return PopScope(
        canPop: false,
        onPopInvokedWithResult: (bool didPop, dynamic) =>
            Utils(context).onWillPop(),
        child: Scaffold(
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: size.width * 0.04,
              ),
              child: Column(
                children: [
                  Expanded(
                    child: PageView.builder(
                      controller: _controller,
                      onPageChanged: (int index) {
                        provider.currentIndex = index;
                      },
                      itemCount: contents.length,
                      itemBuilder: (context, index) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: size.height * 0.07,
                            ),
                            SvgPicture.asset(
                              contents[index].image,
                              height: size.height * 0.2,
                            ),
                            SizedBox(
                              height: size.height * 0.07,
                            ),
                            Text(
                              contents[index].title,
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            SizedBox(
                              height: size.height * 0.07,
                            ),
                            Text(
                              contents[index].description,
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(
                                    color: Colors.grey,
                                  ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      contents.length,
                      (index) => buildDots(
                        context: context,
                        size: size,
                        index: index,
                        currentIndex: provider.currentIndex,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.01,
                  ),
                  CustomElevatedButton(
                    ontap: () {
                      if (provider.currentIndex == contents.length - 1) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const RegisterPage(),
                          ),
                        );
                      }
                      _controller.nextPage(
                        duration: const Duration(
                          microseconds: 100,
                        ),
                        curve: Curves.bounceIn,
                      );
                    },
                    buttontext: provider.currentIndex == contents.length - 1
                        ? "Continue"
                        : 'Next',
                  ),
                  SizedBox(
                    height: size.height * 0.01,
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }

  Widget buildDots({
    required int currentIndex,
    required int index,
    required BuildContext context,
    required Size size,
  }) {
    return Container(
      height: size.height * 0.015,
      width: currentIndex == index ? size.width * 0.05 : size.width * 0.025,
      margin: const EdgeInsets.only(
        right: 5,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Consts.BORDER_RADIUS),
        color: Theme.of(context).primaryColor,
      ),
    );
  }
}

class OnBoardingContent {
  String image;
  String title;
  String description;
  OnBoardingContent({
    required this.image,
    required this.title,
    required this.description,
  });
}

List<OnBoardingContent> contents = [
  OnBoardingContent(
    image: 'assets/vault.svg',
    title: Consts.TITLE_1,
    description: Consts.SUBTITLE_1,
  ),
  OnBoardingContent(
    image: 'assets/secure.svg',
    title: Consts.TITLE_2,
    description: Consts.SUBTITLE_2,
  ),
];
