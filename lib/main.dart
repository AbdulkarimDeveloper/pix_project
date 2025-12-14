import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:pixa_project/injection.dart';
import 'package:pixa_project/utils/close_keyboard.dart';
import 'package:pixa_project/utils/router/router_generator.dart';
import 'package:pixa_project/utils/constants.dart';
import 'package:pixa_project/utils/localization.dart';
import 'package:pixa_project/utils/resources_path.dart';
import 'package:pixa_project/utils/themes/dark_theme.dart';
import 'package:pixa_project/utils/themes/light_theme.dart';
import 'package:toastification/toastification.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await initInjection();

  await dotenv.load(fileName: "lib/utils/.env");

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return EasyLocalization(
      supportedLocales: Localization.supportedLocals,
      path: ResourcesPath.translations,
      startLocale: Localization.startLocale,
      fallbackLocale: Localization.fallbackLocale,
      child: AdaptiveTheme(
        light: lightTheme(),
        dark: darkTheme(),
        initial: Constants.isDark
            ? AdaptiveThemeMode.dark
            : AdaptiveThemeMode.light,
        builder: (theme, darkTheme) {
          return StartApp(lightTheme: theme, darkTheme: darkTheme);
        },
      ),
    );
  }
}

class StartApp extends StatelessWidget {
  const StartApp({
    super.key,
    required this.lightTheme,
    required this.darkTheme,
  });

  final ThemeData? lightTheme;
  final ThemeData? darkTheme;

  @override
  Widget build(BuildContext context) {
    return ToastificationWrapper(
      child: MaterialApp.router(
        title: Constants.appName,
        color: Constants.appColor,
        debugShowCheckedModeBanner: false,
        themeMode: Constants.isDark ? ThemeMode.dark : ThemeMode.light,
        theme: lightTheme,
        darkTheme: darkTheme,
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: Localization.supportedLocals,
        locale: context.locale,
        routeInformationParser:
            RouteGenerator.routerClient.routeInformationParser,
        routerDelegate: RouteGenerator.routerClient.routerDelegate,
        routeInformationProvider:
            RouteGenerator.routerClient.routeInformationProvider,
        builder: (context, child) => Stack(
          children: [
            GestureDetector(
              onTap: () {
                closeKeyBoard(context);
              },
              child: child ?? const SizedBox(),
            ),
          ],
        ),
      ),
    );
  }
}
