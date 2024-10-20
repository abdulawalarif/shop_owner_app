import 'package:flutter/material.dart';
import 'package:shop_owner_app/ui/routes/route_name.dart';
import 'package:shop_owner_app/ui/screens/bottom_bar.dart';
import 'package:shop_owner_app/ui/screens/feeds.dart';
import 'package:shop_owner_app/ui/screens/inner_screens/category_screen.dart';
import 'package:shop_owner_app/ui/screens/inner_screens/forgot_password.dart';
import 'package:shop_owner_app/ui/screens/inner_screens/product_detail.dart';
import 'package:shop_owner_app/ui/screens/log_in.dart';
import 'package:shop_owner_app/ui/screens/main_screen.dart';
import 'package:shop_owner_app/ui/screens/orders_list.dart';
import 'package:shop_owner_app/ui/screens/search.dart';
import 'package:shop_owner_app/ui/screens/sign_up.dart';
import 'package:shop_owner_app/ui/screens/upload_product.dart';

class Routes {
  static Route<dynamic> generatedRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteName.mainScreen:
        return MaterialPageRoute(
            builder: (BuildContext context) => const MainScreen());
      case RouteName.bottomBarScreen:
        return MaterialPageRoute(
            builder: (BuildContext context) => const BottomBarScreen());
      case RouteName.logInScreen:
        return MaterialPageRoute(
            builder: (BuildContext context) => const LogInScreen());
      case RouteName.searchScreen:
        return MaterialPageRoute(
            builder: (BuildContext context) => const SearchScreen());
      case RouteName.signUpScreen:
        return MaterialPageRoute(
            builder: (BuildContext context) => const SignUpScreen());
      case RouteName.forgotPasswordScreen:
        return MaterialPageRoute(
            builder: (BuildContext context) => const ForgotPasswordScreen());
      case RouteName.productDetailScreen:
        return MaterialPageRoute(
            builder: (BuildContext context) => ProductDetailScreen());
      case RouteName.feedsScreen:
        return MaterialPageRoute(
            builder: (BuildContext context) => const FeedsScreen());
      case RouteName.categoryScreen:
        return MaterialPageRoute(
            builder: (BuildContext context) => const CategoryScreen());
      case RouteName.uploadProductScreen:
        return MaterialPageRoute(
            builder: (BuildContext context) => const UploadProductScreen());
      case RouteName.ordersListScreen:
        return MaterialPageRoute(
            builder: (BuildContext context) => const PendingOrdersList());

      default:
        return MaterialPageRoute(builder: (_) {
          return const Scaffold(
            body: Center(
              child: Text("No route defined"),
            ),
          );
        });
    }
  }
}
