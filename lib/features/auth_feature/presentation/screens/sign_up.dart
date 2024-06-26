/*
import 'package:aid_robot/features/auth_feature/presentation/presentation_logic_holder/auth_cubit.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../app/widgets/custom_button.dart';
import '../../../../app/widgets/custom_text_feildEmail.dart';
import '../../../../app/widgets/text_widget.dart';
import 'otp.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  var titelControler=TextEditingController();
  var timeControler=TextEditingController();
  var dateControler=TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final RegExp phoneRegex = RegExp(r'^[0-9]+$');
  late RegExp passwordRegExp;
  bool _obscureText = true;
  final TextEditingController phoneController = TextEditingController();
  @override
  void initState() {
    super.initState();
    passwordRegExp = RegExp(
      r'^(?=.*[a-zA-Z])(?=.*\d)(?=.*[@!%*?&])[\w@!%*?&]{8,}$',
    );
  }
  Widget build(BuildContext context) {
    return Scaffold(
   body: BlocBuilder<AuthCubit, AuthState>(
  builder: (context, state) {
    var cubit = AuthCubit.get();
    return SingleChildScrollView(
     child: Padding(
       padding: const EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 20),
       child: Column(
         crossAxisAlignment: CrossAxisAlignment.center,
         children: [
           Image.asset("assets/images/sign_up.png"),
           SizedBox(height: 7,),
           Column(
             crossAxisAlignment: CrossAxisAlignment.start,

             children: [
               TextWidget(title: "Sign Up",titleColor: Colors.black,titleFontWeight: FontWeight.bold,titleSize: 25,),
               Form(
                 key: formKey,
                 child: Column(
                   crossAxisAlignment: CrossAxisAlignment.stretch,
                   children: [
                     SizedBox(height: 7),
                     CustomTextField(
                       text: 'Name',
                       obscureText: false,

                       keyboardType: TextInputType.name,


                       validator: (value) {
                         if (value == null || value.isEmpty) {
                           return 'Please enter an name';
                         }

                         return null;
                       }, inputFormatters: [],
                     ),
                     SizedBox(height: 7),
                     CustomTextField(
                       obscureText: false,
                       text: 'Email',
                       keyboardType: TextInputType.emailAddress,

                       inputFormatters: [
                         FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9@.]+'))
                       ],
                       validator: (value) {
                         if (value == null || value.isEmpty) {
                           return 'Please enter an email';
                         }

                         return null;
                       },
                     ),

                     SizedBox(height: 7),

                   //Password,
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
                     SizedBox(height: 7),
                    //Confirm Password
                     CustomTextField(
                       text: 'Confirm Password',
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
                     SizedBox(height: 7,),
                     Row(
                       mainAxisAlignment: MainAxisAlignment.start,
                       children: [
                         TextWidget(title: "By signing up, you’re agree to our  ",titleColor: Colors.black,titleSize: 14,),
                         TextWidget(title: "Terms & Conditions",titleSize: 14,titleColor: Colors.blueAccent,)
                       ],
                     ),
                     Row(
                       mainAxisAlignment: MainAxisAlignment.start,
                       children: [
                         TextWidget(title: "and ",titleColor: Colors.black,titleSize: 14,),
                         TextWidget(title: "Privacy Policy ",titleColor: Colors.blueAccent,titleSize: 14,),
                       ],
                     ),

                     SizedBox(height: 7),
                     CustomButton(
                       text: "Continue",
                       color: Colors.blue,
                       onPressed: (context) {
                         // Execute validation logic here
                         cubit.reg();
                         // if (Form.of(context)!.validate()) {
                         //   // If validation passes, navigate to the next screen
                         //   cubit.reg();
                         // }
                       },
                     ),
                     SizedBox(height: 7,),
                     Row(
                       mainAxisAlignment: MainAxisAlignment.center,
                       children: [
                         Container(
                           // width: double.infinity,
                           width: 140,
                           height: 1,
                           color: Colors.black,
                         ),
                         Padding(
                           padding: const EdgeInsets.symmetric(horizontal: 8.0),
                           child: Text('OR',style: TextStyle(fontSize: 18),),
                         ),
                         Container(
                           // width: double.infinity,
                           width: 140,
                           height: 1,
                           color: Colors.black,
                         ),
                       ],),
                     SizedBox(height: 7,),
                     Row(
                       mainAxisAlignment: MainAxisAlignment.center,
                       children: [
                         TextWidget(title: "Joined us before?  "),
                         TextWidget(title: "Sign In",titleColor: Colors.blueAccent,)
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
   );
  },
),
    );
  }
}
*/


