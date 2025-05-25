import 'package:countries_app/constants/colors.dart';
import 'package:countries_app/data/country_data_controller.dart';
import 'package:countries_app/data/country_remote_data_source.dart';
import 'package:countries_app/models/api_client.dart';
import 'package:countries_app/views/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  runApp(
    ChangeNotifierProvider(
      create: (_) =>
          CountryController(CountryRemoteDataSourceImpl(ApiClient())),
      child: const CountryApp(),
    ),
  );
}

class CountryApp extends StatelessWidget {
  const CountryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Countries App',
      theme: ThemeData(
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide:
                BorderSide(color: AppColors.gray.withValues(alpha: 0.4)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: AppColors.goldDark, width: 2),
          ),
        ),
        cardColor: AppColors.white,
        scaffoldBackgroundColor: AppColors.white,
      ),
      home: WelcomeScreen(),
    );
  }
}
