import 'package:fluchat/widgets/pickers/user_image_picker.dart';
import 'package:flutter/material.dart';
import 'dart:io';

class AuthForm extends StatefulWidget {
  final void Function(
    String email,
    String username,
    String password,
    File? image,
    bool isLogin,
    BuildContext context,
  ) submitAuth;

  final bool isLoading;

  AuthForm(this.submitAuth, this.isLoading);

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  var _isLogin = true;
  var _userEmail = '';
  var _userName = '';
  var _userPassword = '';
  File? _userImage;

  void _pickedUserImage(File image) {
    _userImage = image;
  }

  void _submitForm() {
    final isValid = _formKey.currentState?.validate();
    FocusScope.of(context).unfocus();

    if (_userImage == null && !_isLogin) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please add an image!'),
        ),
      );
      return;
    }

    if (isValid == true) {
      _formKey.currentState?.save();
      widget.submitAuth(
        _userEmail.trim(),
        _userName.trim(),
        _userPassword.trim(),
        _userImage,
        _isLogin,
        context,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Center(
        child: SingleChildScrollView(
          child: Card(
            elevation: 5,
            margin: const EdgeInsets.all(20),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(
                        height: 15,
                      ),
                      if (!_isLogin) UserImagePicker(_pickedUserImage),
                      TextFormField(
                        key: ValueKey('email'),
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          labelText: 'Email address',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || !value.contains('@')) {
                            return 'Please add a valid email address';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _userEmail = value!;
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      if (!_isLogin)
                        TextFormField(
                          key: ValueKey('username'),
                          decoration: InputDecoration(
                            labelText: 'Username',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.length < 5) {
                              return 'Username should contains 5 characters';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _userName = value!;
                          },
                        ),
                      const SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        key: ValueKey('password'),
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.length < 8) {
                            return 'Password should be 8 characters long';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _userPassword = value!;
                        },
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      if (widget.isLoading) CircularProgressIndicator(),
                      if (!widget.isLoading)
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Theme.of(context).buttonColor,
                          ),
                          onPressed: _submitForm,
                          child: Text(_isLogin ? 'Login' : 'Signup'),
                        ),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            _isLogin = !_isLogin;
                          });
                        },
                        child: Text(
                          _isLogin
                              ? 'Create an account!'
                              : 'I already have an account',
                        ),
                        style: TextButton.styleFrom(
                          primary: Theme.of(context).buttonColor,
                        ),
                      )
                    ],
                  )),
            ),
          ),
        ),
      ),
    );
  }
}
