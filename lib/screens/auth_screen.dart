import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/_auth.dart';

enum AuthMode { signUp, login }

class AuthScreen extends StatelessWidget {
  static const routeName = '/auth';

  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    final transformConfig = Matrix4.rotationZ(-8 * pi / 180);
    transformConfig.translate(10.0);
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    colors: [
                      Color.fromRGBO(215, 117, 255, 0.5),
                      Color.fromRGBO(255, 188, 117, 0.9)
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    stops: [0, 1])),
          ),
          SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(1.0),
              height: deviceSize.height,
              width: deviceSize.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Flexible(
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 20.0),
                      padding: const EdgeInsets.symmetric(
                        vertical: 8.0,
                        horizontal: 94.0,
                      ),

                      // transform: Matrix4.rotationZ(-8 * pi / 180)     // Important code
                      //   ..translate(-10.0),
                      transform: transformConfig,

                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.deepOrange.shade900,
                          boxShadow: const [
                            BoxShadow(
                              blurRadius: 8,
                              color: Colors.black26,
                              offset: Offset(0, 2),
                            )
                          ]),
                      child: Text(
                        'MyShop',
                        style: TextStyle(
                            color: Theme.of(context)
                                .accentTextTheme
                                .titleMedium!
                                .color,
                            fontSize: 50,
                            fontFamily: 'Anton',
                            fontWeight: FontWeight.normal),
                      ),
                    ),
                  ),
                  Flexible(
                      flex: deviceSize.width > 600 ? 2 : 1,
                      child: const AuthCard())
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class AuthCard extends StatefulWidget {
  const AuthCard({super.key});

  @override
  State<AuthCard> createState() => _AuthCardState();
}

class _AuthCardState extends State<AuthCard> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  AuthMode _authMode = AuthMode.login;

  final Map<String, String> _authData = {
    'email': '',
    'password': '',
  };

  var _isLoading = false;
  final _passwordController = TextEditingController();

 Future<void> _submit() async  {
    print('submit submit submit submit subbmit submit submit submit');
    if (!_formKey.currentState!.validate()) {
      print('##########################');
      return;
    }
    print('***************************');
    _formKey.currentState!.save();
    setState(() {
      _isLoading = true;
    });
    print('4444444444444444444444444');
    // try{
      if (_authMode == AuthMode.login)  {
        // log user in
        await Provider.of<Auth>(context,listen: false).signUp(_authData['email']!, _authData['password']!);
      } else {
        // sign up user
        await Provider.of<Auth>(context, listen: false)
            .signUp(_authData['email']!, _authData['password']!);
      }

 }

  void _switchAuthMode() {
    if (_authMode == AuthMode.login) {
      setState(() {
        _authMode = AuthMode.signUp;
      });
    } else {
      setState(() {
        _authMode = AuthMode.login;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      elevation: 8.0,
      child: Container(
        height: _authMode == AuthMode.signUp ? 300 : 260,
        constraints:
            BoxConstraints(minHeight: _authMode == AuthMode.signUp ? 320 : 260),
        width: deviceSize.width * 0.75,
        padding: const EdgeInsets.all(16.0),
        child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Email'),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value!.isEmpty || !value.contains('@')) {
                        return 'Invalid email';
                      }
                    },
                    onSaved: (value) {
                      _authData['email'] = value!;
                    },
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Password'),
                    obscureText: true,
                    controller: _passwordController,
                    validator: (value) {
                      if (value!.isEmpty || value.length < 5) {
                        return 'Password is too short';
                      }
                    },
                    onSaved: (value) {
                      _authData['password'] = value!;
                    },
                  ),
                  if (_authMode == AuthMode.signUp)
                    TextFormField(
                      enabled: _authMode == AuthMode.signUp,
                      decoration:
                          const InputDecoration(labelText: 'Confirm Password'),
                      obscureText: true,
                      validator: _authMode == AuthMode.signUp
                          ? (value) {
                              if (value != _passwordController.text) {
                                return 'Passwords do not match!';
                              }
                            }
                          : null,
                    ),
                  const SizedBox(
                    height: 20,
                  ),
                  if (_isLoading)
                    const CircularProgressIndicator()
                  else
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 30.0, vertical: 8.0),
                            backgroundColor: Theme.of(context).primaryColor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30))),
                        onPressed: _submit,
                        child: Text(
                          _authMode == AuthMode.login ? 'LOGIN' : 'SIGNUP',
                          style: TextStyle(
                              color: Theme.of(context)
                                  .primaryTextTheme
                                  .labelLarge!
                                  .color),
                        )),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 30, vertical: 4),
                    child: TextButton(
                      onPressed: _switchAuthMode,
                      child: Text(
                        '${_authMode == AuthMode.login ? 'SIGNUP' : 'LOGIN'} INSTEAD',
                        style: TextStyle(color: Theme.of(context).primaryColor),
                      ),
                    ),
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
