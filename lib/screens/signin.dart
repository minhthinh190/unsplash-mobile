import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
                      'Sign in to continue!',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24, color: Color(0xffbababa)),
                    ),
                  ]
                ),
              ),
              _EmailPasswordForm(),
              Positioned(
                bottom: 10,
                left: 110,

                child: Container(
                  alignment: Alignment.center,

                  child: Row(
                    children: <Widget>[
                      Text(
                        'New to Unsplash? ',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xffbababa)),
                      ),
                      Text(
                        'Sign up',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xff323232), decoration: TextDecoration.underline),
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

class _EmailPasswordForm extends StatefulWidget {
  @override 
  _EmailPasswordFormState createState() => _EmailPasswordFormState();
}

class _EmailPasswordFormState extends State<_EmailPasswordForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

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
            Text(
              'Email',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xff323232)),
            ),
            TextFormField(
              style: TextStyle(
                fontSize: 20,
              ),
              controller: _emailController,
              decoration: const InputDecoration(
                isDense: true,
                contentPadding: EdgeInsets.fromLTRB(0, 5, 0, 7),
                border: UnderlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(0)),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(0)),
                  borderSide: BorderSide(color: Color(0xff323232)),
                ),
              ),
                  
              validator: (String value) {
                if (value.isEmpty) return 'Please enter your email!';
                return null;
              },
            ),
            SizedBox(height: 40),
            Text(
              'Password',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xff323232)),
            ),
            TextFormField(
              style: TextStyle(
                fontSize: 20,
              ),
              controller: _passwordController,
              decoration: const InputDecoration(
                isDense: true,
                contentPadding: EdgeInsets.fromLTRB(0, 5, 0, 7),
                border: UnderlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(0)),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(0)),
                  borderSide: BorderSide(color: Color(0xff323232)),
                ),
              ),
                  
              validator: (String value) {
                if (value.isEmpty) return 'Please enter your password!';
                return null;
              },
              obscureText: true,
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
                  'Sign In',
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
        email: _emailController.text,
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