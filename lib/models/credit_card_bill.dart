/// Data model representing a credit card bill
/// 
/// This model contains all the necessary information about a credit card bill
/// including the brand, card details, amount, due date, and status.
/// It also provides utility methods for formatting card numbers securely.

/// Represents a credit card bill with all associated details
/// 
/// This immutable model class holds information about credit card bills
/// and provides a computed property for masked card numbers to ensure
/// security when displaying card information.
class CreditCardBill {
  /// The brand name of the credit card (e.g., "Visa", "Mastercard")
  final String brand;
  
  /// The full card number (should be handled securely in production)
  final String cardNumber;
  
  /// The amount due for this bill
  final double amount;
  
  /// The due date for the bill payment
  final String dueDate;
  
  /// The current status of the bill ("Pending", "Paid", "Overdue")
  final String status;
  
  /// URL to the brand logo image
  final String logoUrl;

  /// Creates a new CreditCardBill instance
  /// 
  /// All parameters are required to ensure complete bill information.
  /// The cardNumber should be handled securely in production environments.
  CreditCardBill({
    required this.brand,
    required this.cardNumber,
    required this.amount,
    required this.dueDate,
    required this.status,
    required this.logoUrl,
  });

  /// Returns a masked version of the card number for secure display
  /// 
  /// Formats the card number as "**** **** **** XXXX" where XXXX
  /// represents the last 4 digits of the card number.
  /// 
  /// Returns the original cardNumber if it has fewer than 4 characters.
  String get maskedCardNumber {
    if (cardNumber.length >= 4) {
      return "**** **** **** ${cardNumber.substring(cardNumber.length - 4)}";
    }
    return cardNumber;
  }
}
