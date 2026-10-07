import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_provider.dart';
import '../models/user_role.dart';
import '../models/property.dart';
import 'manage_property_screen.dart';

class PortfolioScreen extends StatelessWidget {
  const PortfolioScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AppProvider>(context);
    final isBuyer = provider.activeRole == UserRole.buyer;
    final sellerRole = provider.activeRole == UserRole.owner ? SellerRole.owner : SellerRole.builder;
    
    // Only fetch for owners and builders
    final myProperties = isBuyer ? <PropertyListing>[] : provider.getPropertiesByRole(sellerRole);

    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          isBuyer ? 'Saved Properties' : 'My Listings & Analytics',
          style: const TextStyle(color: Colors.white),
        ),
      ),
      floatingActionButton: isBuyer 
          ? null 
          : FloatingActionButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ManagePropertyScreen()),
                );
              },
              backgroundColor: const Color(0xFFF59E0B),
              child: const Icon(Icons.add, color: Colors.white),
            ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (isBuyer) ...[
              const Text('Your Shortlisted Properties', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
              const SizedBox(height: 16),
              _buildEmptyState('No saved properties yet.', Icons.favorite_border),
            ] else ...[
              const Text('Dashboard Overview', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
              const SizedBox(height: 16),
              Row(
                children: [
                  _buildStatCard('Total Views', '${myProperties.fold<int>(0, (sum, p) => sum + p.viewCount)}', Icons.visibility, Colors.blue),
                  const SizedBox(width: 12),
                  _buildStatCard('Active Leads', '${myProperties.fold<int>(0, (sum, p) => sum + p.leadCount)}', Icons.people, Colors.green),
                ],
              ),
              const SizedBox(height: 24),
              const Text('Active Listings', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
              const SizedBox(height: 16),
              if (myProperties.isEmpty)
                _buildEmptyState('You have no active listings. Tap + to add one.', Icons.list_alt)
              else
                Expanded(
                  child: ListView.builder(
                    itemCount: myProperties.length,
                    itemBuilder: (context, index) {
                      final property = myProperties[index];
                      return Card(
                        color: const Color(0xFF1E293B),
                        margin: const EdgeInsets.only(bottom: 12),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        child: ListTile(
                          contentPadding: const EdgeInsets.all(12),
                          leading: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.network(
                              property.imageUrls.first,
                              width: 60,
                              height: 60,
                              fit: BoxFit.cover,
                            ),
                          ),
                          title: Text(property.title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                          subtitle: Text('₹${property.price} • ${property.bhk}', style: const TextStyle(color: Color(0xFF94A3B8))),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.edit, color: Color(0xFF6366F1)),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => ManagePropertyScreen(property: property)),
                                  );
                                },
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete, color: Colors.redAccent),
                                onPressed: () {
                                  provider.deleteProperty(property.id);
                                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Property deleted')));
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFF1E293B),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFF334155)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: color, size: 28),
            const SizedBox(height: 12),
            Text(title, style: const TextStyle(color: Color(0xFF94A3B8), fontSize: 13)),
            const SizedBox(height: 4),
            Text(value, style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState(String message, IconData icon) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 48),
      decoration: BoxDecoration(
        color: const Color(0xFF0F172A),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF1E293B)),
      ),
      child: Column(
        children: [
          Icon(icon, size: 48, color: const Color(0xFF334155)),
          const SizedBox(height: 16),
          Text(message, style: const TextStyle(color: Color(0xFF94A3B8))),
        ],
      ),
    );
  }
}
