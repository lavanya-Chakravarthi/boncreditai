/// Provider for managing credit card bill data
/// 
/// This provider uses the ChangeNotifier pattern to manage the state
/// of credit card bills throughout the application. It provides:
/// - Mock data for demonstration purposes
/// - Getter access to the bills list
/// - Notifies listeners when bill data changes
/// 
/// The provider is initialized with sample data including different
/// bill statuses (Pending, Paid, Overdue) for testing various UI states.

import 'package:flutter/material.dart';
import '../models/credit_card_bill.dart';

/// Manages the state of credit card bills in the application
/// 
/// Uses ChangeNotifier to automatically notify widgets when
/// the bill data changes, enabling reactive UI updates.
class BillsProvider with ChangeNotifier {
  /// Private list of credit card bills
  /// 
  /// Contains mock data for demonstration purposes.
  /// In a real application, this would be populated from an API
  /// or local database.
  final List<CreditCardBill> _bills = [
    CreditCardBill(
        brand: '',
      cardNumber: "**** **** **** 5123",
      amount: 120.50,
      dueDate: "Aug 15, 2025",
      status: "Pending",
      logoUrl: "https://img.icons8.com/color/48/visa.png",
    ),
    CreditCardBill(
      brand: '',
      cardNumber: "**** **** **** 5123",
      amount: 300.75,
      dueDate: "Sep 15, 2025",
      status: "Paid",
      logoUrl: "https://img.icons8.com/color/48/visa.png",
    ),
    CreditCardBill(
      brand: '',
      cardNumber: "**** **** **** 5123",
      amount: 89.99,
      dueDate: "Oct 15, 2025",
      status: "Overdue",
      logoUrl: "https://img.icons8.com/color/48/visa.png",
    ),
  ];

  /// Getter for accessing the list of bills
  /// 
  /// Returns the current list of credit card bills.
  /// Widgets can listen to changes in this data by using
  /// context.watch<BillsProvider>() or context.listen<BillsProvider>().
  List<CreditCardBill> get bills => _bills;
}
