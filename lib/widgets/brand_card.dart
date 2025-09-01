/// Brand card widget for brand selection
/// 
/// This widget displays a brand in a card format with logo and name.
/// When tapped, it shows a custom popup dialog confirming the reward
/// claim instead of a standard SnackBar. The popup includes visual
/// feedback with a percentage icon and brand-specific messaging.

import 'package:flutter/material.dart';
import '../models/brand.dart';

/// Interactive card widget for brand selection
/// 
/// Displays brand information in a card format and handles tap interactions
/// to show a custom claim confirmation popup. The popup provides visual
/// feedback with animations and brand-specific messaging.
class BrandCard extends StatelessWidget {
  /// The brand data to display
  final Brand brand;
  
  const BrandCard({super.key, required this.brand});

  /// Shows a custom popup dialog for reward claim confirmation
  /// 
  /// Displays a centered dialog with:
  /// - Percentage icon in a circular background
  /// - "Claimed!" confirmation text
  /// - Brand-specific success message
  /// - Action button to dismiss the popup
  /// 
  /// The popup is dismissible by tapping outside or the action button.
  void _showClaimedPopup(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Percentage icon with circular background
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.green.shade50,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.percent,
                    size: 48,
                    color: Colors.green.shade600,
                  ),
                ),
                const SizedBox(height: 20),
                // Claimed confirmation text
                const Text(
                  "Claimed!",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
                const SizedBox(height: 8),
                // Brand-specific success message
                Text(
                  "Your reward has been applied to ${brand.name}",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[600],
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                // Action button to dismiss popup
                ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    "Great!",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  /// Builds the brand card interface
  /// 
  /// Creates a card with brand logo and name, and sets up tap handling
  /// to show the claim confirmation popup.
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () => _showClaimedPopup(context),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(brand.logoUrl, height: 50, width: 50),
            const SizedBox(height: 12),
            Text(
              brand.name,
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
