/*
import 'package:aid_robot/app/widgets/text_widget.dart';
import 'package:aid_robot/features/auth_feature/presentation/screens/sign_up.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../app/widgets/custom_button.dart';
import '../../../../app/widgets/custom_text_feildEmail.dart';
import '../../../../app/widgets/custom_text_feildPhone.dart';
import '../../../../app/widgets/custom_text_feildpassword.dart';
import 'forget_password.dart';
import 'home_patient.dart';

class LoginScreens extends StatefulWidget {
  const LoginScreens({Key? key});

  @override
  State<LoginScreens> createState() => _LoginScreensState();
}

class _LoginScreensState extends State<LoginScreens> {
  var titelControler = TextEditingController();
  var timeControler = TextEditingController();
  var dateControler = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final RegExp phoneRegex = RegExp(r'^[0-9]+$');
  final TextEditingController phoneController = TextEditingController();
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
              top: 100, left: 20, right: 20, bottom: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset("assets/images/login_in.png"),
              SizedBox(height: 30,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextWidget(
                    title: "Log In",
                    titleColor: Colors.black,
                    titleFontWeight: FontWeight.bold,
                    titleSize: 25,
                  ),
                  Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SizedBox(height: 20),

                        // Email
                        CustomTextField(
                          text: 'Email',
                          prefixIcon: Icon(Icons.person),
                          keyboardType: TextInputType.emailAddress,
                          obscureText: false,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter an email';
                            }

                            return null;
                          },
                          inputFormatters: [],
                        ),

                        SizedBox(height: 30),

                        // Password
                    CustomTextField(
                      text: 'Password',
                      obscureText: _obscureText,
                      prefixIcon: Icon(Icons.lock),
                      suffixIcon: IconButton(
                        icon: Icon(_obscureText ? Icons.visibility : Icons.visibility_off),
                        onPressed: () {
                          setState(() {
                            _obscureText = !_obscureText;
                          });
                        },
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a Password';
                        }
                        if (value.length < 8) {
                          return 'Password must be at least 8 characters long';
                        }
                        if (!RegExp(
                            r'^(?=.*?[a-zA-Z])(?=.*?[0-9])(?=.*?[!@#\$%^&*()_+{}|:<>?/~`\\-=[\]\\;\',./"])' +
                        r'[a-zA-Z0-9!@#\$%^&*()_+{}|:<>?/~`\\-=[\]\\;\',./"]{8,}$',
                        ),
                            .hasMatch(value)) {
                          return 'Password must contain at least one letter, one number, and one special character';
                        }
                        return null;
                      },
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                          RegExp(
                              r'[a-zA-Z0-9!@#\$%^&*()_+{}|:<>?/~`\-=[\]\\;\',./"]',
                          ),
                        ),
                      ],
                    ),



                        SizedBox(height: 10,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            InkWell(
                              child: TextWidget(
                                title: "Forget Password?",
                                titleColor: Colors.blueAccent,
                              ),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ForgetPassword(),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        CustomButton(
                          text: "Login",
                          color: Colors.blue,
                          onPressed: (context) {
                            // Execute validation logic here
                            if (Form.of(context)!.validate()) {
                              // If validation passes, navigate to the next screen
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => HomePatient(),
                                ),
                              );
                            }
                          },
                        ),
                        SizedBox(height: 30,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 140,
                              height: 1,
                              color: Colors.black,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text('OR',style: TextStyle(fontSize: 18),),
                            ),
                            Container(
                              width: 140,
                              height: 1,
                              color: Colors.black,
                            ),
                          ],
                        ),
                        SizedBox(height: 10,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextWidget(title: "Don’t have an account? "),
                            InkWell(
                              child: TextWidget(
                                title: "Sign Up",
                                titleColor: Colors.blueAccent,
                              ),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => SignUpScreen(),
                                  ),
                                );
                              },
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
*/

