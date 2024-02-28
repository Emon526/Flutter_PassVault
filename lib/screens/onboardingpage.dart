import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../consts/consts.dart';
import '../utils/utils.dart';
import '../widgets/custombutton.dart';
import 'auth/register.dart';

class OnBoardingSceen extends StatefulWidget {
  const OnBoardingSceen({super.key});

  @override
  State<OnBoardingSceen> createState() => _OnBoardingSceenState();
}

class _OnBoardingSceenState extends State<OnBoardingSceen> {
  int currentIndex = 0;
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

    return PopScope(
      canPop: false,
      onPopInvoked: (bool didPop) => Utils(context).onWillPop(),
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  controller: _controller,
                  onPageChanged: (int index) {
                    setState(() {
                      currentIndex = index;
                    });
                  },
                  itemCount: contents.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: size.width * 0.07,
                      ),
                      child: Column(
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
                            style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 24,
                            ),
                          ),
                          SizedBox(
                            height: size.height * 0.07,
                          ),
                          Text(
                            contents[index].description,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 18,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  contents.length,
                  (index) => buildDots(index, context),
                ),
              ),
              Container(
                margin: const EdgeInsets.all(30),
                child: CustomButton(
                  ontap: () {
                    if (currentIndex == contents.length - 1) {
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
                  buttontext:
                      currentIndex == contents.length - 1 ? "Continue" : 'Next',
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildDots(int index, BuildContext context) {
    return Container(
      height: 10,
      width: currentIndex == index ? 25 : 10,
      margin: const EdgeInsets.only(
        right: 5,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
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
