//import 'package:batatis/RestaurantBranch_Screens/toaddress.dart';
import 'package:batatis/provider/auth_provider.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'Routes.dart';
import 'Customer_Widgets/All_customer_Widgets.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:firebase_messaging/firebase_messaging.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // WidgetsFlutterBinding.ensureInitialized();
  if (!kIsWeb) {
    Stripe.publishableKey =
        "pk_test_51O1zUECOEKBCIL7I5y7EIe67GPdPLwSWjFcuCPH3qLCk7pMXnLsZugmQInYocoXnwjW2C52GWBc4aOpGPmw75mtP00JEBWWraN";

    var initialLink = await FirebaseDynamicLinks.instance.getInitialLink();
  }
  await FirebaseMessaging.instance.getInitialMessage();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

//await getAddressFromCoordinatesUsingGoogleMapsAPI(24.724901,46.625340);
  runApp(const Batatis()); //24.724901, 46.625340
}

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print("recieved noti ");
}

class Batatis extends StatelessWidget {
  const Batatis({super.key});

  static bool istesting = false; //   var to determine if u in test or not
  static double Swidth = 0;
  static double Sheight = 0;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Swidth = MediaQuery.of(context).size.width;
    Sheight = MediaQuery.of(context).size.height;
    return MultiProvider(
        providers: [ChangeNotifierProvider(create: (_) => AuthProvider())],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'BATATIS',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Batatis_Dark),
            useMaterial3: true,
          ),
          initialRoute: kIsWeb ? '/SignInPage' : '/CSignIn',
          routes: customRoutes,
        ));
  }
}
