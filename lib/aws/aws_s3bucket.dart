
import 'package:amplify_flutter/amplify_flutter.dart';

Future<void> signIn() async {
  try {
     await Amplify.Auth.signIn(
      username: 'your_username',
      password: 'your_password',
    );
    print('Sign in result:');
  } catch (e) {
    print('Error signing in: $e');
  }
}
