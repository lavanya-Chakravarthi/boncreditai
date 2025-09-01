/// Main reward screen displaying unlocked rewards and bill information
/// 
/// This screen serves as the primary interface for users to view their
/// unlocked rewards and manage their credit card bills. It features:
/// - Animated confetti image with zoom effects
/// - Expandable bill cards with detailed information
/// - Navigation to brand selection for reward redemption
/// - Responsive layout with bottom sheet design

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/bill_provider.dart';
import '../widgets/animated_bill_card.dart';
import 'brand_screen.dart';

/// Main screen for displaying rewards and bill management
/// 
/// This StatefulWidget manages the main reward interface with animated
/// elements and interactive bill cards. It uses TickerProviderStateMixin
/// to support multiple animations simultaneously.
class RewardScreen extends StatefulWidget {
  const RewardScreen({super.key});

  @override
  State<RewardScreen> createState() => _RewardScreenState();
}

/// State class for the RewardScreen
/// 
/// Manages the animation controllers and UI state for the reward screen,
/// including the confetti zoom animation and visibility transitions.
class _RewardScreenState extends State<RewardScreen> with TickerProviderStateMixin {
  /// Controls the visibility of the main reward content
  bool _visible = false;
  
  /// Animation controller for the confetti zoom effect
  late AnimationController _zoomController;
  
  /// Animation for the confetti zoom in/out effect
  late Animation<double> _zoomAnimation;

  /// Initializes the screen state and animations
  /// 
  /// Sets up the zoom animation controller and starts the continuous
  /// zoom animation for the confetti image. Also schedules the main
  /// content visibility animation.
  @override
  void initState() {
    super.initState();
    
    // Zoom animation controller
    _zoomController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );
    
    _zoomAnimation = Tween<double>(
      begin: 0.8,
      end: 1.2,
    ).animate(CurvedAnimation(
      parent: _zoomController,
      curve: Curves.easeInOut,
    ));
    
    // Start zoom animation
    _zoomController.repeat(reverse: true);
    
    // Delay to trigger main animation after build
    Future.delayed(const Duration(milliseconds: 300), () {
      setState(() {
        _visible = true;
      });
    });
  }

  /// Cleans up animation controllers to prevent memory leaks
  @override
  void dispose() {
    _zoomController.dispose();
    super.dispose();
  }

  /// Builds the main reward screen interface
  /// 
  /// Creates a two-section layout with:
  /// - Top section: Animated reward card with confetti and claim button
  /// - Bottom section: Expandable bill cards in a bottom sheet design
  @override
  Widget build(BuildContext context) {
    final bills = context.watch<BillsProvider>().bills;

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text("Rewards"),
        centerTitle: true,
        elevation: 5,
        foregroundColor: Colors.black,
      ),
      body: Column(
        children: [

          /// Top Card for Reward
          Expanded(
            flex: 5,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: Colors.deepPurple.shade100, // dark theme color border
                    width: 2,
                  ),
                  color:Colors.deepPurple.shade200.withOpacity(0.25), // subtle fill

                ),
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AnimatedOpacity(
                      opacity: _visible ? 1.0 : 0.0,
                      duration: const Duration(milliseconds: 800),
                      curve: Curves.easeOut,
                      child: AnimatedScale(
                        scale: _visible ? 1.0 : 0.5,
                        duration: const Duration(milliseconds: 800),
                        curve: Curves.elasticOut,
                        child: ScaleTransition(
                          scale: _zoomAnimation,
                          child: Image.network(
                            "https://cdn-icons-png.flaticon.com/512/13374/13374615.png", // colorful party popper
                            height: 100,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      "You've unlocked a \$10 reward!",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const BrandScreen()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 28),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        "Choose Brand",
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
              )
              ,
            ),
          ),

          /// Bottom Sheet-like Section for Bills
          Expanded(
            flex: 5,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, -3),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: ListView.builder(
                  itemCount: bills.length,
                  itemBuilder: (context, index) {
                    final bill = bills[index];
                    return AnimatedBillCard(bill: bill, index: index);
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
