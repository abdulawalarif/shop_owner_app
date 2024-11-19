import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:shop_owner_app/core/models/theme_preferences.dart';
import 'package:shop_owner_app/core/view_models/products_provider.dart';
import 'package:shop_owner_app/core/view_models/picture_provider.dart';
import 'package:shop_owner_app/core/view_models/user_data_provider.dart';
import 'package:shop_owner_app/core/view_models/theme_change_provider.dart';
import 'package:shop_owner_app/core/view_models/auth_provider.dart';
import 'ui/routes/route_name.dart';
import 'ui/constants/theme_data.dart';
import 'ui/routes/router.dart';
import 'dart:developer' as devtools show log;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final isDarkTheme = await ThemePreferences().getTheme();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(MyApp(isDarkTheme: isDarkTheme));
}
class MyApp extends StatelessWidget {
  final bool isDarkTheme;
  const MyApp({super.key, required this.isDarkTheme});
  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return MultiProvider(
          providers: [
            /// fetching category products using api locator
            ChangeNotifierProvider(create: (_) => ProductsProvider()),
            ChangeNotifierProvider(create: (_) => PicturesProvider()),

            ChangeNotifierProvider(create: (_) => AuthProvider()),
            ChangeNotifierProvider(create: (_) => UserDataProvider()),
            //  ChangeNotifierProvider(create: (_) => ProductProvider()),
            ChangeNotifierProvider(
                create: (_) => ThemeChangeProvider(isDarkTheme)),
          ],
          child: Consumer<ThemeChangeProvider>(
            builder: (_, themeChangeProvider, __) {
              return Consumer<ProductsProvider>(
                builder:  (_, productProvider, __) {
                  productProvider.fetchProducts();

                  return MaterialApp(
                    debugShowCheckedModeBanner: false,
                    title: 'Store App',
                    theme: Styles.getThemeData(themeChangeProvider.isDarkTheme),
                    initialRoute: RouteName.mainScreen,
                    onGenerateRoute: Routes.generatedRoute,
                  );
                },
              );
            },
          ),
        );
      },
    );
  }
}


extension Log on Object {
  void log() => devtools.log(toString());
}