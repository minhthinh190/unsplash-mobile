import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:unsplash_mobile/screens/sub_screen/signin.dart';
import 'package:unsplash_mobile/screens/home.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class SignUpPage extends StatefulWidget {
  @override 
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  @override 
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 40),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(top: 70, bottom: 50),
                  child: Row(
                    children: <Widget>[
                      Image.asset(
                        'assets/images/unsplash_logo.png', 
                        height: 36,
                      ),
                      Text(
                        '  Join Unsplash',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 36),
                      ),
                    ]
                  )
                ),
                _SignUpForm(),
                Container(
                  padding: EdgeInsets.only(bottom: 10),
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,

                    children: <Widget>[
                      Text(
                        'Already have an account? ',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xffbababa)),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(context, MaterialPageRoute(
                            builder: (context) => SignInPage(),
                          ));
                        },
                        child: Text(
                          'Login',
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

class _SignUpForm extends StatefulWidget {
  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<_SignUpForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _firstnameController = TextEditingController();
  final TextEditingController _lastnameController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmController = TextEditingController();

  bool _obscurePassword = true;
  bool _obscureConfirm = true;

  _toggleObscurePassword() {
    setState(() {
      _obscurePassword = !_obscurePassword;
    });
  }

  _toggleObscureConfirm() {
    setState(() {
      _obscureConfirm = !_obscureConfirm;
    });
  }

  Future<void> _createAccount(String email, String firstname, String lastname, String location, String password) async {
    try {
      // create account in Firebase Authentication
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // create user in Firestore
      CollectionReference users = FirebaseFirestore.instance.collection('Users');
      users.doc(email).set({
        'email': email,
        'first name': firstname,
        'last name': lastname,
        'name': firstname + ' ' + lastname,
        'location': location,
        'total_photos': 0,
        'profile_image': 'https://iupac.org/wp-content/uploads/2018/05/default-avatar.png',
      })
      .then((value) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Welcome to Unsplash!')),
        );
      })
      .catchError((e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to create account!')),
        );
      });
    } on FirebaseAuthException catch(e) {
      if (e.code == 'email-already-in-use') {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Email already existed!')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    }
  }

  Future<void> _logInWithEmailAndPassword() async {
    try {
      final User user = (await _auth.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text
      ))
      .user;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('${user.email} logged in.')),
      );
      Navigator.pushReplacement(context, MaterialPageRoute(
        builder: (context) => Home(),
      ));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to login!' + e.toString())),
      );
    } 
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
            // Email input field
            Container(
              margin: EdgeInsets.only(bottom: 6),
              child: Text(
                'Email address',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xff323232)),
              )
            ),
            TextFormField(
              controller: _emailController,
              validator: (String value) {
                RegExp re = RegExp(
                  r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))',
                );

                if (value.isEmpty) {
                  return 'Please enter your email!';
                } else if (!re.hasMatch(value)) {
                  return 'Please enter a valid email!';
                }
                return null;
              },

              style: TextStyle(fontSize: 20),
              decoration: InputDecoration(
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
            ),
            SizedBox(height: 30),
            // First name input field
            Container(
              margin: EdgeInsets.only(bottom: 6),
              child: Text(
                'First name',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xff323232)),
              )
            ),
            TextFormField(
              controller: _firstnameController,
              validator: (String value) {
                if (value.isEmpty) {
                  return 'Please enter your first name!';
                }
                return null;
              },

              style: TextStyle(fontSize: 20),
              decoration: InputDecoration(
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
            ),
            SizedBox(height: 30),
            // Last name input field
            Container(
              margin: EdgeInsets.only(bottom: 6),
              child: Text(
                'Last name',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xff323232)),
              )
            ),
            TextFormField(
              controller: _lastnameController,
              validator: (String value) {
                if (value.isEmpty) {
                  return 'Please enter your last name!';
                }
                return null;
              },

              style: TextStyle(fontSize: 20),
              decoration: InputDecoration(
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
            ),
            SizedBox(height: 30),
            // Location input field
            Container(
              margin: EdgeInsets.only(bottom: 6),
              child: Text(
                'Location',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xff323232)),
              )
            ),
            TextFormField(
              controller: _locationController,
              validator: (String value) {
                if (value.isEmpty) {
                  return 'Please enter your location!';
                }
                return null;
              },

              style: TextStyle(fontSize: 20),
              decoration: InputDecoration(
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
            ),
            SizedBox(height: 70),
            // Password input field
            Container(
              margin: EdgeInsets.only(bottom: 6),
              child: Row(
                children: <Widget>[
                  Text(
                    'Password ',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xff323232)),
                  ),
                  Text(
                    "(min. 6 char)",
                    style: TextStyle(fontSize: 20, color: Color(0xff808080)),
                  )
                ]
              )
            ),
            TextFormField(
              controller: _passwordController,
              validator: (String value) {
                if (value.isEmpty) {
                  return 'Please enter your password!';
                } else if (value.length < 6) {
                  return 'Password must have at least 6 characters!';
                }
                return null;
              },

              style: TextStyle(fontSize: 20),
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
              obscureText: _obscurePassword,
            ),
            SizedBox(height: 30),
            // Password comfirm input field
            Container(
              margin: EdgeInsets.only(bottom: 6),
              child: Text(
                'Confirm',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xff323232)),
              )
            ),
            TextFormField(
              controller: _confirmController,
              validator: (String value) {
                if (value.isEmpty) {
                  return 'Confirm your password!';
                } else if (value != _passwordController.text) {
                  return 'Password does not match!';
                }
                return null;
              },

              style: TextStyle(fontSize: 20),
              decoration: InputDecoration(
                isDense: true,
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscureConfirm? Icons.visibility : Icons.visibility_off, 
                    color: Colors.grey
                  ),
                  onPressed: _toggleObscureConfirm,
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
              obscureText: _obscureConfirm,
            ),
            SizedBox(height: 60),
            Container(
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
                  'Join',
                  style: TextStyle(fontSize: 20),
                ),
                onPressed: () async {
                  if (_formKey.currentState.validate()) {
                    await _createAccount(
                      _emailController.text.trim(),
                      _firstnameController.text,
                      _lastnameController.text,
                      _locationController.text,
                      _passwordController.text,
                    );
                    await _logInWithEmailAndPassword();
                  }
                },
              ),
            ),
            SizedBox(height: 60),
          ],
        ),
      ),
    );
  }
}
