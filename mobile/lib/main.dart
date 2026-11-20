import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'core/theme/app_theme.dart';
import 'viewmodels/booking_viewmodel.dart';
import 'viewmodels/navigation_viewmodel.dart';
import 'views/onboarding/welcome_view.dart';
import 'views/navigation/main_scaffold_view.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // Set immersive dark status bar style
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: Colors.black,
      systemNavigationBarIconBrightness: Brightness.light,
    ),
  );

  runApp(const RoyalLogisticsApp());
}

class RoyalLogisticsApp extends StatelessWidget {
  const RoyalLogisticsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => BookingViewModel()),
        ChangeNotifierProvider(create: (_) => NavigationViewModel()),
      ],
      child: MaterialApp(
        title: 'Royal Logistics',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.darkTheme,
        home: Consumer<NavigationViewModel>(
          builder: (context, navVm, child) {
            if (navVm.isOnboarding) {
              return const WelcomeView();
            }
            return const MainScaffoldView();
          },
        ),
      ),
    );
  }
}
