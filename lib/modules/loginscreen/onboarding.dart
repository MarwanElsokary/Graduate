import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:project/modules/loginscreen/loginScreen.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  List<Map<String, String>> onboardingData = [
    {
      "image": "images/onboarding1.png",
      "title": "Welcome to",
      "description": "Experience the ease of appoint your doctor",
    },
    {
      "image": "images/onboarding3.png",
      "title": "Make your appointment easy!",
      "description": "Your health is safe with us",
    },
    {
      "image": "images/onboarding2.png",
      "title": "Your doctors are Here!",
      "description": "Say hello to your new doctor",
    },
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: onboardingData.length,
            onPageChanged: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            itemBuilder: (context, index) {
              return _buildPage(index);
            },
          ),
          _buildSkipButton(),
          _buildDotsIndicator(),
          _buildNavigationButtons(),
        ],
      ),
    );
  }

  Widget _buildPage(int index) {
    return Stack(
      children: [
        Container(
          color: Color(0xFFB8F5FF),
          child: Column(
            children: [
              Expanded(
                flex: 6,
                child: Container(
                ),
              ),

              Expanded(
                flex: 4,
                child: ClipPath(
                  clipper: CurveClipper(),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Color(0xFFDBF9FE),
                      borderRadius: BorderRadiusDirectional.only(
                        topStart: Radius.circular(30),
                        topEnd: Radius.circular(30),

                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
         Column(
            children: [
              Expanded(
                flex: 6,
                child: Align(
                  alignment: Alignment.center,
                  child: Image.asset(
                    onboardingData[index]["image"]!,
                    height: 400,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              Expanded(
                flex: 4,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadiusDirectional.only(
                      topStart: Radius.circular(30),
                      topEnd: Radius.circular(30),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        onboardingData[index]["title"]!,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF004E7F),
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 20),
                      Text(
                        onboardingData[index]["description"]!,
                        style: TextStyle(
                          fontSize: 18,
                          color: Color(0xFF8C8C8C),
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 30),
                    ],
                  ),
                ),
              )
            ],
          ),

      ],
    );
  }

  Widget _buildSkipButton() {
    return Positioned(
      top: 50,
      right: 20,
      child: GestureDetector(
        onTap: () => _completeOnboarding(context),
        child: Text(
          "Skip",
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w500,
            color: Color(0xFF004E7F),
          ),
        ),
      ),
    );
  }

  Widget _buildDotsIndicator() {
    return Positioned(
      bottom: 110,
      left: 0,
      right: 0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
          onboardingData.length,
          (index) => AnimatedContainer(
            duration: Duration(milliseconds: 300),
            margin: EdgeInsets.symmetric(horizontal: 5),
            width: _currentIndex == index ? 12 : 8,
            height: 8,
            decoration: BoxDecoration(
              color: _currentIndex == index ? Color(0xFF004E7F) : Colors.grey,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavigationButtons() {
    return Positioned(
      bottom: 40,
      left: 20,
      right: 20,
      child: _currentIndex == 0
          ? _buildNextButton()
          : Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildBackButton(),
                _buildNextOrGetStartedButton(),
              ],
            ),
    );
  }

  Widget _buildNextButton() {
    return SizedBox(
      height: 55,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          _pageController.nextPage(
            duration: Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
        },
        style: ElevatedButton.styleFrom(
          textStyle: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
          backgroundColor: Color(0xFF004E7F),
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        child: Text("Next"),
      ),
    );
  }

  Widget _buildBackButton() {
    return SizedBox(
      width: 150,
      height: 50,
      child: OutlinedButton(
        onPressed: () {
          _pageController.previousPage(
            duration: Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: Color(0xFF004E7F),
          textStyle: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
        child: Text(
          "Back",
          style: TextStyle(color: Color(0xFF004E7F)),
        ),
      ),
    );
  }

  Widget _buildNextOrGetStartedButton() {
    return SizedBox(
      width: 150,
      height: 50,
      child: ElevatedButton(
        onPressed: () {
          if (_currentIndex < onboardingData.length - 1) {
            _pageController.nextPage(
              duration: Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            );
          } else {
            _completeOnboarding(context);
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xFF004E7F),
          foregroundColor: Colors.white,
          textStyle: TextStyle(fontSize: 20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        child: Text(
          _currentIndex == onboardingData.length - 1 ? "Get Started" : "Next",
        ),
      ),
    );
  }

  Future<void> _completeOnboarding(BuildContext context) async {
    try {
      final box = Hive.box('appBox');
      await box.put('onboarding_seen', true);

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => loginScreen()),
        (Route<dynamic> route) => false,
      );
    } catch (e) {
      print('Error completing onboarding: $e');
      // Fallback في حالة حدوث خطأ
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => loginScreen()),
      );
    }
  }
}

class CurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height - 80);
    path.quadraticBezierTo(
      size.width / 2,
      size.height,
      size.width,
      size.height - 80,
    );
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
