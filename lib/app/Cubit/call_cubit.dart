import 'package:flutter_bloc/flutter_bloc.dart';

import 'call_state.dart';

class HomeCallIDCubit extends Cubit<HomeCallIDState> {
  HomeCallIDCubit() : super(HomeCallIDInitialState());

  void joinCall(String userName, String callID) {
    final RegExp callIDRegExp = RegExp(r'^[a-zA-Z0-9]{8}$');

    if (callID.isEmpty) {
      emit(HomeCallIDErrorState('Please enter a call ID'));
    } else if (!callIDRegExp.hasMatch(callID)) {
      emit(HomeCallIDErrorState('Invalid call ID format'));
    } else if (userName.isEmpty) {
      emit(HomeCallIDErrorState('Please enter your name'));
    } else {
      emit(HomeCallIDInitialState());
      emit(HomeCallIDSuccessState(userName: userName,callId: callID));
    }
  }
}