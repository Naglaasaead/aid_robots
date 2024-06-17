import 'package:aid_robot/features/auth_feature/data/models/user_model.dart';
import 'package:aid_robot/features/auth_feature/domain/usercases/register_user_case.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../app/utils/get_it_injection.dart';
import '../../../../app/utils/hanlders/error_state_handler.dart';
import '../../../../app/utils/helper.dart';
import '../../../../app/utils/navigation_helper.dart';
import '../screens/home_patient.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());
  static AuthCubit get() => BlocProvider.of(getIt<NavHelper>().navigatorKey.currentState!.context);


  final loginPasswordController = TextEditingController();
  final loginEmailController = TextEditingController();


  final signUpFullNameController = TextEditingController();
  final signUpPhoneController = TextEditingController();
  final signUpPasswordController = TextEditingController();
  final signUpEmailController = TextEditingController();
  String ? city;
  String ? government;
UserModel ? userModel;
  void reg() async {
    emit(LoadingState());
    final response = await getIt<RegisterUseCase>()(RegisterUseCaseParams(
        email:"mody4404@gmail.com",
        password: "mody12",
        phone: '01016738856',
        name: 'Mody',
    ));
    response.fold(
      errorStateHandler,
          (r) {
        userModel = r;
        print(r.token??"token");
        navigateTo( HomePatient(), removeAll: true);
        loginPasswordController.clear();
        loginPasswordController.clear();
      },
    );
    emit(AuthInitial());
  }

  // void login()async{
  //   emit(LoadingState());
  //   auth.signInWithEmailAndPassword(
  //     email:loginEmailController.text ,
  //     password: loginPasswordController.text,
  //   ).then((value) async{
  //     showToast(msg: "You logged as ${value.user?.displayName??""} ",
  //         backgroundColor: AppColors.mainColor, textColor: Colors.white).then((value){
  //       navigateTo(const BNBScreen(),removeAll: true);
  //     });
  //   });
  //   emit(AuthInitial());
  // }
  //
  //
  // void register()async{
  //   emit(LoadingState());
  //   await auth.createUserWithEmailAndPassword(
  //     email:signUpEmailController.text ,
  //     password: signUpPasswordController.text,
  //   ).then((value){
  //     showToast(msg: "You logged as ${value.user?.email}",
  //         backgroundColor: AppColors.mainColor, textColor: Colors.white).then((value)async{
  //       await firebaseFirestore.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).set(
  //           {
  //             "name":signUpFullNameController.text,
  //             "password":signUpPasswordController.text,
  //             "email":signUpEmailController.text,
  //             "phone":signUpPhoneController.text,
  //             "id":FirebaseAuth.instance.currentUser!.uid,
  //             "government":government,
  //             "city":city,
  //             'creationTime': DateFormat("dd/MM/yyyy").format(DateTime.now()),
  //             'lastMessage': "",
  //           });
  //       navigateTo(const BNBScreen(),removeAll: true);
  //     });
  //   });
  //   emit(AuthInitial());
  // }

}
