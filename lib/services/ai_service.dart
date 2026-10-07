import 'dart:math';
import '../models/property.dart';

class AIService {
  /// Natural language property search simulator
  Future<List<PropertyListing>> searchPropertiesNaturalLanguage(
      String query, List<PropertyListing> allProperties) async {
    await Future.delayed(const Duration(milliseconds: 600));
    final q = query.toLowerCase();
    
    return allProperties.where((p) {
      if (q.contains('3bhk') || q.contains('3 bhk')) {
        if (p.bhk != '3BHK') return false;
      }
      if (q.contains('2bhk') || q.contains('2 bhk')) {
        if (p.bhk != '2BHK') return false;
      }
      if (q.contains('school') || q.contains('hospitals')) {
        return p.description.toLowerCase().contains('school') ||
            p.description.toLowerCase().contains('amenities');
      }
      return true;
    }).toList();
  }

  /// AI Property Valuation calculation & 5-year growth forecast
  Map<String, dynamic> calculateValuation(PropertyListing property) {
    final basePrice = property.price;
    final estimatedValuation = basePrice * 1.05; // AI premium estimation
    final annualGrowthRate = 0.08 + (Random().nextDouble() * 0.04);
    
    List<Map<String, dynamic>> forecast = [];
    final currentYear = DateTime.now().year;
    for (int i = 0; i <= 5; i++) {
      final yearVal = basePrice * pow(1 + annualGrowthRate, i);
      forecast.add({
        'year': currentYear + i,
        'value': double.parse(yearVal.toStringAsFixed(2)),
      });
    }

    return {
      'currentListingPrice': basePrice,
      'estimatedFairMarketValue': double.parse(estimatedValuation.toStringAsFixed(2)),
      'projected5YrAppreciationPct': double.parse((annualGrowthRate * 100 * 5).toStringAsFixed(1)),
      'forecastTimeline': forecast,
    };
  }

  /// Ask AI comparison between multiple properties
  Map<String, dynamic> compareProperties(
      List<PropertyListing> properties, String buyerPreferences) {
    if (properties.isEmpty) return {};

    final sorted = List<PropertyListing>.from(properties)
      ..sort((a, b) => b.suitabilityScore.compareTo(a.suitabilityScore));

    return {
      'topRecommendationId': sorted.first.id,
      'comparisonSummary':
          'Based on your preference "$buyerPreferences", ${sorted.first.title} offers the highest unified suitability score of ${sorted.first.suitabilityScore}%.',
      'suitabilityScores': {
        for (var p in properties) p.id: p.suitabilityScore
      },
    };
  }
}
