import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/app_provider.dart';
import 'themes/app_theme.dart';
import 'utils/app_routes.dart';

void main() {
  runApp(const TravelMateApp());
}

/// Main app widget
class TravelMateApp extends StatelessWidget {
  const TravelMateApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AppProvider()..init(),
      child: Consumer<AppProvider>(
        builder: (context, provider, _) {
          return MaterialApp(
            title: 'TravelMate',
            debugShowCheckedModeBanner: false,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: ThemeMode.system,
            routes: AppRoutes.getRoutes(),
            initialRoute: AppRoutes.home,
          );
        },
      ),
    );
  }
}
