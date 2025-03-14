import 'package:final_project_2025/common/widgets/app_bar_widget.dart';
import 'package:final_project_2025/common/widgets/form_button_widget.dart';
import 'package:final_project_2025/constants/gaps.dart';
import 'package:final_project_2025/constants/sizes.dart';
import 'package:final_project_2025/features/authentication/view_models/sign_up_view_model.dart';
import 'package:final_project_2025/features/authentication/views/login_screen.dart';
import 'package:final_project_2025/features/settings/view_models/settings_view_model.dart';
import 'package:final_project_2025/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

class SignUpScreen extends ConsumerStatefulWidget {
  static const String routeName = "signup";
  static const String routeURL = "/";
  const SignUpScreen({super.key});

  @override
  ConsumerState<SignUpScreen> createState() => SignUpScreenState();
}

class SignUpScreenState extends ConsumerState<SignUpScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordController = TextEditingController();
  //final Map<String, dynamic> _formData = {};
  bool _obsecureText = true;
  bool _isValid = false;

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  String? _emailValidator(String? email) {
    if (email == null || email == "") {
      return "Enter your email";
    }
    //final regExp = RegExp()
    //r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    final regExp = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
    );
    if (!regExp.hasMatch(email)) {
      return "Not valid email";
    }

    return null;
  }

  String? _passwordValidator(String? password) {
    if (password == null || password == "") {
      return "Enter your password";
    } else {
      if (password.length < 8) {
        return "At least 8 characters";
      }

      return null;
    }
  }

  void _onSubmitted(BuildContext context) {
    if (_formKey.currentState != null) {
      if (_formKey.currentState!.validate()) {
        _formKey.currentState!.save();

        ref.read(signUpProvider.notifier).signUp(context);

        showInfoSnackBar(title: "Creating your accout", context: context);
      }
    }
  }

  void _onLoginTap(BuildContext context) {
    context.pushNamed(LoginScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    final isDark = ref.watch(settingsProvider).darkmode;
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBarWidget(showGear: false),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: Sizes.size20),
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Gaps.v96,
              Text(
                "Join!",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: Sizes.size20,
                  fontWeight: FontWeight.w800,
                ),
              ),
              Gaps.v32,
              Form(
                key: _formKey,
                onChanged: () {
                  setState(() {
                    _isValid = _formKey.currentState!.validate();
                  });
                },
                child: Column(
                  children: [
                    FractionallySizedBox(
                      widthFactor: 0.8,
                      child: TextFormField(
                        autocorrect: false,
                        autovalidateMode: AutovalidateMode.always,
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        validator: (value) => _emailValidator(value),
                        onSaved: (newValue) {
                          if (newValue != null) {
                            ref.read(signUpForm.notifier).state = {
                              "email": newValue,
                            };
                          }
                        },
                        decoration: InputDecoration(
                          hintText: "Email",
                          hintStyle: TextStyle(
                            fontSize: Sizes.size18,
                            color: Colors.grey.shade400,
                            fontWeight: FontWeight.w600,
                          ),
                          filled: true,
                          fillColor:
                              isDark ? Colors.grey.shade800 : Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(Sizes.size32),
                            borderSide: BorderSide(
                              color:
                                  isDark ? Colors.grey.shade600 : Colors.black,
                              width: Sizes.size1,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(Sizes.size32),
                            borderSide: BorderSide(
                              color:
                                  isDark ? Colors.grey.shade600 : Colors.black,
                              width: Sizes.size1,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(Sizes.size32),
                            borderSide: BorderSide(
                              color:
                                  isDark ? Colors.grey.shade600 : Colors.black,
                              width: Sizes.size1,
                            ),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(Sizes.size32),
                            borderSide: BorderSide(
                              color:
                                  isDark ? Colors.grey.shade600 : Colors.black,
                              width: Sizes.size1,
                            ),
                          ),
                          contentPadding: EdgeInsets.all(Sizes.size12),
                        ),
                      ),
                    ),
                    Gaps.v10,
                    FractionallySizedBox(
                      widthFactor: 0.8,
                      child: TextFormField(
                        controller: _passwordController,
                        obscureText: _obsecureText,
                        autocorrect: false,
                        autovalidateMode: AutovalidateMode.always,
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.done,
                        validator: (value) => _passwordValidator(value),
                        onSaved: (newValue) {
                          if (newValue != null) {
                            final state = ref.read(signUpForm.notifier).state;
                            ref.read(signUpForm.notifier).state = {
                              ...state,
                              "password": newValue,
                            };
                          }
                        },
                        decoration: InputDecoration(
                          hintText: "Password",
                          hintStyle: TextStyle(
                            fontSize: Sizes.size18,
                            color: Colors.grey.shade400,
                            fontWeight: FontWeight.w600,
                          ),
                          filled: true,
                          fillColor:
                              isDark ? Colors.grey.shade800 : Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(Sizes.size32),
                            borderSide: BorderSide(
                              color: Colors.black,
                              width: Sizes.size1,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(Sizes.size32),
                            borderSide: BorderSide(
                              color:
                                  isDark ? Colors.grey.shade600 : Colors.black,
                              width: Sizes.size1,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(Sizes.size32),
                            borderSide: BorderSide(
                              color:
                                  isDark ? Colors.grey.shade600 : Colors.black,
                              width: Sizes.size1,
                            ),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(Sizes.size32),
                            borderSide: BorderSide(
                              color:
                                  isDark ? Colors.grey.shade600 : Colors.black,
                              width: Sizes.size1,
                            ),
                          ),
                          contentPadding: EdgeInsets.all(Sizes.size12),
                          suffix: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              GestureDetector(
                                onTap: () => _passwordController.clear(),
                                child: FaIcon(
                                  FontAwesomeIcons.solidCircleXmark,
                                  color: Colors.grey.shade500,
                                  size: Sizes.size20,
                                ),
                              ),
                              Gaps.h16,
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _obsecureText = !_obsecureText;
                                  });
                                },
                                child: FaIcon(
                                  _obsecureText
                                      ? FontAwesomeIcons.eye
                                      : FontAwesomeIcons.eyeSlash,
                                  color: Colors.grey.shade500,
                                  size: Sizes.size20,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Gaps.v20,
                    GestureDetector(
                      onTap:
                          _isValid && !ref.watch(signUpProvider).isLoading
                              ? () => _onSubmitted(context)
                              : null,
                      child: FormButtonWidget(
                        isValid:
                            _isValid && !ref.watch(signUpProvider).isLoading,
                        text: "Create Account",
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          height: MediaQuery.of(context).size.height * 0.1,
          child: Container(
            width: MediaQuery.of(context).size.width,
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(
              vertical: Sizes.size10,
              horizontal: Sizes.size20,
            ),
            child: GestureDetector(
              onTap: () => _onLoginTap(context),
              child: FormButtonWidget(isValid: true, text: "Log in →"),
            ),
          ),
        ),
      ),
    );
  }
}
