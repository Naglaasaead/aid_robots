import 'package:aid_robot/features/FireBase/firebase_notification.dart';
import 'package:aid_robot/firebase_options.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app/Cubit/cubit_cubit.dart';
import 'app/themes/get_theme.dart';
import 'app/utils/bloc_observer.dart';
import 'app/utils/get_it_injection.dart';
import 'app/utils/language_manager.dart';
import 'app/utils/navigation_helper.dart';
import 'app/widgets/carousel_widget/carousel_cubit/carousel_cubit.dart';
import 'features/auth_feature/presentation/presentation_logic_holder/auth_cubit.dart';
import 'features/auth_feature/presentation/screens/Home.dart';
import 'features/auth_feature/presentation/screens/Video.dart';
import 'features/auth_feature/presentation/screens/allChat.dart';
import 'features/auth_feature/presentation/screens/appointment.dart';
import 'features/auth_feature/presentation/screens/chat1.dart';
import 'features/auth_feature/presentation/screens/chat2.dart';
import 'features/auth_feature/presentation/screens/login_chat.dart';
import 'features/auth_feature/presentation/screens/reg_chat.dart';
import 'features/auth_feature/presentation/screens/splashScreen.dart';
// Import the Agora page

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences pref = await SharedPreferences.getInstance();
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
    name: 'secondaryApp',
  );
  FireBaseNotification firebaseNotification = FireBaseNotification();
  firebaseNotification.getToken();
  Bloc.observer = MyBlocObserver();
  await init();
  DioHelper.init();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<CarouselCubit>(
          create: (BuildContext context) => CarouselCubit(),
        ),
        BlocProvider<AuthCubit>(
          create: (BuildContext context) => AuthCubit(),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  final _auth=FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return EasyLocalization(
      supportedLocales: const [
        english_local,
        arabic_local,
      ],
      saveLocale: true,
      startLocale: english_local,
      path: assets_path_localisations,
      fallbackLocale: english_local,
      child: OverlaySupport.global(
        child: ScreenUtilInit(
          designSize: const Size(375, 812),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (context, child) => MaterialApp(
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
            title: 'Graduation Project',
            theme: graduationProjectTheme(),
            /*  theme: ThemeData(
              primarySwatch: Colors.blue,
              visualDensity: VisualDensity.adaptivePlatformDensity,
            ),*/
            debugShowCheckedModeBanner: false,
            navigatorKey: getIt<NavHelper>().navigatorKey,
            builder: (context, widget) {
              return MediaQuery(
                data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
                child: widget!,
              );
            },
            //home:_auth.currentUser!=null? ChatScreen():WelcomeScreen() ,
            home: SplashScreen(),
            //initialRoute:  WelcomeScreen.ScreenRoute ,
            /* routes: {
              WelcomeScreen.ScreenRoute:(context)=> WelcomeScreen(),
              LoginChat.ScreenRoute:(context)=> LoginChat(),
              Registration.ScreenRoute:(context)=> Registration(),
              ChatScreen.ScreenRoute:(context)=> ChatScreen(),
            },*/// Set AgoraScreen as the initial screen
          ),
        ),
      ),
    );
  }
}
