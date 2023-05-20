import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:football_ground_management/bloc/load_bloc.dart';
import 'package:football_ground_management/bloc/rent_stadium_bloc.dart';
import 'package:football_ground_management/constant/app_animation.dart';
import 'package:football_ground_management/constant/app_snack_bar.dart';
import 'package:football_ground_management/constant/app_string.dart';
import 'package:football_ground_management/di.dart';
import 'package:football_ground_management/screens/widgets/common/dart_button.dart';
import 'package:lottie/lottie.dart';
import 'package:pinput/pinput.dart';

class VerifyCode extends StatefulWidget {
  final String verificationId;
  const VerifyCode({Key? key, required this.verificationId}) : super(key: key);

  @override
  State<VerifyCode> createState() => _VerifyCodeState();
}

class _VerifyCodeState extends State<VerifyCode> {
  final loadBloc = getIt.get<LoadBloc>();
  final rentStadiumBloc = getIt.get<RentStadiumBloc>();
  String code = '';

  void validateOtp() async {
    try {
      loadBloc.setLoadState(true);
      PhoneAuthCredential creds = PhoneAuthProvider.credential(
        verificationId: widget.verificationId,
        smsCode: code,
      );
      if (code.length != 6) throw 'Vui lòng nhập đâỳ đủ OTP';

      await FirebaseAuth.instance.signInWithCredential(creds);
      await rentStadiumBloc.rentStadium();
      // ignore: use_build_context_synchronously
      Navigator.of(context).popUntil((route) => route.isFirst);
      AppSnackBar.showTopSnackBarSuccess('Đăt sân thành công');
    } on FirebaseAuthException catch (e) {
      AppSnackBar.showTopSnackBarError(e.message.toString());
    } catch (e) {
      AppSnackBar.showTopSnackBarError(e.toString());
    } finally {
      loadBloc.setLoadState(false);
    }
  }

  @override
  void dispose() {
    loadBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: _buildAppBar(context),
      body: Container(
        margin: const EdgeInsets.only(left: 25, right: 25),
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset(AppAnimation.verifyCode, width: 100),
              const Padding(
                padding: EdgeInsets.only(top: 25, bottom: 10),
                child: Text(
                  'Vui vòng nhập mã otp chúng tôi đã gửi về số điện thoại của bạn để xác nhận',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30, bottom: 20),
                child: Pinput(
                  length: 6,
                  showCursor: true,
                  onCompleted: (value) => code = value,
                  onChanged: (value) => code = value,
                ),
              ),
              _buildVerifyButton(),
              _buildEditPhoneButton(context)
            ],
          ),
        ),
      ),
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

  Widget _buildEditPhoneButton(BuildContext context) {
    return TextButton(
      onPressed: () => Navigator.of(context).pop(),
      child: const Text(
        AppString.editPhoneNumber,
        style: TextStyle(color: Colors.black),
      ),
    );
  }

  Widget _buildVerifyButton() {
    return StreamBuilder<bool>(
      stream: loadBloc.loadStream,
      initialData: false,
      builder: (context, snapshot) {
        final loadState = snapshot.data ?? false;

        return SizedBox(
          width: double.infinity,
          height: 45,
          child: DarkButton(
            onPressed: loadState ? null : () => validateOtp(),
            text: AppString.confirm,
          ),
        );
      },
    );
  }
}
