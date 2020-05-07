import 'package:flutter/material.dart';

class RegistrationField extends StatelessWidget {
  final hint, keyboardType, isPassword;
  RegistrationField({this.hint, this.keyboardType, this.isPassword});

  @override
  Widget build(BuildContext context) {
    return TextField(
                      style: TextStyle(fontSize: 16, color: Colors.black),
                      keyboardType: keyboardType,
                      obscureText: isPassword,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: hint,
                        contentPadding: const EdgeInsets.all(10),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    );
  }
}

class RegisterButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FlatButton(
                      child: Text(
                        'Signup',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      shape: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 2),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      padding: const EdgeInsets.all(15),
                      textColor: Colors.white,
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    );
  }
}