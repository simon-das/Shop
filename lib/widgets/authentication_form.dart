import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/providers/auth_provider.dart';

class AuthenticationForm extends StatefulWidget {
  @override
  _AuthenticationFormState createState() => _AuthenticationFormState();
}

class _AuthenticationFormState extends State<AuthenticationForm> {
  bool signUp = false;
  final GlobalKey<FormState> _formKey = GlobalKey();
  String _email, _password;

  void submit() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      Provider.of<AuthProvider>(context, listen: false)
          .createUser(email: _email, password: _password);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'E-mail',
                ),
                validator: (value) {
                  if (value.isEmpty || !value.contains('@'))
                    return 'Please enter a valid email';
                  return null;
                },
                onSaved: (value) {
                  _email = value;
                },
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Password',
                ),
                validator: (value) {
                  if (value.length < 6)
                    return 'Password must be at least 6 characters long';
                  return null;
                },
                onSaved: (value) {
                  _password = value;
                },
              ),
              if (signUp)
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Confirm Password',
                  ),
                ),
              SizedBox(height: 20),
              Container(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  onPressed: submit,
                  child: Text(!signUp ? 'Sign In' : 'Register'),
                ),
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    signUp = !signUp;
                  });
                },
                child: Text(!signUp ? 'Register' : 'Sign In'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
