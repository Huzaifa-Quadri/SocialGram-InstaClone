import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

import 'package:instagram_clone/utils/theme_layout.dart';
import 'package:instagram_clone/widgets/text_field.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _registerEmailcontroller =TextEditingController();
  final TextEditingController _passwordcontroller = TextEditingController();
  final TextEditingController _biocontroller = TextEditingController();
  final TextEditingController _usernamecontroller = TextEditingController();
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 32,
          ),
          width: double.infinity,
          // color: Colors.yellow.shade50,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                flex: 3,
                child: Container(),
              ),
              //Todo SVG image insta logo
              SvgPicture.asset(
                "assets/images/ic_instagram.svg",
                color: primaryColor,
                height: 64,
              ),
              const Gap(64),

              Stack(
                children: [
                  const CircleAvatar(
                          foregroundImage: NetworkImage('https://cdn.pixabay.com/photo/2023/04/07/05/59/woman-7905583_1280.jpg'),
                          radius: 64,
                        ),
                  Positioned(
                    left: 80,
                    bottom: -10,
                    child: IconButton(
                      onPressed: (){},
                      icon: const Icon(Icons.camera_alt_sharp),
                    ),
                  ),
                ],
              ),
              const Gap(24),

              //todo text field of email and password
              TextFieldInput(
                  textEditingController: _registerEmailcontroller,
                  textInputType: TextInputType.emailAddress,
                  hintText: "xyz@example.com"),
              const Gap(24),
              TextFieldInput(
                textEditingController: _usernamecontroller,
                textInputType: TextInputType.text,
                isPaas: false,
                hintText: "Enter Your Username",
              ),
              const Gap(24),
              TextFieldInput(
                textEditingController: _passwordcontroller,
                textInputType: TextInputType.text,
                isPaas: true,
                hintText: "Enter Your Password",
              ),
              const Gap(24),
              TextFieldInput(
                textEditingController: _biocontroller,
                textInputType: TextInputType.text,
                isPaas: false,
                hintText: "Enter Your Bio",
              ),
              const Gap(24),

              //todo login button
              InkWell(
                onTap: (){},
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
                  child: const Text("Sign Up"),
                ),
              ),
              const Gap(12),
              Flexible(
                flex: 2,
                child: Container(),
              ), //? For even segment based spacing

              //todo transitioning to signing up screen
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Already have an account?"),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      "Sign In",
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
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
