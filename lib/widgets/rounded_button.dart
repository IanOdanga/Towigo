import 'package:flutter/material.dart';
import 'package:towigo/pallete.dart';

class RoundedButton extends StatelessWidget {
  const RoundedButton({
    required this.buttonName,
  }) : super();

  final String buttonName;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.08,
      width: size.width * 0.8,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: kBlue,
      ),
      child: FlatButton(
        onPressed: () {},
        child: Text(
          buttonName,
          style: kBodyText.copyWith(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
