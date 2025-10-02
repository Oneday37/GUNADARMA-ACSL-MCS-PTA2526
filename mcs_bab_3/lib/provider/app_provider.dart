import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class AppProvider extends ChangeNotifier {
  // INISIALISASI VARIABEL
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passController = TextEditingController();
  final firebaseAuthentication = FirebaseAuth.instance;
  bool visibilityIcon = true;
  final String hintUsernameText = "Enter your mail";
  final String hintPassText = "Password";
  final String loginButtonText = "Login";
  final Color? backgroundColor = Colors.white;
  final Color? iconColor = Colors.grey[400];

  final titleFontstyle = GoogleFonts.robotoCondensed(
    fontSize: 17,
    color: Colors.black,
  );
  final hintTextFontStyle = GoogleFonts.oswald(
    fontSize: 14,
    color: Colors.grey[400],
  );
  final buttonFontStyle = GoogleFonts.oswald(
    fontSize: 14,
    color: Colors.white,
    fontWeight: FontWeight.bold,
  );
  final universalFontStyle = GoogleFonts.oswald(
    fontSize: 14,
    color: Colors.black,
  );

  // METHOD LOGIN FIREBASE
  Future loginToApp(
    String username, String password
  ) async {
    try {
      UserCredential userCredential = await firebaseAuthentication
          .signInWithEmailAndPassword(
            email: usernameController,
            password: passwordController,
          );
      return userCredential;
    } catch (e) {
      throw Exception(e);
    }
  }

  // METHOD LOGOUT FIREBASE
  Future logoutAccount() async {
    await firebaseAuthentication.signOut();
  }

  // METHOD VALIDASI FORM
  Future validationForm(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      notifyListeners();
      try {
        await loginToApp(usernameController.text, passController.text);
      } catch (e) {
        showDialog(
          context: context,
          builder: (builder) {
            return AlertDialog(
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Login Failed"),
                  SizedBox(width: 10),
                  LottieBuilder.asset(
                    height: MediaQuery.of(context).size.width / 6,
                    width: MediaQuery.of(context).size.width / 6,
                    "assets/lottie_failed_animation.json",
                    repeat: true,
                  ),
                ],
              ),
              content: Text(
                "Silahkan Masukkan Username dan Password yang Benar",
                textAlign: TextAlign.center,
              ),
            );
          },
        );
      }
    }
  }

  // METHOD RESET FIELD FORM
  void resetForm() {
    usernameController.clear();
    passController.clear();
    formKey.currentState!.reset();
    notifyListeners();
  }
}
