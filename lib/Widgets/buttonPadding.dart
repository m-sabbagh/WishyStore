import 'package:flutter/material.dart';
// import 'package:WishyStore/Pages/LogInPage.dart';

class ButtonPadding extends StatelessWidget {
  ButtonPadding({
    @required this.buttonName,
    @required this.buttonColor,
    @required this.onPressed,
  });

  final String? buttonName;
  final Color? buttonColor;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        color: buttonColor,
        borderRadius: BorderRadius.circular(30.0),
        elevation: 5.0,
        child: MaterialButton(
          onPressed: onPressed,
          minWidth: 200.0,
          height: 42.0,
          child: Text(
            buttonName!,
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
