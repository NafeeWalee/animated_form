import 'package:animated_form/utils/constants/appColor.dart';
import 'package:flutter/material.dart';

class MainButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String label;

  const MainButton({Key? key,required this.onPressed,required this.label}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(4),
      child: Container(
        width: double.infinity,
        height: 50,
        decoration: BoxDecoration(
          color: AppColor.blue,
          borderRadius: BorderRadius.circular(4)
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontFamily: 'M'
            ),
          ),
        ),
      ),
    );
  }
}
