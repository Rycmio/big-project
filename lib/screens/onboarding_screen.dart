import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:provider/provider.dart';

import './intro_screens/intro_page_1.dart';
import './intro_screens/intro_page_2.dart';
import './intro_screens/intro_page_3.dart';
import '../providers/login_out.dart';
import 'category_meals_screen.dart';

class OnBoardingScreen extends StatefulWidget {
  static const routeName = '/onboarding-screen';
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  PageController _controller = PageController();

  bool onLastPage = false;

  @override
  Widget build(BuildContext context) {
    final submitData = Provider.of<LogInOut>(context);
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _controller,
            onPageChanged: (index) {
              setState(() {
                onLastPage = (index == 2);
              });
            },
            children: [
              IntroPage1(),
              IntroPage2(),
              IntroPage3(),
            ],
          ),
          Container(
            alignment: Alignment(0, 1),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      _controller.previousPage(
                        duration: Duration(milliseconds: 300),
                        curve: Curves.easeIn,
                      );
                    },
                    child: Text(
                      'Back',
                    ),
                  ),
                  SmoothPageIndicator(
                    controller: _controller,
                    count: 3,
                    effect: JumpingDotEffect(
                      verticalOffset: 5,
                      dotHeight: 13,
                      dotWidth: 13,
                      activeDotColor: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  onLastPage
                      ? GestureDetector(
                          onTap: () async {
                            if (submitData.shopNameController.text.isEmpty ||
                                submitData.addressShopController.text.isEmpty ||
                                submitData.passwordController.text.isEmpty ||
                                submitData
                                    .confirmPasswordController.text.isEmpty ||
                                submitData.emailController.text.isEmpty) {
                              return showDialog(
                                context: context,
                                builder: (ctx) => AlertDialog(
                                  title: Text('Data tidak valid'),
                                  content: Text(
                                      'Mohon isi semua data yang diperlukan!'),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(ctx).pop();
                                      },
                                      child: Text('Oke'),
                                    ),
                                  ],
                                ),
                              );
                            }
                            if (RegExp(r'\s')
                                .hasMatch(submitData.emailController.text)) {
                              ScaffoldMessenger.of(context)
                                  .hideCurrentSnackBar();
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    'Email tidak boleh memiliki spasi!',
                                    style: TextStyle(color: Colors.redAccent),
                                  ),
                                  duration: Duration(seconds: 1),
                                ),
                              );
                              return;
                            }
                            if (!submitData.emailController.text
                                .endsWith('@gmail.com')) return;
                            if (submitData
                                        .confirmPasswordController.text.length <
                                    5 ||
                                submitData.passwordController.text.length < 5) {
                              return;
                            }
                            if (submitData.confirmPasswordController.text !=
                                submitData.passwordController.text) {
                              return showDialog(
                                context: context,
                                builder: (ctx) => AlertDialog(
                                  title: Text('Password salah!'),
                                  content: Text(
                                      'Masukkan konfimasi password sesuai dengan password'),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(ctx).pop();
                                      },
                                      child: Text('Oke'),
                                    ),
                                  ],
                                ),
                              );
                            }
                            submitData.submitFirstData(context);
                            Navigator.of(context).pushReplacementNamed(
                                CategoryMealsScreen.routeName);
                            print(submitData.shopName);
                            print(submitData.addressShop);
                            print(submitData.email);
                            print(submitData.password);
                            print(submitData.isLoggedIn);
                          },
                          child: Text(
                            'Done',
                          ),
                        )
                      : GestureDetector(
                          onTap: () {
                            _controller.nextPage(
                              duration: Duration(milliseconds: 300),
                              curve: Curves.easeIn,
                            );
                          },
                          child: Text(
                            'Next',
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
