import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pixa_project/injection.dart';
import 'package:pixa_project/modules/components/general_button.dart';
import 'package:pixa_project/modules/components/general_text_filed.dart';
import 'package:pixa_project/modules/components/logo_widget.dart';
import 'package:pixa_project/modules/models/user_model.dart';
import 'package:pixa_project/modules/view_models/login_view_model.dart';
import 'package:pixa_project/utils/close_keyboard.dart';
import 'package:pixa_project/utils/constants.dart';
import 'package:pixa_project/utils/context_ext.dart';
import 'package:pixa_project/utils/generate_ids.dart';
import 'package:pixa_project/utils/profile_data.dart';
import 'package:pixa_project/utils/router/router_generator.dart';
import 'package:pixa_project/utils/router/routers.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late TextEditingController _email;
  late TextEditingController _password;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool isSecure = false;

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    _email = TextEditingController(text: ProfileData.instance.model?.email);
    _password = TextEditingController(
      text: ProfileData.instance.model?.password,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text('Login')),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 70),
              //--------------------- Logo ---------------------//
              LogoWidget(),
              SizedBox(height: 25),

              Container(
                padding: const EdgeInsets.all(8.0),
                child: Form(
                  key: _formKey,
                  child: AutofillGroup(
                    child: Column(
                      children: [
                        //--------------------- Email ---------------------//
                        GeneralTextFiled(
                          hintText: 'Email',
                          controller: _email,
                          autoFillList: const [AutofillHints.email],
                          validate: (value) {
                            if (value == null ||
                                value.trim().isEmpty ||
                                value.isEmpty) {
                              return 'Required';
                            }
                            return null;
                          },
                          keyboardType: TextInputType.emailAddress,
                          prefixIcon: Padding(
                            padding: EdgeInsets.only(right: 10, left: 10),
                            child: SizedBox(
                              width: 30,
                              height: 30,
                              child: Center(
                                child: Icon(
                                  Icons.email,
                                  size: 30,
                                  color: Constants.appColor,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 15),
                        //--------------------- Password ---------------------//
                        StatefulBuilder(
                          builder: (BuildContext context, setState) {
                            return GeneralTextFiled(
                              prefixIcon: Padding(
                                padding: EdgeInsets.only(right: 10, left: 10),
                                child: SizedBox(
                                  width: 30,
                                  height: 30,
                                  child: Center(
                                    child: Icon(
                                      Icons.lock_outline_rounded,
                                      size: 30,
                                      color: Constants.appColor,
                                    ),
                                  ),
                                ),
                              ),
                              onSubmit: (p0) {
                                handleLogin();
                              },
                              hintText: 'Password',
                              autoFillList: const [AutofillHints.password],
                              controller: _password,
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(12),
                              ],
                              validate: (value) {
                                if (value == null ||
                                    value.trim().isEmpty ||
                                    value.isEmpty) {
                                  return 'Required';
                                } else if (value.trim().length < 6 ||
                                    value.trim().length > 12) {
                                  return 'Must be between 6 and 12 characters';
                                }
                                return null;
                              },
                              keyboardType: TextInputType.visiblePassword,
                              obscureText: !isSecure,
                              subfixIcon: InkWell(
                                onTap: () {
                                  isSecure = !isSecure;
                                  setState(() {});
                                },
                                child: Icon(
                                  isSecure == true
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: Constants.appColor,
                                ),
                              ),
                            );
                          },
                        ),
                        SizedBox(height: 30),
                        //--------------------- Submit ---------------------//
                        GeneralButton(
                          border: false,
                          padding: const EdgeInsets.symmetric(
                            vertical: 15,
                            horizontal: 45,
                          ),
                          fontSize: 18,
                          text: 'Submit',
                          color: Constants.appColor,
                          onTap: () {
                            handleLogin();
                          },
                          width: 250,
                        ),
                        SizedBox(height: 30),
                        //--------------------- Submit ---------------------//
                        GestureDetector(
                          onTap: () {
                            RouteGenerator.routerClient.pushNamed(
                              Routers.registerName,
                            );
                          },
                          child: Text(
                            'Register',
                            style: context.titleStyle.copyWith(
                              color: Constants.appColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> handleLogin() async {
    if (_formKey.currentState?.validate() == true) {
      FocusScope.of(context).unfocus();
      closeKeyBoard(context);
      TextInput.finishAutofillContext();

      final model = UserModel(
        id: generateUId(),
        username: '',
        email: _email.text,
        password: _password.text,
        age: 0,
      );

      getIt<LoginViewModel>().login(model, context);
    }
  }
}
