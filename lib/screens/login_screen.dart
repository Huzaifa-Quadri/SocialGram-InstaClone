import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:instagram_clone/resources/auth.dart';
import 'package:instagram_clone/screens/signup_screen.dart';
import 'package:instagram_clone/utils/global_variables.dart';

import 'package:instagram_clone/utils/theme_layout.dart';
import 'package:instagram_clone/utils/utils.dart';
import 'package:instagram_clone/widgets/text_field.dart';
import 'package:instagram_clone/responsive/app_screen_layout.dart';
import 'package:instagram_clone/responsive/responsive_layout.dart';
import 'package:instagram_clone/responsive/web_screen_layout.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailInputController = TextEditingController();
  final TextEditingController _passwordInputController = TextEditingController();
  bool isLoading = false;

  void loginUser() async {
    setState(() {
        isLoading = true;
      });
    String res = await AuthMethodFirebaseLogic().signInUser(
        email: _emailInputController.text,
        password: _passwordInputController.text,
      );
    if (mounted) {
      setState(() {
        isLoading = false;
      });
      if (res == "success") {
        showSnackBar(context, "Welcome!");
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) {
            return const ResponsiveLayoutScreen(
              appScreenLayout: AppScreenLayout(),
              webScreenLayout: WebScreenLayout(),
            );
          }));
      } else {
        showSnackBar(context, res);
      }
    }
  }

  @override
  void dispose() {
    _emailInputController.dispose();
    _passwordInputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: MediaQuery.of(context).size.width > webScreenwidthSize ? EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*0.3) : const EdgeInsets.symmetric(
            horizontal: 32,
          ),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                flex: 3,
                child: Container(),
              ),
              //Todo SVG image insta logo
              SvgPicture.asset(
                "assets/images/SocialGram.svg",  //* New app wordmark
                height: 44,
                color: primaryColor,
              ),
              const Gap(72),

              //* Custom text field of email and password
              TextFieldInput(
                  textEditingController: _emailInputController,
                  textInputType: TextInputType.emailAddress,
                  hintText: "Email",
              ),
              const Gap(24),
              TextFieldInput(
                textEditingController: _passwordInputController,
                textInputType: TextInputType.text,
                isPaas: true,
                hintText: "Enter Your Password",
              ),

              // Row(   //* Forgot Password button
              //   children: [
              //     Spacer(),
              //     TextButton(onPressed: (){}, child: const Text("Forgot Password ?",) ),
              //   ],
              // ),
              
              const Gap(24),

              //todo backend login button
              InkWell(
                onTap: loginUser,
                child: Container(
                  alignment: Alignment.center,
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: const ShapeDecoration(
                    color: Colors.blue,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                      Radius.circular(7),
                    )),
                  ),
                  child: const Text("Log in"),
                ),
              ),
              const Gap(12),
              Flexible(       //? For even segment based spacing
                flex: 2,
                child: Container(),
              ), 

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don't Have an account?"),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const SignupScreen(),
                      ));
                    },
                    child: const Text(
                      "Sign Up",
                      style: TextStyle(
                        color: Colors.blue, fontWeight: FontWeight.bold
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
