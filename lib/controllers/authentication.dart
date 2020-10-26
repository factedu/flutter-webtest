import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

FirebaseAuth auth = FirebaseAuth.instance;
final googleSignIn = GoogleSignIn();

Future<bool> funcGoogleSignIn() async {
  GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
  if (googleSignInAccount != null) {
    GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;
    AuthCredential credential = GoogleAuthProvider.getCredential(
        idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken);

    AuthResult result = await auth.signInWithCredential(credential);
    print(result);

    FirebaseUser user = await auth.currentUser();
    print(user.uid);
    return Future.value(true);
  } else {
    return Future.value(false);
  }
}

Future<bool> signup(String email, String password) async {
  try {
    AuthResult result = await auth.createUserWithEmailAndPassword(
        email: email, password: password);
    FirebaseUser user = result.user;
    print(user);
    return Future.value(true);
  } catch (e) {
    switch (e.code) {
      case 'ERROR_EMAIL_ALREADY_IN_USE':
        print('Error! Email already in use');
        break;
      default:
    }
    return Future.value(false);
  }
}

Future<bool> signin(String email, String password) async {
  print({email, password});
  try {
    AuthResult result =
        await auth.signInWithEmailAndPassword(email: email, password: password);
    FirebaseUser user = result.user;
    print(user);
    return Future.value(true);
  } catch (e) {
    print(e);
    switch (e.code) {
      case 'ERROR_WRONG_PASSWORD':
        print('Error! Invalid password!');
        break;
      default:
    }
    return Future.value(false);
  }
}

Future<bool> signOutUser() async {
  // check if the the user is signed in using Google Signin
  FirebaseUser user = await auth.currentUser();
  if (user.providerData[1].providerId == 'google.com') {
    await googleSignIn.disconnect();
  }

  await auth.signOut();

  return Future.value(true);
}
