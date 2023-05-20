import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:football_ground_management/bloc/load_bloc.dart';
import 'package:football_ground_management/constant/app_animation.dart';
import 'package:football_ground_management/constant/app_snack_bar.dart';
import 'package:football_ground_management/constant/app_string.dart';
import 'package:football_ground_management/constant/route_manager.dart';
import 'package:football_ground_management/di.dart';
import 'package:football_ground_management/screens/widgets/common/dart_button.dart';
import 'package:lottie/lottie.dart';

class PhoneVetify extends StatefulWidget {
  const PhoneVetify({Key? key}) : super(key: key);

  @override
  State<PhoneVetify> createState() => _PhoneVetifyState();
}

class _PhoneVetifyState extends State<PhoneVetify> {
  TextEditingController countryController = TextEditingController();
  String phone = '';
  final loadBloc = getIt.get<LoadBloc>();
  @override
  void initState() {
    countryController.text = '+84';
    super.initState();
  }

  @override
  void dispose() {
    countryController.dispose();
    loadBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: _buildAppBar(context),
      body: Container(
        margin: const EdgeInsets.only(left: 25, right: 25),
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Lottie.asset(AppAnimation.verifyCode, width: 100),
              const Padding(
                padding: EdgeInsets.only(top: 25, bottom: 10),
                child: Text(
                  AppString.phoneVerification,
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
              ),
              const Text(
                AppString.weNeedValidateYourPhoneNumber,
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30, bottom: 20),
                child: _buildTextField(),
              ),
              _buildSendOtpButton(context)
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField() {
    return Container(
      height: 55,
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          const SizedBox(width: 10),
          SizedBox(
            width: 40,
            child: TextField(
              controller: countryController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(border: InputBorder.none),
            ),
          ),
          const Text('|', style: TextStyle(fontSize: 33, color: Colors.grey)),
          const SizedBox(width: 10),
          Expanded(
            child: TextField(
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: AppString.phoneNumber,
              ),
              onChanged: (value) => phone = value,
            ),
          )
        ],
      ),
    );
  }

  Widget _buildSendOtpButton(BuildContext context) {
    return StreamBuilder<bool>(
      stream: loadBloc.loadStream,
      initialData: false,
      builder: (context, snapshot) {
        final loadState = snapshot.data ?? false;

        return DarkButton(
          onPressed: loadState
              ? null
              : () async {
                  FocusScope.of(context).unfocus();
                  loadBloc.setLoadState(true);
                  await FirebaseAuth.instance.verifyPhoneNumber(
                    phoneNumber: '${countryController.text} $phone',
                    verificationCompleted: (PhoneAuthCredential credential) {
                      loadBloc.setLoadState(false);
                    },
                    verificationFailed: (FirebaseAuthException e) {
                      loadBloc.setLoadState(false);
                      AppSnackBar.showTopSnackBarError(e.message ?? '');
                    },
                    codeSent: (String verificationId, int? resendToken) {
                      loadBloc.setLoadState(false);
                      Navigator.of(context).pushNamed(
                        Routes.vetifyCode,
                        arguments: verificationId,
                      );
                    },
                    codeAutoRetrievalTimeout: (String verificationId) {
                      loadBloc.setLoadState(false);
                    },
                  );
                },
          text: AppString.sendTheCode,
        );
      },
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      leading: IconButton(
        onPressed: () => Navigator.pop(context),
        icon: const Icon(Icons.arrow_back_ios_rounded, color: Colors.black),
      ),
    );
  }
}
