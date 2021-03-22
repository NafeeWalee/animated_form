import 'dart:async';

import 'package:animated_form/mainApp/widgets/mainButton.dart';
import 'package:animated_form/mainApp/widgets/textField.dart';
import 'package:animated_form/utils/constants/appColor.dart';
import 'package:animated_form/utils/keyboardDetector.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/utils.dart';
import 'package:get/get.dart';
import 'package:pinput/pin_put/pin_put.dart';


class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {


  final _formKey = GlobalKey<FormState>();

  ///login page

  final TextEditingController mobileNoLogin = TextEditingController();
  final TextEditingController passwordLogin = TextEditingController();

  final FocusNode mobileNoLoginNode = FocusNode();
  final FocusNode passwordLoginNode = FocusNode();

  /// registration page
  final TextEditingController firstName = TextEditingController();
  final TextEditingController lastName = TextEditingController();
  final TextEditingController mobileNo = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();


  final FocusNode firstNameNode = FocusNode();
  final FocusNode lastNameNode = FocusNode();
  final FocusNode mobileNoNode = FocusNode();
  final FocusNode emailNode = FocusNode();
  final FocusNode passwordNode = FocusNode();

  ///forgot password page
  final TextEditingController mobileNoForgotPass = TextEditingController();
  final TextEditingController _pinPutController = TextEditingController();

  final FocusNode mobileNoForgotPassNode = FocusNode();
  final FocusNode _pinPutFocusNode = FocusNode();

  ///reset password

  final TextEditingController newPasswordReset = TextEditingController();
  final TextEditingController newPasswordConfirmReset = TextEditingController();

  final FocusNode newPasswordResetNode = FocusNode();
  final FocusNode newPasswordConfirmResetNode = FocusNode();

  ///constant durations
  final Duration _durationContainer = Duration(milliseconds: 500);
  final Duration _durationText = Duration(milliseconds: 250);

  ///overall variables
  Timer _timer = Timer(Duration(milliseconds: 0), ()=>null);
  String pin='';
  int _start = 60;
  String OTPtype = '';
  String target = '';
  String prefix = '+880';

  bool rememberUser = false;
  bool error = false;
  bool completed = false;
  bool loginPage = true;
  bool forgetMe = false;
  bool disableTextField = false;
  bool reset = false;
  bool debugButton = false;

  bool loginPasswordObscure = true;
  bool registerPasswordObscure = true;
  bool resetPasswordObscure = true;
  bool resetPasswordConfirmObscure = true;


  ///animation variables
  double animatedRadius = 10;

  double animatedPosition = Get.height/2.55;
  double animatedWidth = Get.width/2;
  double animatedHeight = Get.width/2.2;


  double imagePosition =  Get.height/2.55 +15;
  double imageWidth = 120;
  double imageHeight = 120;

  double animatedOpacity = 0;

  double textFieldTopGap = Get.height/3.5;
  double textFieldAnimate = - (Get.width + 400);
  double welcomeTextAnimate = -(Get.width + 400);
  double textFieldAnimateLogin = Get.width *2;

  double textFieldAnimateForgot = -(Get.width + 400);

  double textFieldAnimatePin = -(Get.width + 400);

  double textFieldNewPassword = -(Get.width + 400);
  double textFieldNewPasswordConfirm = -(Get.width + 400);

  double buttonOpacity = 0;


  ///widgets
  BoxDecoration get _pinPutDecoration {
    return BoxDecoration(
      color: Colors.white,
      border: Border.all(color: Colors.white),
      borderRadius: BorderRadius.circular(5),
    );
  }

  BoxDecoration get _pinErrorDecoration {
    return BoxDecoration(
      color: Colors.white,
      border: Border.all(color: Colors.red),
      borderRadius: BorderRadius.circular(5),
    );
  }

