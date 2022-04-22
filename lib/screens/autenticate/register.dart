import 'package:first_app/shared/constants.dart';
import 'package:first_app/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:first_app/services/auth.dart';

class Register extends StatefulWidget {
  const Register({Key? key, required this.toggleView}) : super(key: key);

  final Function() toggleView;

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  String email = '';
  String password = '';
  String error = '';
  String firstName = '';
  String lastName = '';
  String phoneNumber = '';

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.blue[100],
            appBar: AppBar(
              backgroundColor: Colors.blue[400],
              elevation: 0.0,
              title: const Text('Sign up in to app'),
              actions: <Widget>[
                TextButton.icon(
                  icon: const Icon(
                    Icons.person,
                    color: Colors.black,
                  ),
                  label: const Text('Sign In',
                      style: TextStyle(color: Colors.black)),
                  onPressed: () {
                    widget.toggleView();
                  },
                )
              ],
            ),
            body: Container(
              padding:
                  const EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
              child: Form(
                key: _formKey,
                child: ListView(children: <Widget>[
                  const SizedBox(height: 20.0),
                  TextFormField(
                    decoration:
                        textInputDecoration.copyWith(hintText: 'First Name'),
                    onChanged: (val) {
                      setState(() => firstName = val);
                    },
                  ),
                  const SizedBox(height: 20.0),
                  TextFormField(
                    decoration:
                        textInputDecoration.copyWith(hintText: 'Last Name'),
                    onChanged: (val) {
                      setState(() => lastName = val);
                    },
                  ),
                  const SizedBox(height: 20.0),
                  TextFormField(
                    decoration:
                        textInputDecoration.copyWith(hintText: 'Phone number'),
                    onChanged: (val) {
                      setState(() => phoneNumber = val);
                    },
                  ),
                  const SizedBox(height: 20.0),
                  TextFormField(
                    decoration: textInputDecoration.copyWith(
                        hintText: 'Email: example@gmail.com'),
                    validator: (val) => val!.isEmpty ? 'Enter an Email' : null,
                    onChanged: (val) {
                      setState(() => email = val);
                    },
                  ),
                  const SizedBox(height: 20.0),
                  TextFormField(
                    decoration:
                        textInputDecoration.copyWith(hintText: 'Password'),
                    obscureText: true,
                    validator: (val) => val!.length < 6
                        ? 'Enter a password with at least 6 chars'
                        : null,
                    onChanged: (val) {
                      setState(() => password = val);
                    },
                  ),
                  const SizedBox(height: 20.0),
                  ElevatedButton(
                    child: const Text('Register'),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        setState(() => loading = true);
                        dynamic result =
                            await _auth.registerWithEmailAndPassword(email,
                                password, firstName, lastName, phoneNumber);
                        if (result == null) {
                          setState(() {
                            error = 'Please enter a valid email';
                            loading = false;
                          });
                        }
                      }
                    },
                  ),
                  const SizedBox(height: 12.0),
                  Text(
                    error,
                    style: TextStyle(color: Colors.red, fontSize: 14.0),
                  )
                ]),
              ),
            ),
          );
  }
}
