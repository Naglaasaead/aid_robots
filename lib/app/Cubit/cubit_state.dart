part of 'cubit_cubit.dart';

abstract class LoginStates {}

class InitialState extends LoginStates {}
class LoadingState extends LoginStates {}
class SuccessState extends LoginStates {}
class ErrorState extends LoginStates {
  final String error;
  ErrorState(this.error);
}





abstract class RegisterStae {}

class InitialStateRegister extends RegisterStae {}
class LoadingStateRegister extends RegisterStae {}
class SuccessStateRegister extends RegisterStae {}
class ErrorStateRegister extends RegisterStae {
  final String error;
  ErrorStateRegister(this.error);

}

