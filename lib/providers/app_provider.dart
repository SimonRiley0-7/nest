import 'package:flutter/foundation.dart';
import '../models/property.dart';
import '../models/user_role.dart';
import '../services/firebase_property_service.dart';

class AppProvider with ChangeNotifier {
  UserRole _activeRole = UserRole.buyer;
  String _selectedCity = 'All Cities';
  String _searchQuery = '';
  bool _isAuthenticated = false;

  // Filters
  double _minBudget = 0;
  double _maxBudget = 100000000;
  String _selectedBhkFilter = 'Any';
  String _selectedPropertyType = 'Any';

  final FirebasePropertyService _firebaseService = FirebasePropertyService();

  UserRole get activeRole => _activeRole;
  String get selectedCity => _selectedCity;
  String get searchQuery => _searchQuery;
  bool get isAuthenticated => _isAuthenticated;
  double get minBudget => _minBudget;
  double get maxBudget => _maxBudget;
  String get selectedBhkFilter => _selectedBhkFilter;
  String get selectedPropertyType => _selectedPropertyType;

  // Local in-memory cache populated from Firestore stream
  List<PropertyListing> _properties = [];
  List<PropertyListing> get properties => _properties;

  AppProvider() {
    // Seed with demo data while Firestore loads
    _properties = _demoProperties;
    // Start listening to Firestore
    _firebaseService.streamProperties().listen((list) {
      if (list.isEmpty) {
        // If Firestore is empty, seed with demo data once
        _seedDemoData();
      } else {
        _properties = list;
        notifyListeners();
      }
    }, onError: (e) {
      // If Firestore fails (e.g. no internet), keep demo data
      debugPrint('Firestore stream error: $e');
    });
  }

  Future<void> _seedDemoData() async {
    for (final p in _demoProperties) {
      await _firebaseService.saveProperty(p);
    }
  }

  // ─── Seed / Demo Properties ───────────────────────────────────────────────
  static final List<PropertyListing> _demoProperties = [
    PropertyListing(
      id: 'prop_1',
      title: 'Skyline Grand 3BHK Eco-Residences',
      sellerRole: SellerRole.builder,
      sellerName: 'Apex Urban Developers',
      sellerContact: '+91 98765 43210',
      location: 'Whitefield, Bangalore',
      city: 'Bangalore',
      price: 13500000,
      areaSqFt: 1850,
      bhk: '3BHK',
      description: 'Luxury smart green 3BHK apartment with EV charging, rooftop infinity pool, top international schools within 1.5 km.',
      imageUrls: ['https://images.unsplash.com/photo-1545324418-cc1a3fa10c00?w=800'],
      estimatedValuation: 14200000,
      projected5YrAppreciation: 42.5,
      suitabilityScore: 94.8,
      isFlashAd: true,
      discountTag: '5% Early Bird Discount before Nov 30',
      viewCount: 1420,
      leadCount: 88,
      geologicalRisks: {
        'seismicZone': 'Zone II (Low)',
        'floodRisk': 'Very Low (Elevated Plateau)',
        'airQualityIndex': 42,
        'groundwaterDepth': '140 ft',
      },
      builderUnitConfigs: [
        UnitConfig(bhk: '2BHK', areaSqFt: 1250, price: 9200000, totalUnits: 24),
        UnitConfig(bhk: '3BHK', areaSqFt: 1850, price: 13500000, totalUnits: 16),
      ],
      legalDocs: ['RERA_CERT_BGL_2026.pdf', 'TITLE_DEED_APEX.pdf'],
    ),
    PropertyListing(
      id: 'prop_2',
      title: 'Greenwoods Luxury Villa Compound',
      sellerRole: SellerRole.owner,
      sellerName: 'Rajesh Kumar (Owner)',
      sellerContact: '+91 91234 56789',
      location: 'Koregaon Park, Pune',
      city: 'Pune',
      price: 24000000,
      areaSqFt: 3100,
      bhk: '4BHK',
      description: 'Independent owner listing. Fully renovated Mediterranean style villa with private garden, solar grid, and Italian marble.',
      imageUrls: ['https://images.unsplash.com/photo-1613977257363-707ba9348227?w=800'],
      estimatedValuation: 25500000,
      projected5YrAppreciation: 38.0,
      suitabilityScore: 89.2,
      isFlashAd: false,
      discountTag: 'Direct Owner - Zero Brokerage',
      viewCount: 610,
      leadCount: 29,
      geologicalRisks: {
        'seismicZone': 'Zone III (Moderate)',
        'floodRisk': 'Low',
        'airQualityIndex': 38,
        'groundwaterDepth': '90 ft',
      },
      legalDocs: ['712_EXTRACT_PUNE.pdf', 'NOC_MUNICIPAL.pdf'],
    ),
  ];

  List<PropertyListing> get filteredProperties {
    return _properties.where((p) {
      if (p.price < _minBudget || p.price > _maxBudget) return false;
      if (_selectedBhkFilter != 'Any' && p.bhk != _selectedBhkFilter) return false;
      if (_selectedPropertyType != 'Any') {
        if (_selectedPropertyType == 'Owner' && p.sellerRole != SellerRole.owner) return false;
        if (_selectedPropertyType == 'Builder' && p.sellerRole != SellerRole.builder) return false;
      }
      if (_selectedCity != 'All Cities' && p.city != _selectedCity) return false;
      if (_searchQuery.isNotEmpty) {
        if (!p.title.toLowerCase().contains(_searchQuery.toLowerCase()) &&
            !p.location.toLowerCase().contains(_searchQuery.toLowerCase())) {
          return false;
        }
      }
      return true;
    }).toList();
  }

  void switchRole(UserRole newRole) { _activeRole = newRole; notifyListeners(); }
  void setCityFilter(String city) { _selectedCity = city; notifyListeners(); }
  void setSearchQuery(String q) { _searchQuery = q; notifyListeners(); }
  void setBudgetRange(double min, double max) { _minBudget = min; _maxBudget = max; notifyListeners(); }
  void setBhkFilter(String bhk) { _selectedBhkFilter = bhk; notifyListeners(); }
  void setPropertyTypeFilter(String type) { _selectedPropertyType = type; notifyListeners(); }
  void login() { _isAuthenticated = true; notifyListeners(); }
  void logout() { _isAuthenticated = false; _activeRole = UserRole.buyer; notifyListeners(); }

  Future<void> addProperty(PropertyListing property) async {
    await _firebaseService.saveProperty(property);
    // Stream will auto-update the list
  }

  Future<void> updateProperty(PropertyListing property) async {
    await _firebaseService.saveProperty(property);
  }

  Future<void> deleteProperty(String id) async {
    await _firebaseService.deleteProperty(id);
  }

  List<PropertyListing> getPropertiesByRole(SellerRole role) {
    return _properties.where((p) => p.sellerRole == role).toList();
  }
}
