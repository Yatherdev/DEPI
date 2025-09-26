import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:task/presentation/login_page.dart';

import '../Widgets/custom_button.dart';
import '../Widgets/custom_text_form_field.dart';
import '../Widgets/gradiant_scaffold.dart';
import '../Widgets/login_button.dart';
import 'home_page.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  String email = '';
  String password = '';

  void _Signup() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
        (Route<dynamic> rout) => false,
      );
    }
    print('Email : ${_emailController.text}');
    print('Password : ${_passwordController.text}');
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GradientScaffold(
      body:Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Lottie.asset(
                  'Assets/animation/splash.json',
                  width: 200,
                  height: 200,
                  fit: BoxFit.contain,
                  onLoaded: (composition) {
                    Future.delayed(composition.duration, () {
                      Duration(seconds: 20);
                    });
                  },
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(.4),
                    borderRadius: BorderRadius.circular(20)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        Text("Sign Up",style: TextStyle(fontSize: 35,fontWeight: FontWeight.bold),),
                        SizedBox(height: 20,),
                        CustomTextFormField(
                          autovalidateMode: AutovalidateMode.always,
                          controller: _emailController,
                          labelText: 'User Name',
                          hintText: 'Ahmed yasser',
                          prefixIcon: Icons.person,
                          isPassword: false,
                          keyboardType: TextInputType.name,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Enter Your Name';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 20,),
                        CustomTextFormField(
                          autovalidateMode: AutovalidateMode.always,
                          controller: _emailController,
                          labelText: 'Email',
                          hintText: 'example@gmail.com',
                          prefixIcon: Icons.email_outlined,
                          isPassword: false,
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Enter Your Email';
                            }if (!value.contains('@')){
                              return 'Please Enter Valid Email';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 20,),
                        CustomTextFormField(
                          autovalidateMode: AutovalidateMode.always,
                          controller: _passwordController,
                          labelText: "Password",
                          hintText: "example123##",
                          prefixIcon: Icons.lock_outline,
                          isPassword: true,
                          keyboardType: TextInputType.visiblePassword,
                          validator: (value) {
                            if (value == null ){
                              return "Enter Your Password" ;
                            }
                            if (value.length < 8) {
                              return 'Password must be at least 8 Characters';
                            }return null;
                          },
                        ),
                        SizedBox(height: 20,),
                        CustomTextFormField(
                          hintText: '',
                          autovalidateMode: AutovalidateMode.always,
                          controller: _passwordController,
                          labelText: "Confirm Password",
                          prefixIcon: Icons.lock_outline,
                          isPassword: true,
                          keyboardType: TextInputType.visiblePassword,
                          validator: (value) {
                            if (value == null ){
                              return "Enter Your Password" ;
                            }
                            if (value.length < 8) {
                              return 'Password must be at least 8 Characters';
                            }return null;
                          },
                        ),
                        CustomButton(onPressed: _Signup,),
                      ],
                    ),
                  ),
                ),
                LoginButton(onPressed: (){}),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(crossAxisAlignment: CrossAxisAlignment.center,mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("I have an account?"),
                      TextButton(onPressed: () {
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
                      }, child: Text("Login")),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
