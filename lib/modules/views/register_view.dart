import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pixa_project/injection.dart';
import 'package:pixa_project/modules/components/general_button.dart';
import 'package:pixa_project/modules/components/general_text_filed.dart';
import 'package:pixa_project/modules/components/logo_widget.dart';
import 'package:pixa_project/modules/models/user_model.dart';
import 'package:pixa_project/modules/view_models/login_view_model.dart';
import 'package:pixa_project/modules/view_models/register_view_model.dart';
import 'package:pixa_project/utils/close_keyboard.dart';
import 'package:pixa_project/utils/constants.dart';
import 'package:pixa_project/utils/context_ext.dart';
import 'package:pixa_project/utils/generate_ids.dart';
import 'package:pixa_project/utils/router/router_generator.dart';
import 'package:pixa_project/utils/router/routers.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});
  @override
  _RegisterViewState createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  late TextEditingController _username;
  late TextEditingController _email;
  late TextEditingController _password;
  late TextEditingController _age;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool isSecure = false;

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    _username = TextEditingController();
    _email = TextEditingController();
    _age = TextEditingController();
    _password = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text('Register')),
        body: SingleChildScrollView(
          child: Column(
            // shrinkWrap: true,
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
                        //--------------------- Username ---------------------//
                        GeneralTextFiled(
                          hintText: 'Username',
                          controller: _username,
                          autoFillList: const [AutofillHints.username],
                          validate: (value) {
                            if (value == null ||
                                value.trim().isEmpty ||
                                value.isEmpty) {
                              return 'Required';
                            } else if (value.trim().length < 3 ||
                                value.trim().length > 12) {
                              return 'Must be between 3 and 12 characters';
                            }
                            return null;
                          },
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(12),
                          ],
                          keyboardType: TextInputType.text,
                          prefixIcon: Padding(
                            padding: EdgeInsets.only(right: 10, left: 10),
                            child: SizedBox(
                              width: 30,
                              height: 30,
                              child: Center(
                                child: Icon(
                                  Icons.person,
                                  size: 30,
                                  color: Constants.appColor,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 15),
                        //--------------------- Age ---------------------//
                        GeneralTextFiled(
                          hintText: 'Age',
                          controller: _age,
                          validate: (value) {
                            if (value == null ||
                                value.trim().isEmpty ||
                                value.isEmpty) {
                              return 'Required';
                            } else if ((int.tryParse(value.trim()) ?? 0) < 18 ||
                                (int.tryParse(value.trim()) ?? 0) > 99) {
                              return 'Must be between 18 and 99 years old';
                            }
                            return null;
                          },
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(2),
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          keyboardType: TextInputType.number,
                          prefixIcon: Padding(
                            padding: EdgeInsets.only(right: 10, left: 10),
                            child: SizedBox(
                              width: 30,
                              height: 30,
                              child: Center(
                                child: Icon(
                                  Icons.view_agenda_outlined,
                                  size: 30,
                                  color: Constants.appColor,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 15),
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
                                handleRegister();
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
                            handleRegister();
                          },
                          width: 250,
                        ),
                        SizedBox(height: 30),
                        //--------------------- Submit ---------------------//
                        GestureDetector(
                          onTap: () {
                            RouteGenerator.routerClient.pop();
                          },
                          child: Text(
                            'Go Back',
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

  Future<void> handleRegister() async {
    if (_formKey.currentState?.validate() == true) {
      FocusScope.of(context).unfocus();
      closeKeyBoard(context);
      TextInput.finishAutofillContext();

      final model = UserModel(
        id: generateUId(),
        username: _username.text,
        email: _email.text,
        password: _password.text,
        age: int.parse(_age.text),
      );

      getIt<RegisterViewModel>().register(model, context);
    }
  }
}