/*
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:aid_robot/app/widgets/text_widget.dart';
import 'package:aid_robot/features/auth_feature/presentation/screens/sign_up.dart';
import 'package:aid_robot/features/auth_feature/presentation/screens/forget_password.dart';
import 'package:aid_robot/features/auth_feature/presentation/screens/home_patient.dart';
import '../../../../app/widgets/custom_button.dart';
import '../../../../app/widgets/custom_text_feildEmail.dart';
import '../../../../app/widgets/custom_text_feildPhone.dart';
import '../../../../app/widgets/custom_text_feildpassword.dart';

class LoginScreens extends StatefulWidget {
  const LoginScreens({Key? key});

  @override
  State<LoginScreens> createState() => _LoginScreensState();
}

class _LoginScreensState extends State<LoginScreens> {
  var titelControler = TextEditingController();
  var timeControler = TextEditingController();
  var dateControler = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final RegExp phoneRegex = RegExp(r'^[0-9]+$');
  final TextEditingController phoneController = TextEditingController();
  bool _obscureText = true;
  late RegExp passwordRegExp;

  @override
  void initState() {
    super.initState();
    passwordRegExp = RegExp(
      r'^(?=.*[a-zA-Z])(?=.*\d)(?=.*[@!%*?&])[\w@!%*?&]{8,}$',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
              top: 100, left: 20, right: 20, bottom: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset("assets/images/login_in.png"),
              SizedBox(height: 30,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextWidget(
                    title: "Log In",
                    titleColor: Colors.black,
                    titleFontWeight: FontWeight.bold,
                    titleSize: 25,
                  ),
                  Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SizedBox(height: 20),

                        // Email
                        CustomTextField(
                          onChanged: (value) {

                          },
                          text: 'Email',
                          prefixIcon: Icon(Icons.person),
                          keyboardType: TextInputType.emailAddress,
                          obscureText: false,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter an email';
                            }

                            return null;
                          },
                          inputFormatters: [],
                        ),

                        SizedBox(height: 30),

                        // Password
                        CustomTextField(
                          onChanged: (value) {


                          },
                          text: 'Password',
                          obscureText: _obscureText,
                          prefixIcon: Icon(Icons.lock),
                          suffixIcon: IconButton(
                            icon: Icon(_obscureText ? Icons.visibility : Icons.visibility_off),
                            onPressed: () {
                              setState(() {
                                _obscureText = !_obscureText;
                              });
                            },
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a Password';
                            }
                            if (value.length < 8) {
                              return 'Password must be at least 8 characters long';
                            }
                            if (!passwordRegExp.hasMatch(value)) {
                              return 'Password must contain at least letter,number,special character';
                            }
                            return null;
                          },
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                              RegExp(r'^(?=.*[a-zA-Z])(?=.*\d)(?=.*[@!%*?&])[\w@!%*?&]{8,}$')
                              ),
                          ],
                        ),

                        SizedBox(height: 10,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            InkWell(
                              child: TextWidget(
                                title: "Forget Password?",
                                titleColor: Colors.blueAccent,
                              ),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ForgetPassword(),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        CustomButton(
                          text: "Login",
                          color: Colors.blue,
                          onPressed: (context) {
                            // Execute validation logic here
                            if (Form.of(context)!.validate()) {
                              // If validation passes, navigate to the next screen
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => HomePatient(),
                                ),
                              );
                            }
                          },
                        ),
                        SizedBox(height: 30,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 140,
                              height: 1,
                              color: Colors.black,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text('OR',style: TextStyle(fontSize: 18),),
                            ),
                            Container(
                              width: 140,
                              height: 1,
                              color: Colors.black,
                            ),
                          ],
                        ),
                        SizedBox(height: 10,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextWidget(title: "Don’t have an account? "),
                            InkWell(
                              child: TextWidget(
                                title: "Sign Up",
                                titleColor: Colors.blueAccent,
                              ),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => SignUpScreen(),
                                  ),
                                );
                              },
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
*/



