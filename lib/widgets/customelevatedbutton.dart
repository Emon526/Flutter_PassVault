import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({
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
      child: ElevatedButton(
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
