enum UserRole { buyer, owner, builder }

class UserProfile {
  final String id;
  final String name;
  final String email;
  final String phone;
  UserRole activeRole;
  final double? buyerBudgetMin;
  final double? buyerBudgetMax;
  final String? preferredCity;
  final String? preferredBhk;
  final String? companyName;
  final String? reraRegistration;

  UserProfile({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    this.activeRole = UserRole.buyer,
    this.buyerBudgetMin,
    this.buyerBudgetMax,
    this.preferredCity,
    this.preferredBhk,
    this.companyName,
    this.reraRegistration,
  });
}
