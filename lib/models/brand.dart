/// Data model representing a brand for reward redemption
/// 
/// This model contains information about brands that users can select
/// when claiming their rewards. It includes the brand name and logo URL
/// for display purposes.

/// Represents a brand available for reward redemption
/// 
/// This immutable model class holds information about brands that
/// users can select when claiming their rewards. Used primarily
/// in the BrandScreen for displaying available redemption options.
class Brand {
  /// The name of the brand (e.g., "Amazon", "Flipkart")
  final String name;
  
  /// URL to the brand's logo image for display
  final String logoUrl;

  /// Creates a new Brand instance
  /// 
  /// Both name and logoUrl are required to properly display
  /// the brand in the selection interface.
  Brand({required this.name, required this.logoUrl});
}
