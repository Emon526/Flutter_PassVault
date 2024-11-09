import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../consts/consts.dart';

class Utils {
  BuildContext context;
  Utils(this.context);
  Size get getScreenSize => MediaQuery.of(context).size;

  void onWillPop() async {
    showCustomDialog(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Are you sure?',
            style: Theme.of(context).textTheme.titleSmall!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(
            height: 20,
          ),
          const Text(
            'Are you sure you want to leave this page?',
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text(
                  'No',
                ),
              ),
              TextButton(
                onPressed: () => SystemNavigator.pop(),
                child: const Text(
                  'Yes',
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Future showCustomDialog({required Widget child}) async {
    return await showCupertinoModalPopup(
      barrierDismissible: true,
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Consts.BORDER_RADIUS),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Stack(
            children: [
              Positioned(
                right: 0,
                child: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const Icon(
                    Icons.close,
                    size: 20.0,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 30,
                ),
                child: child,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showSnackBar({required String snackText}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(snackText),
      ),
    );
  }
}
