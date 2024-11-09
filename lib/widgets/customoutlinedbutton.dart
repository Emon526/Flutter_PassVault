import 'package:flutter/material.dart';

class CustomOutlinedButton extends StatelessWidget {
  const CustomOutlinedButton({
    super.key,
    required this.ontap,
    required this.buttontext,
  });
  final Function ontap;
  final String buttontext;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton(
        onPressed: () {
          ontap();
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Text(
            buttontext,
          ),
        ),
      ),
    );
  }
}
