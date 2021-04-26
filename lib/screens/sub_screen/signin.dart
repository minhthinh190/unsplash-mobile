import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:unsplash_mobile/screens/sub_screen/signup.dart';
import 'package:unsplash_mobile/screens/home.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class SignInPage extends StatefulWidget {
  @override 
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  @override 
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,

          child: Stack(
            children: <Widget>[
              Positioned(
                top: 80,
                left: 40,

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Welcome,',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40),
                    ),
                    Text(
                      'Login to continue!',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24, color: Color(0xffbababa)),
                    ),
                  ]
                ),
              ),
              _SignInForm(),
              Positioned(
                bottom: 10,
                left: 105,

                child: Container(
                  alignment: Alignment.center,

                  child: Row(
                    children: <Widget>[
                      Text(
                        "Don't have an account? ",
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xffbababa)),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(context, MaterialPageRoute(
                            builder: (context) => SignUpPage(),
                          ));
                        },

                        child: Text(
                          'Join',
                          style: TextStyle(
                            fontSize: 16, 
                            fontWeight: FontWeight.bold, 
                            color: Color(0xff323232), 
                            decoration: TextDecoration.underline
                          ),
                        )
                      )
                    ]
                  )
                ),
              )
            ]
          )
        )
      ),
    );
  }
}

class _SignInForm extends StatefulWidget {
  @override 
  _SignInFormState createState() => _SignInFormState();
}

class _SignInFormState extends State<_SignInForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _obscurePassword = true;

  _toggleObscurePassword() {
    setState(() {
      _obscurePassword = !_obscurePassword;
    });
  }

  @override 
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,

      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 40),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,

          children: <Widget>[
            SizedBox(height: 40),
            Container(
              margin: EdgeInsets.only(bottom: 6),
              child: Text(
                'Email',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xff323232)),
              )
            ),
            TextFormField(
              style: TextStyle(
                fontSize: 20,
              ),
              controller: _emailController,
              decoration: const InputDecoration(
                isDense: true,
                contentPadding: EdgeInsets.all(10),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  borderSide: BorderSide(color: Color(0xff323232)),
                ),
              ),
                  
              validator: (String value) {
                RegExp re = RegExp(
                  r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))',
                );

                if (value.isEmpty) {
                  return 'Please enter your email';
                } else if (!re.hasMatch(value)) {
                  return 'Please enter a valid email!';
                }
                return null;
              },
            ),
            SizedBox(height: 30),
            // Password input field
            Container(
              margin: EdgeInsets.only(bottom: 6),
              child: Text(
                'Password',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xff323232)),
              )
            ),
            TextFormField(
              style: TextStyle(
                fontSize: 20,
              ),
              controller: _passwordController,
              decoration: InputDecoration(
                isDense: true,
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscurePassword? Icons.visibility : Icons.visibility_off,
                    color: Colors.grey,
                  ),
                  onPressed: _toggleObscurePassword,
                ),
                contentPadding: EdgeInsets.all(10),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  borderSide: BorderSide(color: Color(0xff323232)),
                ),
              ),
                  
              validator: (String value) {
                RegExp re = RegExp(
                  r'^(?=.*[a-zA-Z0-9]).{6,}',
                );

                if (value.isEmpty) {
                  return 'Please enter your password!';
                } else if (!re.hasMatch(value)) {
                  return 'Password must have at least 6 characters!';
                }
                return null;
              },
              obscureText: _obscurePassword,
            ),
            Container(
              padding: const EdgeInsets.only(top: 40),
              alignment: Alignment.center,

              child: ElevatedButton(
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                  backgroundColor: MaterialStateProperty.all<Color>(Color(0xff323232)),
                  padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                    EdgeInsets.symmetric(horizontal: 130, vertical: 10),
                  ),
                ),
                child: Text(
                  'Login',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),

                onPressed: () async {
                  if (_formKey.currentState.validate()) {
                    await _signInWithEmailAndPassword();
                  }
                }, 
              ),
            ),
          ],
        ),
      )
    );
  }

  @override 
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  Future<void> _signInWithEmailAndPassword() async {
    try {
      final User user = (await _auth.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text,
      ))
        .user;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('${user.email} signed in')),
      );

      Navigator.pushReplacement(context, MaterialPageRoute(
        builder: (context) => Home(),
      ));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to sign in with Email & Password' + e.toString())),
      );
    }
  }
}