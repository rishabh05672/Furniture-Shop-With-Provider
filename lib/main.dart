import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:furniture_shop_app/app_started.dart';
import 'package:furniture_shop_app/providers/app_state_provider.dart';
import 'package:furniture_shop_app/providers/auth_provider.dart';
import 'package:furniture_shop_app/screens/auth/sign_in_screen.dart';
import 'package:furniture_shop_app/screens/auth/sign_up_screen.dart';
import 'package:furniture_shop_app/screens/config/theme.dart';

import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarBrightness: Brightness.light,
      statusBarColor: Colors.transparent,
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppStateProvider()),
        ChangeNotifierProvider(create: (_) => AuthProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Furniture Shop',
        theme: AppTheme.lightTheme,
        home: //AppStarted(),
            SignInScreen(),
        // SignUpScreen(),
      ),
    );
  }
}
