import 'package:amazon_cognito_identity_dart_2/cognito.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class AWSServices {
  final logger = Logger();
  final userPool = CognitoUserPool(
    'eu-north-1_eV5P6WisA',
    '2po3cl8esqqo8veog3tmd0hoen',
  );

  Future<bool> createInitialRecord(email, password) async {
    debugPrint('Authenticating User...');
    final cognitoUser = CognitoUser(email, userPool);
    final authDetails = AuthenticationDetails(
      username: email,
      password: password,
    );
    CognitoUserSession? session;
    try {
      session = await cognitoUser.authenticateUser(authDetails);
      print('Access token written to access_token.txt');
      int halfLength = 500;
      print(session?.accessToken.jwtToken.toString().substring(0,halfLength));
      print(session?.accessToken.jwtToken.toString().substring(halfLength));
      cognitoUser.cacheTokens();

      debugPrint('Login Success...');
      return true;
    } on CognitoUserNewPasswordRequiredException catch (e) {
      debugPrint('CognitoUserNewPasswordRequiredException $e');
    } on CognitoUserMfaRequiredException catch (e) {
      debugPrint('CognitoUserMfaRequiredException $e');
    } on CognitoUserSelectMfaTypeException catch (e) {
      debugPrint('CognitoUserMfaRequiredException $e');
    } on CognitoUserMfaSetupException catch (e) {
      debugPrint('CognitoUserMfaSetupException $e');
    } on CognitoUserTotpRequiredException catch (e) {
      debugPrint('CognitoUserTotpRequiredException $e');
    } on CognitoUserCustomChallengeException catch (e) {
      debugPrint('CognitoUserCustomChallengeException $e');
    } on CognitoUserConfirmationNecessaryException catch (e) {
      debugPrint('CognitoUserConfirmationNecessaryException $e');
    } on CognitoClientException catch (e) {
      debugPrint('CognitoClientException $e');
    } catch (e) {
      print(e);

    }
    return false;
  }
  var data;
  Future userSignUp(email, password) async{

    try {
      data = await userPool.signUp(
        email,
        password,
      );
    } catch (e) {
      print(e);
    }
  }

  Future sendOTP(email) async{
    String status;
    try {
       await CognitoUser(email, userPool).resendConfirmationCode();
    } catch (e) {
      print(e);
    }

  }

  Future<bool> verifyOTP(email,verifyCode) async{

    bool registrationConfirmed = false;
    try {
      registrationConfirmed = await  CognitoUser(email, userPool).confirmRegistration(verifyCode);
      return true;
    } catch (e) {
      print(e);
    }
    return false;
  }

  Future<bool> deleteUser(email,password) async{

    try {
      final authDetails = AuthenticationDetails(
        username: email,
        password: password,
      );
      final cognitoUser = CognitoUser(email, userPool);
      CognitoUserSession? session;
      session = await cognitoUser.authenticateUser(authDetails);
      cognitoUser.deleteUser();
      return true;
    } catch (e) {
      print(e);
    }
    return false;
  }

}