  ///functions
  void startTimer() {
    _start = 60;
    const oneSec = const Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
          (Timer timer) => setState(
            () {
          if (_start < 1) {
            timer.cancel();
          } else {
            _start = _start - 1;
          }
        },
      ),
    );
  }

  @override
  void initState() {
    if (!mounted) {
      return;
    } else {
      super.initState();

      _pinPutFocusNode.addListener(() {
        if(_pinPutFocusNode.hasFocus){
         if(mounted){
           setState(() {
             //remove error marked field
             error = false;
           });
         }
        }
      });

      Future.delayed(Duration(milliseconds: 100), () {
        if(mounted){
          setState(() {
            //background opacity
            animatedOpacity = 1;
          });
        }
      });

      Future.delayed(Duration(milliseconds: 3000), () {
        if(mounted){
          setState(() {
            //animate image container
            animatedPosition = -Get.height/4;
            animatedRadius = 300;
            animatedWidth = Get.width*1.5;
            animatedHeight = Get.width*1.05;
            //animate image
            imagePosition = Get.height/20;
            imageWidth = 140;
            imageHeight = 140;

            completed = true;//flag for completing animatedOpacity
          });
        }
      });

      Future.delayed(Duration(milliseconds: 3300), () {
        if(mounted){
          setState(() {
            //bring up title, form and button
            welcomeTextAnimate = Get.width/400;
            textFieldAnimateLogin = Get.width/400;
            buttonOpacity = 1;
          });
        }
      });
    }
  }

  @override
  void dispose() {
    mobileNoLogin.dispose();
    mobileNoLoginNode.dispose();
    passwordLogin.dispose();
    passwordLoginNode.dispose();

    firstName.dispose();
    firstNameNode.dispose();
    lastName.dispose();
    lastNameNode.dispose();
    email.dispose();
    emailNode.dispose();
    mobileNo.dispose();
    mobileNoNode.dispose();
    password.dispose();
    passwordNode.dispose();

    _pinPutController.dispose();
    _pinPutFocusNode.dispose();
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardVisibilityBuilder(
      builder: (context, child, isKeyboardVisible) {
        if(completed){
          if(isKeyboardVisible){
            //Keyboard is visible.
            animatedPosition = -(Get.height + 400);
            imagePosition = -(Get.height + 400);
            textFieldTopGap = Get.height/20;
          } else {
            //Keyboard is not visible.
            animatedPosition = -Get.height/4;
            imagePosition = Get.height/20;
            textFieldTopGap = Get.height/3.5;
          }
        }
        return Scaffold(
          backgroundColor: Colors.black,
          body: SingleChildScrollView(
            child: Container(
              height: Get.height,
              child: Stack(
                children: [
//////////--------------------------------------------------------------Background, Title & Logo
                  //BG image
                  Positioned.fill(
                    child:
                    Image.asset('assets/images/background.jpg', fit: BoxFit.fill),
                  ),
                  //BG shade
                  Container(
                    color: completed
                        ? Colors.black.withOpacity(0.8)
                        : Colors.black.withOpacity(0.2),
                  ),
                  //Logo container
                  AnimatedPositioned(
                    top: animatedPosition,
                    left: -100,
                    right: -100,
                    duration: _durationContainer,
                    child: Center(
                      child: AnimatedOpacity(
                        duration: Duration(milliseconds: 1000),
                        opacity: animatedOpacity,
                        child: AnimatedContainer(
                          duration: _durationContainer,
                          width: animatedWidth,
                          height: animatedHeight,
                          padding: EdgeInsets.all(14),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(10.0),
                              topLeft: Radius.circular(10.0),
                              bottomRight: Radius.circular(animatedRadius),
                              bottomLeft: Radius.circular(animatedRadius),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.7),
                                spreadRadius: 2,
                                blurRadius: 3,
                                offset: Offset(0, 0), // changes position of shadow
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  //Logo
                  AnimatedPositioned(
                    top: imagePosition,
                    left: -100,
                    right: -100,
                    duration: _durationContainer - Duration(milliseconds: 100),
                    child: Center(
                      child: AnimatedOpacity(
                        duration: Duration(milliseconds: 1500),
                        opacity: animatedOpacity,
                        child: AnimatedContainer(
                            duration: _durationContainer,
                            width: imageWidth,
                            height: imageHeight,
                            color: Colors.transparent,
                            child: OverflowBox(
                              minWidth: 0.0,
                              minHeight: 0.0,
                              child: Image.asset('assets/images/monke.png', fit: BoxFit.cover),
                            ),
                        ),
                      ),
                    ),
                  ),
                  //Welcome
                  AnimatedPositioned(
                    top: textFieldTopGap,
                    left: welcomeTextAnimate,
                    duration: _durationText,
                    child: AnimatedCrossFade(
                      crossFadeState:  loginPage?CrossFadeState.showFirst:CrossFadeState.showSecond, duration: _durationContainer,
                      firstChild: AnimatedCrossFade(
                        crossFadeState:  forgetMe?CrossFadeState.showFirst:CrossFadeState.showSecond, duration: _durationContainer,
                        firstChild: AnimatedCrossFade(
                          crossFadeState:  reset?CrossFadeState.showFirst:CrossFadeState.showSecond, duration: _durationContainer,
                          firstChild: Container(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Reset Password',
                                  style: TextStyle(color: Colors.white, fontSize: 24),
                                ),
                                Text(
                                  'Enter a new password for your account',
                                  style: TextStyle(color: Colors.grey, fontSize: 12),
                                ),
                              ],
                            ),
                          ),
                          secondChild: Container(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Forgot Password',
                                  style: TextStyle(color: Colors.white, fontSize: 24),
                                ),
                                Text(
                                  'Enter your mobile no. or email to get the password reset code',
                                  style: TextStyle(color: Colors.grey, fontSize: 12),
                                ),
                              ],
                            ),
                          ),
                        ),
                        secondChild: Container(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Text(
                            'Welcome back!',
                            style: TextStyle(color: Colors.white, fontSize: 24),
                          ),
                        ),
                      ),
                      secondChild: Container(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          'Welcome!',
                          style: TextStyle(color: Colors.white, fontSize: 24),
                        ),
                      ),
                    ),
                  ),
//////////--------------------------------------------------------------Login
                  ///Login Mobile
                  AnimatedPositioned(
                    top: textFieldTopGap + 40,
                    left: textFieldAnimateLogin,
                    duration: _durationText + Duration(milliseconds: 50),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      height: 50,
                      width: Get.width,
                      child: CustomTextField(
                        inputFormatter: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        inputType: TextInputType.number,
                        prefixText: '+880',
                        controller: mobileNoLogin,
                        node: mobileNoLoginNode,
                        hintText: 'Enter your mobile number',
                        prefixIcon: CupertinoIcons.phone,
                      ),
                    ),
                  ),
                  ///Login Password
                  AnimatedPositioned(
                    top: textFieldTopGap + 100,
                    left: textFieldAnimateLogin,
                    duration: _durationText + Duration(milliseconds: 100),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      height: 50,
                      width: Get.width,
                      child: CustomTextField(
                        obscure: loginPasswordObscure,
                        controller: passwordLogin,
                        node: passwordLoginNode,
                        hintText: 'Enter your password',
                        prefixIcon: CupertinoIcons.lock,
                        suffixIcon: IconButton(
                          icon: loginPasswordObscure
                              ? Icon(
                            Icons.visibility,
                            color: AppColor.blue,
                          )
                              : Icon(Icons.visibility_off,
                            color: AppColor.blue,),
                          onPressed: () {
                            setState(() {
                              loginPasswordObscure = !loginPasswordObscure;
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                  ///Login ForgetMe
                  AnimatedPositioned(
                    top: textFieldTopGap + 160,
                    left: textFieldAnimateLogin,
                    duration: _durationText + Duration(milliseconds: 100),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      height: 50,
                      width: Get.width,
                      child:  Row(
                        children: [
                          GestureDetector(
                            onTap: (){
                              setState(() {
                                rememberUser = !rememberUser;
                              });
                            },
                            child: Container(
                              color: Colors.transparent,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: Theme(
                                      data: Theme.of(context).copyWith(
                                        unselectedWidgetColor: Colors.white,
                                      ),
                                      child: Checkbox(
                                          onChanged: (value){
                                            setState(() {
                                              rememberUser = value!;
                                            });
                                          },
                                          value: rememberUser,
                                          activeColor:  Colors.orange
                                      ),
                                    ),
                                  ),
                                  SizedBox(width:  20,),
                                  Text(
                                    'Remember me',
                                    style: TextStyle(fontSize:14,
                                        color: rememberUser ?  Colors.orange : Colors.white
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          Spacer(),
                          GestureDetector(
                            onTap: (){
                              setState(() {
                                forgetMe = true;
                                textFieldAnimateForgot = 0;
                                textFieldAnimateLogin = -400;
                              });
                            },
                            child: Text(
                                'Forgot password?',
                                style: TextStyle(fontSize:14,color: Colors.white)
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
//////////--------------------------------------------------------------Register
                  //FirstName
                  AnimatedPositioned(
                    top: textFieldTopGap + 40,
                    left: textFieldAnimate,
                    duration: _durationText + Duration(milliseconds: 50),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      height: 50,
                      width: Get.width,
                      child: CustomTextField(
                        inputFormatter: [
                          FilteringTextInputFormatter.allow(RegExp('[a-zA-Z]')),
                        ],
                        controller: firstName,
                        node: firstNameNode,
                        hintText: 'First Name',
                        prefixIcon: CupertinoIcons.person,
                      ),
                    ),
                  ),
                  //LastName
                  AnimatedPositioned(
                    top: textFieldTopGap + 100,
                    left: textFieldAnimate,
                    duration: _durationText + Duration(milliseconds: 100),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      height: 50,
                      width: Get.width,
                      child: CustomTextField(
                        inputFormatter: [
                          FilteringTextInputFormatter.allow(RegExp('[a-zA-Z]')),
                        ],
                        controller: lastName,
                        node: lastNameNode,
                        hintText: 'Last Name',
                        prefixIcon: CupertinoIcons.person,
                      ),
                    ),
                  ),
                  //Email
                  AnimatedPositioned(
                    top: textFieldTopGap + 160,
                    left: textFieldAnimate,
                    duration: _durationText + Duration(milliseconds: 150),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      height: 50,
                      width: Get.width,
                      child: CustomTextField(
                        controller: email,
                        node: emailNode,
                        hintText: 'Email',
                        prefixIcon: CupertinoIcons.mail,
                      ),
                    ),
                  ),
                  //Mobile
                  AnimatedPositioned(
                    top: textFieldTopGap + 220,
                    left: textFieldAnimate,
                    duration: _durationText + Duration(milliseconds: 200),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      height: 50,
                      width: Get.width,
                      child: CustomTextField(
                        prefixText: prefix,
                        inputFormatter: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        inputType: TextInputType.number,
                        controller: mobileNo,
                        node: mobileNoNode,
                        hintText: 'Mobile No.',
                        prefixIcon: CupertinoIcons.phone,
                      ),
                    ),
                  ),
                  //Password
                  AnimatedPositioned(
                    top: textFieldTopGap + 280,
                    left: textFieldAnimate,
                    duration: _durationText + Duration(milliseconds: 250),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      height: 50,
                      width: Get.width,
                      child: CustomTextField(
                        obscure: registerPasswordObscure,
                        controller: password,
                        node: passwordNode,
                        hintText: 'Password',
                        prefixIcon: CupertinoIcons.lock,
                        suffixIcon: IconButton(
                          icon: registerPasswordObscure
                              ? Icon(
                            Icons.visibility,
                            color: AppColor.blue,
                          )
                              : Icon(Icons.visibility_off,
                            color: AppColor.blue,),
                          onPressed: () {
                            setState(() {
                              registerPasswordObscure = !registerPasswordObscure;
                            });
                          },
                        ),
                      ),
                    ),
                  ),
//////////--------------------------------------------------------------Forgot Password
                  ///ForgotPass Mobile
                  AnimatedPositioned(
                    top: textFieldTopGap + 50,
                    left: textFieldAnimateForgot,
                    duration: _durationText + Duration(milliseconds: 50),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      height: 50,
                      width: Get.width,
                      child: CustomTextField(
                        maxLength: 11,
                        inputType: TextInputType.number,
                        inputFormatter: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        enabled: !disableTextField,
                        controller: mobileNoForgotPass,
                        node: mobileNoForgotPassNode,
                        hintText: 'Enter mobile number',
                        prefixIcon: CupertinoIcons.phone,
                        prefixText: prefix,
                      ),
                    ),
                  ),
                  ///ForgotPass Pin
                  AnimatedPositioned(
                    top: textFieldTopGap + 100,
                    left: textFieldAnimatePin,
                    duration: _durationText + Duration(milliseconds: 50),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      height: 250,
                      width: Get.width,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(vertical:  10),
                            child: Container(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                OTPtype == 'password' ?
                                'Enter 4 digit code to reset your password'
                                    :
                                OTPtype == 'email' ?
                                'Enter 4 digit code sent to your email'
                                    :
                                'Enter 4 digit code sent to your phone number',
                                style: TextStyle(
                                    fontSize:  15,
                                    color: Colors.white
                                ),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: (){
                              setState(() {
                                disableTextField = false;
                                OTPtype = '' ;
                                target = '';
                                textFieldAnimatePin = -400;
                                _pinPutController.clear();
                                _timer.cancel();
                              });
                              if (!mobileNoForgotPassNode.hasFocus){
                                FocusScope.of(context).requestFocus(mobileNoForgotPassNode);
                                mobileNoForgotPassNode.requestFocus();
                              }
                            },
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical:  10),
                              child: Row(
                                children: [
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      '$target',
                                      style: TextStyle(
                                          fontSize:  15,
                                          color: Colors.white
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 10,),
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      'wrong phone number?',
                                      style: TextStyle(
                                          fontSize:  15,
                                          color: Colors.blue
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical:  15),
                            child:  Container(
                              color: Colors.transparent,
                              child: PinPut(
                                key: _formKey,
                                eachFieldWidth: 70,
                                fieldsCount: 4,
                                focusNode: _pinPutFocusNode,
                                controller: _pinPutController,
                                submittedFieldDecoration: error? _pinErrorDecoration:_pinPutDecoration.copyWith(borderRadius: BorderRadius.circular(5)),
                                selectedFieldDecoration: error? _pinErrorDecoration:_pinPutDecoration.copyWith(
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(color: Colors.black.withOpacity(.5),),
                                ),
                                followingFieldDecoration: error? _pinErrorDecoration:_pinPutDecoration.copyWith(
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(color: Colors.grey.withOpacity(.5),),
                                ),
                                textStyle: TextStyle(
                                    fontSize: (15)
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical:  5),
                            child: Container(
                              alignment: Alignment.centerLeft,
                              child: _start != 0? Text(
                                'Resend code in: 00:${_start.toString().padLeft(2, '0')}',
                                style: TextStyle(
                                    fontSize:  15,
                                    color: Colors.white
                                ),
                              ):GestureDetector(
                                onTap: (){
                                  startTimer();
                                },
                                child: Text(
                                  'Resend Code',
                                  style: TextStyle(
                                      fontSize:  15,
                                      color: Colors.blue
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

//////////--------------------------------------------------------------Reset Password
                  ///Reset Password
                  AnimatedPositioned(
                    top: textFieldTopGap + 50,
                    left: textFieldNewPassword,
                    duration: _durationText + Duration(milliseconds: 50),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      height: 50,
                      width: Get.width,
                      child: CustomTextField(
                        obscure: resetPasswordObscure,
                        controller: newPasswordReset,
                        node: newPasswordResetNode,
                        hintText: 'New password',
                        prefixIcon: CupertinoIcons.lock,
                        suffixIcon: IconButton(
                          icon: resetPasswordObscure
                              ? Icon(
                            Icons.visibility,
                            color: AppColor.blue,
                          )
                              : Icon(Icons.visibility_off,
                            color: AppColor.blue,),
                          onPressed: () {
                            setState(() {
                              resetPasswordObscure = !resetPasswordObscure;
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                  ///Reset Confirm Password
                  AnimatedPositioned(
                    top: textFieldTopGap + 110,
                    left: textFieldNewPasswordConfirm,
                    duration: _durationText + Duration(milliseconds: 50),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      height: 50,
                      width: Get.width,
                      child: CustomTextField(
                        obscure: resetPasswordConfirmObscure,
                        controller: newPasswordConfirmReset,
                        node: newPasswordConfirmResetNode,
                        hintText: 'Confirm new password',
                        prefixIcon: CupertinoIcons.lock,
                        suffixIcon: IconButton(
                          icon: resetPasswordConfirmObscure
                              ? Icon(
                            Icons.visibility,
                            color: AppColor.blue,
                          )
                              : Icon(Icons.visibility_off,
                            color: AppColor.blue,),
                          onPressed: () {
                          setState(() {
                            resetPasswordConfirmObscure = !resetPasswordConfirmObscure;
                          });
                          },
                        ),
                      ),
                    ),
                  ),



//////////--------------------------------------------------------------Submit buttons
                  Positioned(
                    bottom: Get.height/15,
                    left: 0,
                    right: 0,
                    child: Column(
                      children: [
                        //button
                        AnimatedCrossFade(
                          crossFadeState: loginPage?CrossFadeState.showFirst:CrossFadeState.showSecond,
                          duration: _durationContainer,
                          ///login/Forget
                          firstChild: AnimatedOpacity(
                            duration: _durationContainer,
                            opacity: buttonOpacity,
                            child: AnimatedCrossFade(
                              crossFadeState: forgetMe?CrossFadeState.showFirst:CrossFadeState.showSecond,
                              duration: _durationContainer,
                              firstChild: AnimatedCrossFade(
                                crossFadeState: !disableTextField?CrossFadeState.showFirst:CrossFadeState.showSecond,
                                duration: _durationContainer,
                                firstChild: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 20),
                                  child: MainButton(
                                    label: 'Send Code',
                                    onPressed: () {
                                      OTPtype = 'phone' ;
                                      target = '+880 ${mobileNoForgotPass.text}';
                                      textFieldAnimatePin = Get.width/400;
                                      disableTextField = true;
                                      FocusScope.of(context).unfocus();
                                      startTimer();
                                    },
                                  ),
                                ),
                                secondChild: AnimatedCrossFade(
                                  crossFadeState: reset?CrossFadeState.showFirst:CrossFadeState.showSecond,
                                  duration: _durationContainer,
                                  firstChild: Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 20),
                                    child: MainButton(
                                      label: 'Reset password',
                                      onPressed: () async{
                                        setState(() {
                                          FocusScope.of(context).unfocus();
                                          forgetMe = false;
                                          reset = false;
                                          disableTextField = false;
                                          textFieldNewPassword = Get.width*2;
                                          textFieldNewPasswordConfirm = Get.width*2;
                                          textFieldAnimateLogin = Get.width/400;
                                          _pinPutController.clear();
                                          newPasswordReset.clear();
                                          newPasswordConfirmReset.clear();
                                        });
                                      },
                                    ),
                                  ),
                                  secondChild: Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 20),
                                    child: MainButton(
                                      label: 'Verify OTP',
                                      onPressed: () async{
                                        FocusScope.of(context).unfocus();
                                        if(_pinPutController.text.length < 4){
                                          setState(() {
                                            error = true;
                                          });
                                          Get.snackbar('Field Error', 'Please input all 4 digits',backgroundColor: Colors.white,colorText: Colors.black,
                                              margin: EdgeInsets.only(bottom: 20,left: 15,right:15),snackPosition: SnackPosition.BOTTOM);
                                        }else{
                                          setState(() {
                                            FocusScope.of(context).unfocus();
                                            reset = true;
                                            textFieldAnimateForgot = Get.width *2;
                                            textFieldAnimatePin = Get.width *2;
                                            textFieldNewPassword =  Get.width/400;
                                            textFieldNewPasswordConfirm =  Get.width/400;
                                            OTPtype = '' ;
                                            target = '';
                                            mobileNoForgotPass.clear();
                                            _timer.cancel();
                                          });
                                        }
                                      },
                                    ),
                                  ),
                                ),
                              ),
                              secondChild: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                child: MainButton(
                                  onPressed: () {},
                                  label: 'Login',
                                ),
                              ),
                            ),
                          ),
                          ///Signup
                          secondChild: AnimatedOpacity(
                            duration: _durationContainer,
                            opacity: buttonOpacity,
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: MainButton(
                                onPressed: () {},
                                label: 'Sign Up',
                              ),
                            ),
                          ),
                        ),

                        AnimatedCrossFade(
                          crossFadeState: forgetMe?CrossFadeState.showFirst:CrossFadeState.showSecond,
                          duration: _durationContainer,
                          ///login/Forget
                          firstChild: SizedBox(),
                          ///SignupWith
                          secondChild:Column(
                            children: [
                              AnimatedOpacity(
                                duration: _durationContainer + Duration(milliseconds: 300),
                                opacity: buttonOpacity,
                                child: AnimatedCrossFade(
                                  firstChild: Padding(
                                    padding: EdgeInsets.symmetric(vertical: 10),
                                    child: Row(
                                      children: [
                                        Flexible(
                                          flex:1,
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(horizontal: 20),
                                            child: Divider(
                                              color: Colors.white,thickness: 1,
                                            ),
                                          ),
                                        ),
                                        Text(
                                          'OR connect with',style: TextStyle(color: Colors.white),
                                        ),
                                        Flexible(
                                          flex: 1,
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(horizontal: 20),
                                            child: Divider(
                                              color: Colors.white,thickness: 1,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  secondChild: SizedBox(),
                                  crossFadeState: loginPage?CrossFadeState.showFirst:CrossFadeState.showSecond, duration: _durationContainer,),
                              ),
                              //social images
                              AnimatedOpacity(
                                duration: _durationContainer + Duration(milliseconds: 300),
                                opacity: buttonOpacity,
                                child: AnimatedCrossFade(
                                    firstChild: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Container(
                                            width: 35,
                                            height: 35,
                                            color: Colors.transparent,
                                            child: OverflowBox(
                                              minWidth: 0.0,
                                              minHeight: 0.0,
                                              child: Image.asset('assets/images/google.png', fit: BoxFit.cover),
                                            )
                                        ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(horizontal: 10),
                                          child: Container(
                                              width: 35,
                                              height: 35,
                                              color: Colors.transparent,
                                              child: OverflowBox(
                                                minWidth: 0.0,
                                                minHeight: 0.0,
                                                child: Image.asset('assets/images/facebook.png',
                                                    fit: BoxFit.cover),
                                              )
                                          ),
                                        ),
                                        Container(
                                            width: 35,
                                            height: 35,
                                            color: Colors.transparent,
                                            child: OverflowBox(
                                              minWidth: 0.0,
                                              minHeight: 0.0,
                                              child: Image.asset('assets/images/twitter.png',
                                                  fit: BoxFit.cover),
                                            )
                                        ),
                                      ],
                                    ),
                                    secondChild:  SizedBox(),
                                    crossFadeState: loginPage?CrossFadeState.showFirst:CrossFadeState.showSecond,
                                    duration: _durationContainer),
                              ),
                              //signup/login
                              AnimatedOpacity(
                                duration: _durationContainer + Duration(milliseconds: 300),
                                opacity: buttonOpacity,
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 20),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      loginPage?SizedBox(height: 10,):Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 10),
                                        child: Column(
                                          children: [
                                            Text('By clicking signup you agree to the', style: TextStyle(color: Colors.white),),
                                            Text('terms and conditions', style: TextStyle(color: Colors.white,decoration: TextDecoration.underline,),)
                                          ],
                                        ),
                                      ),
                                      AnimatedCrossFade(
                                          firstChild:    GestureDetector(
                                            onTap: (){
                                              setState(() {
                                                loginPage = false;
                                                textFieldAnimate =  Get.width/400;
                                                textFieldAnimateLogin = Get.width *2;
                                              });
                                            },
                                            child: RichText(
                                              text: TextSpan(
                                                  children:[
                                                    TextSpan(
                                                      text: 'Do not have account? ',style: TextStyle(color: Colors.white),
                                                    ),
                                                    TextSpan(
                                                      text: 'Signup',style: TextStyle(color: Colors.orange,fontSize: 18,decoration: TextDecoration.underline,),
                                                    ),
                                                  ]
                                              ),),
                                          ),
                                          secondChild:    GestureDetector(
                                            onTap: (){
                                              setState(() {
                                                loginPage = true;
                                                textFieldAnimate = -(Get.width + 400);
                                                textFieldAnimateLogin = Get.width/400;
                                              });
                                            },
                                            child: RichText(
                                              text: TextSpan(
                                                  children:[
                                                    TextSpan(
                                                      text: 'Already have account? ',style: TextStyle(color: Colors.white),
                                                    ),
                                                    TextSpan(
                                                      text: 'Login',style: TextStyle(color: Colors.orange,fontSize: 18,decoration: TextDecoration.underline,),
                                                    ),
                                                  ]
                                              ),),
                                          ),
                                          crossFadeState: loginPage?CrossFadeState.showFirst:CrossFadeState.showSecond,
                                          duration: _durationContainer)
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  //BackButton
                  forgetMe && imagePosition>0?Positioned(top:Get.width/12,left:Get.width/400,child: IconButton(icon: Icon(Icons.arrow_back), onPressed: (){
                    setState(() {
                      FocusScope.of(context).unfocus();
                      forgetMe = false;
                      reset = false;
                      disableTextField = false;
                      textFieldAnimateForgot = -(Get.width + 400);
                      textFieldAnimatePin = -(Get.width + 400);
                      textFieldNewPassword = -(Get.width + 400);
                      textFieldNewPasswordConfirm = -(Get.width + 400);
                      textFieldAnimateLogin = Get.width/400;
                      OTPtype = '' ;
                      target = '';
                      mobileNoForgotPass.clear();
                      _pinPutController.clear();
                      newPasswordReset.clear();
                      newPasswordConfirmReset.clear();
                      _timer.cancel();
                    });
                  })):SizedBox(),
                  //TestWidget to avoid restarting app
                  debugButton?Positioned(
                    bottom: 10,
                    left: 10,
                    child: GestureDetector(
                      onTap: () {
                        Get.offAll(() => Dummy());//destroy current widget
                      },
                      child: Container(
                        color: Colors.purple,
                        width: 50,
                        height: 25,
                        child: Center(child: Text('debug',style: TextStyle(color: Colors.white),)),
                      ),
                    ),
                  ):SizedBox(),
                ],
              ),
            ),
          ),
        );
      }, child: SizedBox(), // this widget goes to the builder's child property.Dummy placeholder for initialization but made for overall better performance.
    );
  }
}

class Dummy extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
      child: TextButton(
        onPressed: () => Get.offAll(() => SplashScreen()),//restart widget
        child: Container(
          color: Colors.purple,
          width: 100,
          height: 100,
          child: Center(child: Text('Back',style: TextStyle(color: Colors.white),)),
        ),
      ),
    ));
  }
}
