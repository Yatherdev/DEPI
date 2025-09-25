import 'package:auth_buttons/auth_buttons.dart';
import 'package:flutter/material.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({super.key, required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: 16),
              backgroundColor: Colors.green.withOpacity(.7 ),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: Text(
              "Login",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(30),
          child: Text("Or Login With"),
        ),
        AuthButtonGroup(
          style: AuthButtonStyle(
            progressIndicatorColor: Colors.blue,
            progressIndicatorValueColor: Colors.grey[300],
            progressIndicatorStrokeWidth: 2.0,
            progressIndicatorValue: 1.0,
            width: 50,
            height: 50,
            progressIndicatorType: AuthIndicatorType.linear,
          ),
          buttons: [
            GoogleAuthButton(
              onPressed: () {},
              style: AuthButtonStyle(
                buttonType: AuthButtonType.icon,
              ),
            ),
            AppleAuthButton(
              onPressed: () {},
              style: AuthButtonStyle(
                buttonType: AuthButtonType.icon,
              ),
            ),
            FacebookAuthButton(
              onPressed: () {},
              style: AuthButtonStyle(
                buttonType: AuthButtonType.icon,
              ),
            ),
            MicrosoftAuthButton(
              onPressed: () {},
              style: AuthButtonStyle(
                buttonType: AuthButtonType.icon,
              ),
            ),
            TwitterAuthButton(
              onPressed: () {},
              style: AuthButtonStyle(
                buttonType: AuthButtonType.icon,
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(10),
          child: Row(crossAxisAlignment: CrossAxisAlignment.center,mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Don't have an account?"),
              TextButton(onPressed: () {}, child: Text("Sign Up")),
            ],
          ),
        ),
      ],
    );
  }
}
