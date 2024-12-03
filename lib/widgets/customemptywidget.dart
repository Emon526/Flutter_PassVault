import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Customemptywidget extends StatelessWidget {
  final String svgString;
  final String emptyString;
  const Customemptywidget({
    super.key,
    required this.svgString,
    required this.emptyString,
  });

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: size.height * 0.1,
          ),
          SvgPicture.asset(
            svgString,
            height: size.height * 0.4,
          ),
          SizedBox(
            height: size.height * 0.01,
          ),
          Text(
            emptyString,
            style: Theme.of(context).textTheme.titleLarge,
          )
        ],
      ),
    );
  }
}