import 'dart:convert';

import 'package:aid_robot/app/Cubit/cubit_cubit.dart';
import 'package:aid_robot/features/auth_feature/presentation/presentation_logic_holder/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

import '../../../../app/utils/consts.dart';
import '../../../../app/widgets/custom_button.dart';
import '../../../../app/widgets/custom_text_feildEmail.dart';
import '../../../../app/widgets/text_widget.dart';
import 'login.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}


class _SignUpScreenState extends State<SignUpScreen> {
  var titelControler = TextEditingController();
  var timeControler = TextEditingController();
  var dateControler = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final RegExp phoneRegex = RegExp(r'^[0-9]+$');
  late RegExp passwordRegExp;
  var emailController;
  var nameController;
  bool _obscureText = true;
  bool _isConfirmed = false;
  bool _isNotvalidate = false;
  TextEditingController passwordController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  void registerUser() async {
    if (emailController.text.isNotEmpty && passwordController.text.isNotEmpty) {
      var reqBody = {
        "name": nameController.text,
        "email": emailController.text,
        "password": passwordController.text,
        "phone": phoneController.text,
      };

      var response = await http.post(Uri.parse(registration), body: jsonEncode(reqBody));
      var jsonResponse = response.body;
      var decodedResponse = jsonDecode(jsonResponse);
      var status = decodedResponse['status'];
      if (status is bool && status) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => LoginScreens(),
          ),
        );
      } else {
        print("Something went wrong ");
      }
    } else {
      setState(() {
        _isNotvalidate = true;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    emailController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    passwordRegExp = RegExp(
      r'^(?=.*[a-zA-Z])(?=.*\d)(?=.*[@!%*?&])[\w@!%*?&]{8,}$',
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(
          create: (context) => AuthCubit(),
        ),
        BlocProvider<RegisterCubit>(
          create: (context) => RegisterCubit(),
        ),
      ],
      child: Scaffold(
        body: BlocBuilder<AuthCubit, AuthState>(
          builder: (context, state) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset("assets/images/sign_up.png"),
                    SizedBox(height: 7,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextWidget(
                          title: "Sign Up",
                          titleColor: Colors.black,
                          titleFontWeight: FontWeight.bold,
                          titleSize: 25,
                        ),
                        Form(
                          key: formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              SizedBox(height: 7),
                              CustomTextField(
                                text: 'Name',
                                controller: nameController,
                                onChanged: (value) {
                                  nameController.text = value;
                                },
                                obscureText: false,
                                keyboardType: TextInputType.name,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter a name';
                                  }
                                  return null;
                                },
                                inputFormatters: [],
                              ),
                              SizedBox(height: 7),
                              CustomTextField(
                                controller: emailController,
                                onChanged: (value) {
                                  emailController.text = value;
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
                              SizedBox(height: 7),
                              CustomTextField(
                                controller: passwordController,
                                onChanged: (value) {
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
                                  return null;
                                },
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                    RegExp(r'^(?=.*[a-zA-Z])(?=.*\d)(?=.*[@!%*?&])[\w@!%*?&]{8,}$'),
                                  ),
                                ],
                              ),
                              SizedBox(height: 7),
                              CustomTextField(
                                controller: phoneController,
                                onChanged: (value) {
                                  phoneController.text = value;
                                },
                                text: 'Phone Number',
                                prefixIcon: Icon(Icons.phone),
                                keyboardType: TextInputType.phone,
                                obscureText: false,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter a phone number';
                                  }
                                  if (!phoneRegex.hasMatch(value)) {
                                    return 'Please enter a valid phone number';
                                  }
                                  return null;
                                },
                                inputFormatters: [],
                              ),
                              SizedBox(height: 7,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  TextWidget(
                                    title: "By signing up, you agree to our",
                                    titleColor: Colors.black,
                                    titleSize: 14,
                                  ),
                                  TextWidget(
                                    title: "Terms & Conditions",
                                    titleSize: 14,
                                    titleColor: Colors.blueAccent,
                                  )
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  TextWidget(
                                    title: "and ",
                                    titleColor: Colors.black,
                                    titleSize: 14,
                                  ),
                                  TextWidget(
                                    title: "Privacy Policy ",
                                    titleColor: Colors.blueAccent,
                                    titleSize: 14,
                                  ),
                                ],
                              ),
                              SizedBox(height: 7),
                              if (state is LoadingStateRegister)
                                const Center(child: CircularProgressIndicator())

                              else
                                CustomButton(
                                  text: "Continue",
                                  color: Colors.blue,
                                  onPressed: (v) {
                                    if (formKey.currentState!.validate()) {
                                      RegisterCubit.get(context).userRegister(
                                        email: emailController.text,
                                        password: passwordController.text,
                                        name: nameController.text,
                                        phone: phoneController.text,
                                      );
                                      Fluttertoast.showToast(
                                        msg: "successfully registered",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.BOTTOM,
                                        timeInSecForIosWeb: 1,
                                        backgroundColor: Colors.green,
                                        textColor: Colors.white,
                                        fontSize: 16.0,
                                      );
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => LoginScreens(),
                                        ),
                                      );
                                    }
                                    else {
                                      Fluttertoast.showToast(
                                        msg: "Something went wrong, try again",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.BOTTOM,
                                        timeInSecForIosWeb: 1,
                                        backgroundColor: Colors.red,
                                        textColor: Colors.white,
                                        fontSize: 16.0,
                                      );
                                    }
                                  },
                                ),
                              SizedBox(height: 7,),
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
                                    child: Text('OR', style: TextStyle(fontSize: 18)),
                                  ),
                                  Container(
                                    width: 140,
                                    height: 1,
                                    color: Colors.black,
                                  ),
                                ],
                              ),
                              SizedBox(height: 7,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  TextWidget(title: "Joined us before?  "),
                                  TextWidget(title: "Sign In", titleColor: Colors.blueAccent),
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
            );
          },
        ),
      ),
    );
  }
}
/*
class _SignUpScreenState extends State<SignUpScreen> {
  var titelControler = TextEditingController();
  var timeControler = TextEditingController();
  var dateControler = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final RegExp phoneRegex = RegExp(r'^[0-9]+$');
  late RegExp passwordRegExp;
  var  emailController;
  var  nameController;
  bool _obscureText = true;
  bool _isConfirmed = false;
  bool _isNotvalidate=false;
  TextEditingController passwordController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  void registerUser() async {
    if(emailController.text.isNotEmpty && passwordController.text.isNotEmpty){
      var reqBody={
        "name":nameController.text,
        "email":emailController.text,
        "password":passwordController.text,
        "phone":phoneController.text,
      };

      var response = await http.post(Uri.parse(registration),
          body:jsonEncode(reqBody));
      var jsonResponse = response.body;
      var decodedResponse = jsonDecode(jsonResponse);
      var status = decodedResponse['status'];
      if (status is bool && status) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => LoginScreens(),
          ),
        );
      } else {
        print("Something went wrong ");
      }

    } else {
      setState(() {
        _isNotvalidate=true;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    emailController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    passwordRegExp = RegExp(
      r'^(?=.*[a-zA-Z])(?=.*\d)(?=.*[@!%*?&])[\w@!%*?&]{8,}$',
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
        BlocProvider<AuthCubit>(
        create: (context) => AuthCubit(),
    ),
    BlocProvider<RegisterCubit>(
    create: (context) => RegisterCubit(),
    ),
    ],
    child: Scaffold(
    body: BlocBuilder<AuthCubit, AuthState>(
    builder: (context, state) {
    create: (context) => RegisterCubit();
    return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset("assets/images/sign_up.png"),
                  SizedBox(height: 7,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextWidget(title: "Sign Up",titleColor: Colors.black,titleFontWeight: FontWeight.bold,titleSize: 25,),
                      Form(
                        key: formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            SizedBox(height: 7),
                            CustomTextField(
                              text: 'Name',
                              controller: nameController,
                              onChanged: (value) {
                                // Update email value
                                nameController.text = value;
                              },
                              obscureText: false,
                              keyboardType: TextInputType.name,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter a name';
                                }
                                return null;
                              }, inputFormatters: [],
                            ),
                            SizedBox(height: 7),
                            CustomTextField(
                              controller: emailController,
                              onChanged: (value) {
                                // Update email value
                              //  emailController.text = value;
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
                            SizedBox(height: 7),
                           *//* CustomTextField(
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
                            ),*//*
                            CustomTextField(
                              controller: passwordController,
                              onChanged: (value) {
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
                                return null;
                              },
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                  RegExp(r'^(?=.*[a-zA-Z])(?=.*\d)(?=.*[@!%*?&])[\w@!%*?&]{8,}$'),
                                ),
                              ],
                            ),
                            SizedBox(height: 7),
                          *//*  CustomTextField(
                              onChanged: (value) {
                                // Update password value
                                passwordController.text = value;
                              },
                              text: 'Confirm Password',
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
                            ),*//*
                            CustomTextField(
                              controller: phoneController,
                              onChanged: (value) {
                                // Update phone value
                                phoneController.text = value;
                              },
                              text: 'Phone Number',
                              prefixIcon: Icon(Icons.phone),
                              keyboardType: TextInputType.phone,
                              obscureText: false,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter a phone number';
                                }
                                if (!phoneRegex.hasMatch(value)) {
                                  return 'Please enter a valid phone number';
                                }
                                return null;
                              },
                              inputFormatters: [],
                            ),

                            SizedBox(height: 7,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                TextWidget(title: "By signing up, you agree to our  ",titleColor: Colors.black,titleSize: 14,),
                                TextWidget(title: "Terms & Conditions",titleSize: 14,titleColor: Colors.blueAccent,)
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                TextWidget(title: "and ",titleColor: Colors.black,titleSize: 14,),
                                TextWidget(title: "Privacy Policy ",titleColor: Colors.blueAccent,titleSize: 14,),
                              ],
                            ),
                            SizedBox(height: 7),
                            *//*CustomButton(
                              text: "Continue",
                              color: Colors.blue,
                              onPressed: (p0) {
                                registerUser();
                                if (formKey.currentState!.validate()) {
                                  // If validation passes, call loginUser function with email and password
                                  //loginUser(emailController.text, passwordController.text);
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => LoginScreens(),
                                    ),
                                  );
                                }
                              },
                            ),*//*

                            if (state is LoadingStateRegister)
                              const Center(child: CircularProgressIndicator())

                            else
                              CustomButton(
                                text: "Continue",
                                color: Colors.blue,
                                onPressed: (v) {
                                  if (formKey.currentState!.validate()) {
                                    RegisterCubit.get(context).userRegister(
                                      email: emailController.text,
                                      password: passwordController.text,
                                      name: nameController.text,
                                      phone: phoneController.text,
                                    );
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => LoginScreens(),
                                      ),
                                    );

                                  }

                                },
                              ),
                            SizedBox(height: 7,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  // width: double.infinity,
                                  width: 140,
                                  height: 1,
                                  color: Colors.black,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                  child: Text('OR',style: TextStyle(fontSize: 18),),
                                ),
                                Container(
                                  // width: double.infinity,
                                  width: 140,
                                  height: 1,
                                  color: Colors.black,
                                ),
                              ],
                            ),
                            SizedBox(height: 7,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                TextWidget(title: "Joined us before?  "),
                                TextWidget(title: "Sign In",titleColor: Colors.blueAccent,)
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
          );
        },
      ),
    ));
  }
}*/
