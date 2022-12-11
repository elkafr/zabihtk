import 'package:zabihtk/screens/account/bank_accounts_screen.dart';
import 'package:zabihtk/screens/account/customer_opinions_screen.dart';
import 'package:zabihtk/screens/account/modify_password_screen.dart';
import 'package:zabihtk/screens/account/modify_personal_info_screen.dart';
import 'package:zabihtk/screens/account/profile_screen.dart';
import 'package:zabihtk/screens/auth/account_activation_screen.dart';
import 'package:zabihtk/screens/auth/login_screen.dart';
import 'package:zabihtk/screens/cities/cities_screen.dart';
import 'package:zabihtk/screens/driver/auth/driver_login_screen.dart';
import 'package:zabihtk/screens/auth/password_activation_code_screen.dart';
import 'package:zabihtk/screens/auth/password_recovery_screen.dart';
import 'package:zabihtk/screens/auth/register_screen.dart';
import 'package:zabihtk/screens/bottom_navigation.dart/bottom_navigation_bar.dart';
import 'package:zabihtk/screens/driver/bottom_navigation.dart/driver_bottom_navigation_bar.dart';
import 'package:zabihtk/screens/orders/order_details_screen.dart';
import 'package:zabihtk/screens/driver/orders/driver_order_details_screen.dart';
import 'package:zabihtk/screens/payment/payment_screen.dart';
import 'package:zabihtk/screens/product/product_screen.dart';
import 'package:zabihtk/screens/splash/splash_screen.dart';
import 'package:zabihtk/screens/notifications/notifications_screen.dart';
import 'package:zabihtk/screens/notification/notification_screen.dart';
import 'package:zabihtk/screens/cities/cities_screen.dart';


final routes = {
  '/': (context) => SplashScreen(),
  '/login_screen': (context) => LoginScreen(),
  // '/forget_password_screen': (context) => ForgetPasswordScreen(),
   '/password_recovery_screen': (context) => PasswordRecoveryScreen(),
  '/navigation': (context) => BottomNavigation(),
  '/driver_navigation': (context) => DriverBottomNavigation(),
  '/product_screen':(context) => ProductScreen(),
  '/order_details_screen':(context) =>  OrderDetailsScreen(),
  '/driver_order_details_screen':(context) =>  DriverOrderDetailsScreen(),
  '/bank_accounts_screen':(context) => BankAccountScreen(),
  '/customer_opinions_screen' :(context) => CustomerOpinionsScreen(),
  '/profile_screen' :(context) => ProfileScreen(),
  '/modify_password_screen' :(context) => ModifyPasswordScreen(),
  '/modify_personal_info_screen':(context) => ModifyPersonalInfoScreen(),
  '/register_screen' : (context) => RegisterScreen() ,
  '/account_activation_screen' :(context) => AccountActivationScreen(),
  '/password_activation_code_screen':(context) =>  PasswordActivationCodeScreen(),
  '/payment_screen':(context) => PaymentScreen(),
  '/notifications_screen':(context) => NotificationsScreen(),
  '/notification_screen':(context) => NotificationScreen(),
  '/driver_login_screen':(context) => DriverLoginScreen(),
  '/cities_screen':(context) => CitiesScreen()

  
 
};
