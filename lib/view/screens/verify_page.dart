import 'package:flutter/material.dart';
import 'package:flutter_timer_countdown/flutter_timer_countdown.dart';

import '../../aws/aws_cognito.dart';
import '../../core/viewmodels/user_location.dart';
import '../shared/global.dart';
import '../widgets/otp_form_widget.dart';
import 'building_search_screen.dart';


class VerifyScreen extends StatefulWidget {
  const VerifyScreen({super.key, required this.controller});
  final PageController controller;
  @override
  State<VerifyScreen> createState() => _VerifyScreenState();
}

class _VerifyScreenState extends State<VerifyScreen> {
  String? varifyCode;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Global.backgroundBlack,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          const SizedBox(
            height: 250,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50),
            child: Column(
              textDirection: TextDirection.ltr,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Confirm the code\n',
                  style: TextStyle(
                    color: Global.fontBlack,
                    fontSize: 25,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Container(
                  width: 329,
                  height: 56,
                  decoration: BoxDecoration(
                    border:
                    Border.all(width: 1, color: Global.fontBlack),
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 60),
                    child: OtpForm(
                      callBack: (code) {
                        varifyCode = code;
                      },
                    ),
                  ),
                ),
                const SizedBox(
                  height: 32,
                ),
                ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  child: SizedBox(
                    width: 329,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: () async {
                        if(await AWSServices().verifyOTP(MailAddress().email,varifyCode)){
                          showSearch(
                            context: context,
                            delegate: BuildingSearchDelegate(), // Your custom delegate
                          );
                        }else{
                          showErrorDialog(context, 'Incorrect OTP');
                          await AWSServices().deleteUser(MailAddress().email,Password().password);
                          widget.controller.animateToPage(0,
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.ease);
                        }
                        print(varifyCode);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor:  Global.searchBarBlack,
                      ),
                      child: const Text(
                        'confirm',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Resend  ',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Global.fontBlack,
                        fontSize: 13,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    TimerCountdown(
                      spacerWidth: 0,
                      enableDescriptions: false,
                      colonsTextStyle: const TextStyle(
                        color: Global.fontBlack,
                        fontSize: 13,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400,
                      ),
                      timeTextStyle: const TextStyle(
                        color: Global.fontBlack,
                        fontSize: 13,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400,
                      ),
                      format: CountDownTimerFormat.minutesSeconds,
                      endTime: DateTime.now().add(
                        const Duration(
                          minutes: 2,
                          seconds: 0,
                        ),
                      ),
                      onEnd: () {},
                    ),
                  ],
                ),
                const SizedBox(
                  height: 37,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: InkWell(
              onTap: () {
                widget.controller.animateToPage(1,
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.ease);
              },
              child: const Text(
                'A 6-digit verification code has been sent to info@aidendesign.com',
                style: TextStyle(
                  color: Global.fontBlack,
                  fontSize: 11,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}


void showErrorDialog(BuildContext context, String errorMessage) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text('Error'),
        content: Text(errorMessage),
        actions: <Widget>[
          TextButton(
            child: Text('OK'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}