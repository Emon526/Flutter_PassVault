import 'package:flutter/material.dart';
import '../consts/consts.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.ontap,
    required this.buttontext,
  });
  final Function ontap;
  final String buttontext;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(Consts.BORDER_RADIUS),
      child: InkWell(
        onTap: () {
          ontap();
        },
        borderRadius: BorderRadius.circular(Consts.BORDER_RADIUS),
        child: Center(
          heightFactor: 3,
          child: Text(buttontext,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              )),
        ),
      ),
    );
  }
}
