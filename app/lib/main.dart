import 'package:app/modules/authenticate/login2/page/login2_page.dart';
import 'package:app/shared/provider/user_provider.dart';
import 'package:app/shared/theme/themeconfig.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => UserProvider())],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        // home: SplashPage(),
        theme: Themeconfig.theme,
        home: const Login2Page(),
      ),
    );
  }
}
