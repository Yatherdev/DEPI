import 'package:flutter/material.dart';

import '../Widgets/custom_text_form_field.dart';
import '../Widgets/login_button.dart';
import 'home_page.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  String email = '';
  String password = '';

  void _login() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>HomePage()),(Route<dynamic> rout) => false );
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
    return Scaffold(
      backgroundColor: Colors.white60.withOpacity(.8),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("WE Say Hello!",style: TextStyle(fontSize: 40,fontWeight: FontWeight.bold),),
              Text("welcome back use your email and",style: TextStyle(color: Colors.black45),),
              Text("password to login",style: TextStyle(color: Colors.black45),),
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
              TextButton(onPressed: (){}, child: Text("Forgot password ?")),
              LoginButton(onPressed: _login),
            ],
          ),
        ),
      ),
    );
  }
}
