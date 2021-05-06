import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

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
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 40),

            child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(top: 70, bottom: 50),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image.asset(
                        'assets/images/unsplash_logo.png', 
                        height: 36,
                      ),
                      Text(
                        '  Login',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 36),
                      ),
                    ],
                  )
                ),
                _SignInForm(),
                Container(
                  padding: EdgeInsets.only(bottom: 10, top: 254),
                  alignment: Alignment.center,

                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,

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

      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,

          children: <Widget>[
            SizedBox(height: 60),
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
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  backgroundColor: MaterialStateProperty.all<Color>(Color(0xff323232)),
                  padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                    EdgeInsets.symmetric(horizontal: 140, vertical: 10),
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
                    await _logInWithEmailAndPassword();
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

  Future<void> _logInWithEmailAndPassword() async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text,
      );

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('${userCredential.user.email} logged in.')),
      );
      Navigator.pushReplacement(context, MaterialPageRoute(
        builder: (context) => Home(),
      ));
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'user-not-found':
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('No user found for that email!'),
              backgroundColor: Colors.redAccent,  
            ),
          );
          break;
        case 'wrong-password':
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Wrong password!'),
              backgroundColor: Colors.redAccent,
            ),
          );
          break;
        default: 
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('An undefined error happened!'),
              backgroundColor: Colors.redAccent,
            ),
          );
      }
    }
  }
}