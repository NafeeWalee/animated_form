import 'package:animated_form/utils/constants/appColor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {

  final VoidCallback? onTap;
  final Function(String)? onChanged;
  final Function(String)? onSubmitted;

  final IconData? prefixIcon;
  final Widget? suffixIcon;
  final String? hintText;
  final String? prefixText;
  final TextEditingController? controller;
  final bool? obscure;
  final bool? enabled;
  final TextAlign? textAlign;
  final TextInputType? inputType;
  final TextInputAction? keyboardType;
  final FocusNode? node;
  final List<TextInputFormatter> inputFormatter;
  final int? maxLength;

  const CustomTextField({
    Key? key,
    this.prefixIcon,
    this.hintText,
    this.controller,
    this.obscure = false,
    this.onTap,
    this.enabled = true,
    this.textAlign = TextAlign.start,
    this.inputType = TextInputType.text,
    this.inputFormatter = const [],
    this.onChanged,
    this.keyboardType,
    this.onSubmitted,
    this.node,
    this.prefixText = '',
    this.maxLength,
    this.suffixIcon,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 45,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          border: Border.all(color: AppColor.lightGrey),
          color: Colors.white
        ),
        child: TextField(
          maxLength: maxLength,
          focusNode: node,
          textInputAction: keyboardType,
          onChanged: onChanged,
          onSubmitted: onSubmitted,
          inputFormatters: inputFormatter,
          keyboardType: inputType,
          textAlign: textAlign!,
          enabled: onTap == null ? enabled : false,
          obscureText: obscure!,
          controller: controller,
          decoration: InputDecoration(
              counterText: "",
            hintText: node!.hasFocus && prefixText != ''?'':hintText,
            hintStyle: TextStyle(
                fontSize: 16,
              fontFamily: 'R',
              color: AppColor.lightGrey
            ),
              prefixIcon: prefixIcon != null ? Padding(
                padding: const EdgeInsets.only(left:12.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      prefixIcon,
                      color: AppColor.blue,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left:10.0),
                      child: Text(
                        node!.hasFocus || controller!.text != ''?'$prefixText':'',
                        style: TextStyle(
                            fontSize: 16,
                        ),
                      ),
                    )
                  ],
                ),
              ) : null,
              suffixIcon: suffixIcon,

            border: OutlineInputBorder(
              borderSide: BorderSide.none
            ),
            contentPadding: prefixIcon == null ? EdgeInsets.symmetric(horizontal: 10) : EdgeInsets.zero
          ),
        ),
      ),
    );
  }
}
