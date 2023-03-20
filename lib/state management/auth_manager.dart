//For the sake of this project, this class will handle the single sign in method

import 'package:get/get.dart';
import 'package:map_exam/model/login_model.dart';
import 'package:map_exam/screens/home_screen.dart';
import 'package:map_exam/services/authentication/firebase_auth.dart';

class AuthManager extends GetxController {
  final FirebaseAuthentication _firebaseAuthentication =
      FirebaseAuthentication();

  String loggedInUserId = '';

  //signs user into firebase
  signUserIn(LoginModel userLogins) async {
    final confirmation =
        await _firebaseAuthentication.signInFirebase(userLogins);

    if (confirmation.success) {
      loggedInUserId = confirmation.message;
      print(loggedInUserId);
      Get.offAll(() => const HomeScreen());
    } else {}
  }
}
