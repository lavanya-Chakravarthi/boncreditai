/// Animated bill card widget with expandable functionality
/// 
/// This widget displays credit card bill information in an interactive card
/// format. It features expandable content that shows/hides detailed information
/// like amount and due date when tapped. The card includes smooth animations
/// for entry, expansion, and visual feedback.

import 'package:flutter/material.dart';
import '../models/credit_card_bill.dart';

/// Interactive card widget for displaying credit card bill information
/// 
/// This StatefulWidget creates an animated card that can be expanded
/// to show additional bill details. It uses multiple animation controllers
/// for smooth transitions and provides visual feedback for user interactions.
class AnimatedBillCard extends StatefulWidget {
  /// The credit card bill data to display
  final CreditCardBill bill;
  
  /// Index of the card for staggered animation timing
  final int index;
  
  const AnimatedBillCard({super.key, required this.bill, required this.index});

  @override
  State<AnimatedBillCard> createState() => _AnimatedBillCardState();
}

/// State class for the AnimatedBillCard
/// 
/// Manages the animation controllers and expansion state for the bill card.
/// Handles both the initial entry animation and the expand/collapse functionality.
class _AnimatedBillCardState extends State<AnimatedBillCard>
    with TickerProviderStateMixin {
  /// Controller for the initial entry animation
  late AnimationController _controller;
  
  /// Controller for the expansion animation
  late AnimationController _expandController;
  
  /// Animation for the slide-in effect
  late Animation<Offset> _offsetAnimation;
  
  /// Animation for the fade-in effect
  late Animation<double> _opacityAnimation;
  
  /// Animation for the height expansion
  late Animation<double> _heightAnimation;
  
  /// Current expansion state of the card
  bool _isExpanded = false;

  /// Initializes the animation controllers and animations
  /// 
  /// Sets up the entry animation with staggered timing based on card index,
  /// and prepares the expansion animation for smooth height transitions.
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _expandController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _offsetAnimation = Tween<Offset>(
      begin: const Offset(0, 0.2),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    ));

    _opacityAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );

    _heightAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _expandController, curve: Curves.easeInOut),
    );

    // Staggered animation based on card index
    Future.delayed(Duration(milliseconds: widget.index * 200), () {
      if (mounted) _controller.forward();
    });
  }

  /// Cleans up animation controllers to prevent memory leaks
  @override
  void dispose() {
    _controller.dispose();
    _expandController.dispose();
    super.dispose();
  }

  /// Toggles the expansion state of the card
  /// 
  /// Changes the expansion state and triggers the appropriate animation.
  /// When expanding, shows additional bill details; when collapsing,
  /// hides the detailed information.
  void _toggleExpansion() {
    setState(() {
      _isExpanded = !_isExpanded;
      if (_isExpanded) {
        _expandController.forward();
      } else {
        _expandController.reverse();
      }
    });
  }

  /// Builds the animated bill card interface
  /// 
  /// Creates a card with expandable content that shows:
  /// - Basic bill information (brand, card number, status)
  /// - Expandable section with amount and due date
  /// - Visual indicator for expansion state
  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _opacityAnimation,
      child: SlideTransition(
        position: _offsetAnimation,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 3,
          margin: const EdgeInsets.symmetric(vertical: 8),
          child: InkWell(
            onTap: _toggleExpansion,
            borderRadius: BorderRadius.circular(16),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Main content row
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 24,
                        child: Image.network(
                          widget.bill.logoUrl,
                          height: 32,
                          errorBuilder: (_, __, ___) => Text(widget.bill.brand[0]),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${widget.bill.brand} Credit Card",
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              widget.bill.maskedCardNumber,
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        widget.bill.status,
                        style: TextStyle(
                          color: widget.bill.status == "Paid"
                              ? Colors.green
                              : widget.bill.status == "Pending"
                              ? Colors.orange
                              : Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  
                  // Expandable content
                  AnimatedBuilder(
                    animation: _heightAnimation,
                    builder: (context, child) {
                      return SizeTransition(
                        sizeFactor: _heightAnimation,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 16),
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Colors.grey[50],
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Amount Due",
                                        style: TextStyle(
                                          color: Colors.grey[600],
                                          fontSize: 12,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        "\$${widget.bill.amount.toStringAsFixed(2)}",
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.red,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        "Due Date",
                                        style: TextStyle(
                                          color: Colors.grey[600],
                                          fontSize: 12,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        widget.bill.dueDate,
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  
                  // Expand/collapse indicator
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AnimatedRotation(
                        turns: _isExpanded ? 0.5 : 0.0,
                        duration: const Duration(milliseconds: 300),
                        child: Icon(
                          Icons.keyboard_arrow_down,
                          color: Colors.grey[600],
                          size: 20,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
