import 'package:firebase_auth/firebase_auth.dart';
import 'package:map_exam/model/login_model.dart';
import 'package:map_exam/model/login_response.dart';

class FirebaseAuthentication {
  //For this project we will make use of only the sign up with email and
  //password feature.

  //The below method will return a string to either confirm the sign in i.e 'Success'
  //or know an error
  Future<LoginResponse> signInFirebase(LoginModel userLogins) async {
    LoginResponse response = LoginResponse(success: false, message: '');
    try {
      final userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: userLogins.email,
        password: userLogins.password,
      );
      response.success = true;
      response.message = userCredential.user!.uid;
      return response;
    } on FirebaseAuthException catch (e) {
      response.message = e.message!;
      return response;
    } catch (e) {
      response.message = e.toString();
      return response;
    }
  }
}
