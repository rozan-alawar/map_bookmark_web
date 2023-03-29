import 'package:flutter/material.dart';
import 'package:minimal/common_widget/button.dart';
import 'package:minimal/routes.dart';
import 'package:minimal/utils/styles/color_manager.dart';
import 'package:minimal/utils/styles/styles_manager.dart';

const String listItemTitleText = "A BETTER BLOG FOR WRITING";
const String listItemPreviewText =
    "Sed elementum tempus egestas sed sed risus. Mauris in aliquam sem fringilla ut morbi tincidunt. Placerat vestibulum lectus mauris ultrices eros. Et leo duis ut diam. Auctor neque vitae tempus […]";

class IntroPage extends StatelessWidget {
  const IntroPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Image.asset(
            "assets/images/map.jpg",
            width: 2400,
            height: 1000,
            fit: BoxFit.cover,
          ),
          Container(
            color: ColorManager.black.withOpacity(0.5),
            width: 2400,
            height: 1000,
          ),
          Positioned(
            bottom: 200,
            left: 600,
            child: Material(
              elevation: 10,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: const EdgeInsets.all(32.0),
                child: Column(
                  children: [
                    Text(
                      'Welcome to Map Bookmark',
                      textAlign: TextAlign.center,
                      style: getBoldStyle(),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'With Map Bookmark, you can easily search for places\n add them to your favorites and save coordinates for\n future reference. Our user authentication system\n ensures that your data is kept private and secure.\n Explore the Gaza Strip like never before with\n Map Bookmark.',
                      textAlign: TextAlign.center,
                      style: getRegularStyle(fontSize: 13),
                    ),
                    const SizedBox(height: 40),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CommonButton(
                          onPressed: () {
                            Navigator.pushNamed(context, Routes.login);
                          },
                          child: const Text('Login'),
                        ),
                        const SizedBox(width: 16.0),
                        CommonButton(
                          color: ColorManager.transparent,
                          onPressed: () {
                            Navigator.pushNamed(context, Routes.signup);
                          },
                          child: Text('Signup', style: getMediumStyle()),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