/*


import 'dart:convert';

import 'package:aid_robot/features/auth_feature/presentation/screens/sign_up.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../app/Cubit/cubit_cubit.dart';
import '../../../../app/utils/consts.dart';
import '../../../../app/widgets/custom_button.dart';
import '../../../../app/widgets/custom_text_feildEmail.dart';
import '../../../../app/widgets/text_widget.dart';
import '../../domain/usercases/register_user_case.dart';
import 'forget_password.dart';
import 'home_patient.dart';
import 'package:http/http.dart' as http;
class LoginScreens extends StatefulWidget {
  const LoginScreens({Key? key});

  @override
  State<LoginScreens> createState() => _LoginScreensState();
}
class _LoginScreensState extends State<LoginScreens> {
var titelControler = TextEditingController();
var timeControler = TextEditingController();
var dateControler = TextEditingController();
bool _obscureText = true;
final GlobalKey<FormState> formKey = GlobalKey<FormState>();
final RegExp phoneRegex = RegExp(r'^[0-9]+$');
final TextEditingController phoneController = TextEditingController();
late RegExp passwordRegExp;
late TextEditingController emailController; // تم إضافة تعريف للمتغير
late TextEditingController passwordController;
bool _isNotvalidate=false;
late SharedPreferences pref;
// تم إضافة تعريف للمتغير
void loginUser() async{

  if(emailController.text.isNotEmpty && passwordController.text.isNotEmpty){
    var reqBody={

      "email":emailController.text,
      "password":passwordController.text,
    };

    var response = await http.post(Uri.parse(login),
        body:jsonEncode(reqBody));
    // var jasonResponse=response.body;

    var decodedResponse = jsonDecode(response.body);
    var status = decodedResponse['status'];
    if (status is bool && status) {
      // If status is true, navigate to LoginScreens
      var myToken = decodedResponse['token'];
      pref.setString('token', myToken);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => HomePatient(),
        ),
      );
    }
    //print(jasonResponse['status']);
    */
/*  if(jasonResponse['status']){
         Navigator.push(
           context,
           MaterialPageRoute(
             builder: (context) => LoginScreens(),
           ),
         );
       }*//*

    else{
      print("Somthing went wrong ");
    }

  }
  else{
    setState(() {
      _isNotvalidate=true;
    });
  }
}
@override
void initState() {
  super.initState();
  initSharedPref();
  passwordRegExp = RegExp(
    r'^(?=.*[a-zA-Z])(?=.*\d)(?=.*[@!%*?&])[\w@!%*?&]{8,}$',
  );

  emailController = TextEditingController(); // تهيئة المتغير
  passwordController = TextEditingController(); // تهيئة المتغير
}
void initSharedPref () async{
  pref = await SharedPreferences.getInstance();
}

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
  create: (context) => LoginCubit(),

  child: BlocConsumer<LoginCubit,LoginStates>(

    listener: (BuildContext context, LoginStates state) {  },
    builder: (BuildContext context, LoginStates state) {  
      return    Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(
                top: 100, left: 20, right: 20, bottom: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset("assets/images/login_in.png"),
                SizedBox(height: 30,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextWidget(
                      title: "Log In",
                      titleColor: Colors.black,
                      titleFontWeight: FontWeight.bold,
                      titleSize: 25,
                    ),
                    Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          SizedBox(height: 20),
                          CustomTextField(
                            onChanged: (value) {
                              // Update email value
                              emailController.text = value;
                            },
                            text: 'Email',
                            prefixIcon: Icon(Icons.email_outlined),
                            keyboardType: TextInputType.emailAddress,
                            obscureText: false,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter an email';
                              }
                              return null;
                            },
                            inputFormatters: [],
                          ),
                          SizedBox(height: 30),
                          CustomTextField(
                            onChanged: (value) {
                              // Update password value
                              passwordController.text = value;
                            },
                            text: 'Password',
                            obscureText: _obscureText,
                            prefixIcon: Icon(Icons.lock),
                            suffixIcon: IconButton(
                              icon: Icon(_obscureText ? Icons.visibility : Icons.visibility_off),
                              onPressed: () {
                                setState(() {
                                  _obscureText = !_obscureText;
                                });
                              },
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter a Password';
                              }
                              if (value.length < 8) {
                                return 'Password must be at least 8 characters long';
                              }
                              if (!passwordRegExp.hasMatch(value)) {
                                return 'Password must contain at least letter,number,special character';
                              }
                              return null;
                            },
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'^(?=.*[a-zA-Z])(?=.*\d)(?=.*[@!%*?&])[\w@!%*?&]{8,}$')
                              ),
                            ],
                          ),
                          SizedBox(height: 10,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              InkWell(
                                child: TextWidget(
                                  title: "Forget Password?",
                                  titleColor: Colors.blueAccent,
                                ),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ForgetPassword(),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          ConditionalBuilder(
                            condition: state is! LoadingState,
                            builder: (context) => CustomButton(
                              text: "Login",
                              color: Colors.blue,
                              onPressed: (p0) {
                                if (formKey.currentState!.validate()) {
                                  // If validation passes, call loginUser function with email and password
                                  //loginUser(emailController.text, passwordController.text);
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => HomePatient(),
                                    ),
                                  );
                                }
                              },
                            ),
                            fallback:(context) =>  Center(child: CircularProgressIndicator()),
                          ),


                          SizedBox(height: 30,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 140,
                                height: 1,
                                color: Colors.black,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Text('OR',style: TextStyle(fontSize: 18),),
                              ),
                              Container(
                                width: 140,
                                height: 1,
                                color: Colors.black,
                              ),
                            ],
                          ),
                          SizedBox(height: 10,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TextWidget(title: "Don’t have an account? "),
                              InkWell(
                                child: TextWidget(
                                  title: "Sign Up",
                                  titleColor: Colors.blueAccent,
                                ),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => SignUpScreen(),
                                    ),
                                  );
                                },
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      );
    },
    
  ),
);
  }
}
*/
















