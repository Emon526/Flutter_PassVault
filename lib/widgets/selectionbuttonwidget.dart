import 'package:flutter/material.dart';

import '../consts/consts.dart';

class SelectionButtonWidget extends StatelessWidget {
  const SelectionButtonWidget({
    super.key,
    required this.ontap,
    required this.buttontitle,
    required this.iconCondition,
  });
  final Function ontap;
  final String buttontitle;
  final bool iconCondition;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(Consts.BORDER_RADIUS),
      onTap: () => ontap(),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              buttontitle,
            ),
            iconCondition
                ? const Icon(
                    Icons.check_circle,
                  )
                : const Icon(
                    Icons.radio_button_unchecked,
                  ),
          ],
        ),
      ),
    );
  }
}
