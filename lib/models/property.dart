enum PropertyType { apartment, villa, plot, commercial }
enum SellerRole { owner, builder }

class UnitConfig {
  final String bhk;
  final double areaSqFt;
  final double price;
  final int totalUnits;

  UnitConfig({
    required this.bhk,
    required this.areaSqFt,
    required this.price,
    required this.totalUnits,
  });

  Map<String, dynamic> toJson() => {
    'bhk': bhk,
    'areaSqFt': areaSqFt,
    'price': price,
    'totalUnits': totalUnits,
  };

  factory UnitConfig.fromJson(Map<String, dynamic> json) => UnitConfig(
    bhk: json['bhk'] as String,
    areaSqFt: (json['areaSqFt'] as num).toDouble(),
    price: (json['price'] as num).toDouble(),
    totalUnits: json['totalUnits'] as int,
  );
}

class PropertyListing {
  final String id;
  final String title;
  final SellerRole sellerRole;
  final String sellerName;
  final String sellerContact;
  final String location;
  final String city;
  final double price;
  final double areaSqFt;
  final String bhk;
  final String description;
  final List<String> imageUrls;
  final double estimatedValuation;
  final double projected5YrAppreciation;
  final double suitabilityScore;
  final bool isFlashAd;
  final String? discountTag;
  final int viewCount;
  final int leadCount;
  final Map<String, dynamic> geologicalRisks;
  final List<UnitConfig>? builderUnitConfigs;
  final List<String> legalDocs;
  final DateTime? createdAt;

  PropertyListing({
    required this.id,
    required this.title,
    required this.sellerRole,
    required this.sellerName,
    required this.sellerContact,
    required this.location,
    required this.city,
    required this.price,
    required this.areaSqFt,
    required this.bhk,
    required this.description,
    required this.imageUrls,
    required this.estimatedValuation,
    required this.projected5YrAppreciation,
    required this.suitabilityScore,
    this.isFlashAd = false,
    this.discountTag,
    this.viewCount = 0,
    this.leadCount = 0,
    required this.geologicalRisks,
    this.builderUnitConfigs,
    required this.legalDocs,
    this.createdAt,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'sellerRole': sellerRole.name,
    'sellerName': sellerName,
    'sellerContact': sellerContact,
    'location': location,
    'city': city,
    'price': price,
    'areaSqFt': areaSqFt,
    'bhk': bhk,
    'description': description,
    'imageUrls': imageUrls,
    'estimatedValuation': estimatedValuation,
    'projected5YrAppreciation': projected5YrAppreciation,
    'suitabilityScore': suitabilityScore,
    'isFlashAd': isFlashAd,
    'discountTag': discountTag,
    'viewCount': viewCount,
    'leadCount': leadCount,
    'geologicalRisks': geologicalRisks,
    'builderUnitConfigs': builderUnitConfigs?.map((u) => u.toJson()).toList(),
    'legalDocs': legalDocs,
    'createdAt': createdAt?.toIso8601String() ?? DateTime.now().toIso8601String(),
  };

  factory PropertyListing.fromJson(Map<String, dynamic> json) => PropertyListing(
    id: json['id'] as String,
    title: json['title'] as String,
    sellerRole: SellerRole.values.firstWhere((e) => e.name == json['sellerRole']),
    sellerName: json['sellerName'] as String,
    sellerContact: json['sellerContact'] as String,
    location: json['location'] as String,
    city: json['city'] as String,
    price: (json['price'] as num).toDouble(),
    areaSqFt: (json['areaSqFt'] as num).toDouble(),
    bhk: json['bhk'] as String,
    description: json['description'] as String,
    imageUrls: List<String>.from(json['imageUrls'] as List),
    estimatedValuation: (json['estimatedValuation'] as num).toDouble(),
    projected5YrAppreciation: (json['projected5YrAppreciation'] as num).toDouble(),
    suitabilityScore: (json['suitabilityScore'] as num).toDouble(),
    isFlashAd: json['isFlashAd'] as bool? ?? false,
    discountTag: json['discountTag'] as String?,
    viewCount: json['viewCount'] as int? ?? 0,
    leadCount: json['leadCount'] as int? ?? 0,
    geologicalRisks: Map<String, dynamic>.from(json['geologicalRisks'] as Map? ?? {}),
    builderUnitConfigs: (json['builderUnitConfigs'] as List?)
        ?.map((u) => UnitConfig.fromJson(Map<String, dynamic>.from(u as Map)))
        .toList(),
    legalDocs: List<String>.from(json['legalDocs'] as List? ?? []),
    createdAt: json['createdAt'] != null ? DateTime.tryParse(json['createdAt'] as String) : null,
  );
}
