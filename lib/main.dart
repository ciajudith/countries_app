import 'package:countries_app/data/country_data_controller.dart';
import 'package:countries_app/data/country_remote_data_source.dart';
import 'package:countries_app/models/api_client.dart';
import 'package:countries_app/views/country_search_screen.dart';
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
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: CountrySearchScreen(),
    );
  }
}
