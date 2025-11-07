import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:wall_e/login/view/login_page_mobile.dart';


class LoginPageParent extends StatelessWidget {
  const LoginPageParent({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout.builder(
        mobile: (BuildContext context) => LoginPageMobile(),
        tablet: (BuildContext context) => LoginPageMobile(),
        desktop: (BuildContext context) => LoginPageMobile(),
      );
  }
}
