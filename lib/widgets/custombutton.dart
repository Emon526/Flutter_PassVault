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
    // return Material(
    //   color: Theme.of(context).primaryColor,
    //   borderRadius: BorderRadius.circular(Consts.BORDER_RADIUS),
    //   child: InkWell(
    //     onTap: () {
    //       ontap();
    //     },
    //     borderRadius: BorderRadius.circular(Consts.BORDER_RADIUS),
    //     child: Center(
    //       heightFactor: 3,
    //       child: Text(
    //         buttontext,
    //         style: Theme.of(context)
    //             .textTheme
    //             .titleSmall!
    //             .copyWith(color: Colors.white),
    //       ),
    //     ),
    //   ),
    // );
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
            style: Theme.of(context)
                .textTheme
                .titleSmall!
                .copyWith(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
