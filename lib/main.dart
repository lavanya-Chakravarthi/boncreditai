/// BonAI - Credit Card Bill Management and Rewards App
/// 
/// This Flutter application provides a comprehensive solution for managing
/// credit card bills and claiming rewards. The app features:
/// - Interactive bill cards with expandable details
/// - Reward claiming system with brand selection
/// - Animated UI elements for enhanced user experience
/// - State management using Provider pattern
/// 
/// Author: BonAI Development Team
/// Version: 1.0.0

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/bill_provider.dart';
import 'screens/reward_screen.dart';

/// Main entry point of the application
/// 
/// Initializes the app with Provider setup for state management
/// and launches the main RewardScreen as the home screen.
void main() {
  runApp(
      MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => BillsProvider()),
          ],
      child:MyApp())
  );
}

/// Root application widget
/// 
/// Configures the MaterialApp with theme settings and sets up
/// the initial route to the RewardScreen.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  /// Builds the main application widget
  /// 
  /// Returns a MaterialApp configured with:
  /// - Deep purple color scheme
  /// - Material 3 design system
  /// - RewardScreen as the home screen
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BonAI - Bill Management & Rewards',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const RewardScreen(),
    );
  }
}

