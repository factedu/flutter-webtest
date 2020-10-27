import 'package:edqub/controllers/authentication.dart';
import 'package:edqub/screens/home-page.dart';
import 'package:edqub/screens/signup.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController _emailController, _passwordController;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  _signinWithEmail() {
    signin(_emailController.text, _passwordController.text).whenComplete(() =>
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => HomePage())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Center(
        child: Container(
          margin: EdgeInsets.all(15),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    hintText: 'Enter Email',
                    prefixIcon: Icon(
                      Icons.email_sharp,
                      size: 30,
                      // color: Theme.of(context).primaryColor,
                    ),
                    fillColor: Colors.white,
                    filled: true,
                    contentPadding: EdgeInsets.all(15),
                  ),
                  validator: (_val) {
                    if (_val.isEmpty) {
                      return "Email can't be empty";
                    } else {
                      return null;
                    }
                  },
                  keyboardType: TextInputType.emailAddress,
                ),
                SizedBox(height: 15),
                TextFormField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    hintText: 'Enter Password',
                    prefixIcon: Icon(
                      Icons.lock,
                      size: 30,
                      // color: Theme.of(context).primaryColor,
                    ),
                    fillColor: Colors.white,
                    filled: true,
                    contentPadding: EdgeInsets.all(15),
                  ),
                  validator: (_val) {
                    if (_val.isEmpty) {
                      return "Password can't be empty";
                    } else {
                      return null;
                    }
                  },
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: true,
                  obscuringCharacter: '*',
                ),
                SizedBox(height: 50),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(10),
                  child: RaisedButton(
                    child: Text(
                      'Login',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    onPressed: () {
                      if (!_formKey.currentState.validate()) {
                        return;
                      }
                      _signinWithEmail();
                    },
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                Center(
                  child: Text(
                    'OR',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
                SizedBox(height: 16),
                Center(
                  child: RaisedButton(
                    padding: EdgeInsets.all(15),
                    child: Text(
                      'Signin with Google',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    onPressed: () => funcGoogleSignIn().whenComplete(() =>
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => HomePage()))),
                    color: Colors.deepPurple,
                  ),
                ),
                SizedBox(height: 50),
                InkWell(
                  onTap: () {
                    Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => Signup()));
                  },
                  child: Center(
                    child: Text(
                      'Don\'t have an account yet? Signup Here',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
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
