import 'package:flutter/material.dart';

class RegistrationField extends StatelessWidget {
  final hint, keyboardType, isPassword, ctrl;
  RegistrationField({this.hint, this.keyboardType, this.isPassword, this.ctrl});

  @override
  Widget build(BuildContext context) {
    return TextField(
                      style: TextStyle(fontSize: 16, color: Colors.black),
                      keyboardType: keyboardType,
                      obscureText: isPassword,
                      controller: ctrl,
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