import 'package:aid_robot/features/auth_feature/presentation/screens/sign_up.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../../app/Cubit/cubit_cubit.dart';
import '../../../../app/widgets/custom_button.dart';
import '../../../../app/widgets/custom_text_feildEmail.dart';
import '../../../../app/widgets/text_widget.dart';
import 'forget_password.dart';
import 'home_patient.dart';






class LoginScreens extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreens> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) {
          if (state is SuccessState) {
            print("Login Successful!");
            Fluttertoast.showToast(
              msg: "تم التسجيل بنجاح",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.blue,
              textColor: Colors.white,
              fontSize: 16.0,
            );
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomePatient()),
            );
          } else if (state is ErrorState) {
            print("Login Failed: ${state.error}");
            Fluttertoast.showToast(
              msg: "حدث خطأ أثناء التسجيل",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0,
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(top: 100, left: 20, right: 20, bottom: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset("assets/images/login_in.png"),
                    SizedBox(height: 30),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextWidget(
                          title: "Log In",
                          titleColor: Colors.black,
                          titleFontWeight: FontWeight.bold,
                          titleSize: 25,
                        ),
                        Form(
                          key: formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              SizedBox(height: 20),
                              CustomTextField(
                                onChanged: (value) {
                                //  emailController.text = value;
                                },
                                controller: emailController,
                                text: 'Email',
                                prefixIcon: Icon(Icons.email_outlined),
                                keyboardType: TextInputType.emailAddress,
                                obscureText: false,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter an email';
                                  }
                                  return null;
                                },
                                inputFormatters: [],
                              ),
                              SizedBox(height: 30),
                              CustomTextField(
                                onChanged: (value) {
                               //   passwordController.text = value;

                                },
                                text: 'Password',
                                 controller: passwordController,
                                obscureText: _obscureText,
                                prefixIcon: Icon(Icons.lock),
                                suffixIcon: IconButton(
                                  icon: Icon(_obscureText ? Icons.visibility : Icons.visibility_off),
                                  onPressed: () {
                                    setState(() {
                                      _obscureText = !_obscureText;
                                    });
                                  },
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter a Password';
                                  }
                                  if (value.length < 8) {
                                    return 'Password must be at least 8 characters long';
                                  }
                                  return null;
                                },
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                    RegExp(r'^(?=.*[a-zA-Z])(?=.*\d)(?=.*[@!%*?&])[\w@!%*?&]{8,}$'),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  InkWell(
                                    child: TextWidget(
                                      title: "Forget Password?",
                                      titleColor: Colors.blueAccent,
                                    ),
                                    onTap: () {

                                        Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => ForgetPassword()),
                                      );

                                    },
                                  ),
                                ],
                              ),
                              SizedBox(height: 10),
                              if (state is LoadingState)
                                const Center(child: CircularProgressIndicator())

                              else
                                CustomButton(
                                  text: "Login",
                                  color: Colors.blue,
                                  onPressed: (v) {
                                    if (formKey.currentState!.validate()) {
                                      LoginCubit.get(context).userLogin(
                                        email: emailController.text,
                                        password: passwordController.text,
                                      );

                                    }

                                  },
                                ),
                              SizedBox(height: 30),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(width: 140, height: 1, color: Colors.black),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                    child: Text('OR', style: TextStyle(fontSize: 18)),
                                  ),
                                  Container(width: 140, height: 1, color: Colors.black),
                                ],
                              ),
                              SizedBox(height: 10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  TextWidget(title: "Don’t have an account? "),
                                  InkWell(
                                    child: TextWidget(
                                      title: "Sign Up",
                                      titleColor: Colors.blueAccent,
                                    ),
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => SignUpScreen()),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}



