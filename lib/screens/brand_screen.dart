/// Brand selection screen for reward redemption
/// 
/// This screen displays a grid of available brands where users can
/// redeem their rewards. It features a responsive grid layout with
/// brand cards that show logos and names, and handle tap interactions
/// to claim rewards.

import 'package:flutter/material.dart';
import '../models/brand.dart';
import '../widgets/brand_card.dart';

/// Mock data for available brands
/// 
/// Contains sample brand data for demonstration purposes.
/// In a real application, this would be fetched from an API
/// or local database.
final List<Brand> mockBrands = [
  Brand(name: "Amazon", logoUrl: "https://img.icons8.com/color/96/amazon.png"),
  Brand(name: "Flipkart", logoUrl: "https://www.freepnglogos.com/uploads/flipkart-logo-png/flipkart-logo-icon-flat-style-png-4.png"),
  Brand(name: "Swiggy", logoUrl: "https://icon2.cleanpng.com/20180406/iiq/avbtjg3a7.webp"),
  Brand(name: "Zomato", logoUrl: "https://upload.wikimedia.org/wikipedia/commons/7/75/Zomato_logo.png?20210726145438"),
  Brand(name: "Google Pay", logoUrl: "https://img.icons8.com/color/96/google-pay.png"),
  Brand(name: "PhonePe", logoUrl: "https://static.cdnlogo.com/logos/p/92/phonepe_800.png"),
];

/// Screen for selecting a brand to redeem rewards
/// 
/// Displays a grid of brand cards that users can tap to claim their
/// rewards. Each brand card shows the brand logo and name, and
/// displays a confirmation popup when tapped.
class BrandScreen extends StatelessWidget {
  const BrandScreen({super.key});

  /// Builds the brand selection interface
  /// 
  /// Creates a responsive grid layout with brand cards.
  /// The grid adapts to different screen sizes and provides
  /// proper spacing between cards.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text("Choose a Brand"), 
        centerTitle: true, 
        elevation: 5,
        foregroundColor: Colors.black,
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // 2 cards per row
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          childAspectRatio: 1,
        ),
        itemCount: mockBrands.length,
        itemBuilder: (context, index) {
          return BrandCard(brand: mockBrands[index]);
        },
      ),
    );
  }
}
