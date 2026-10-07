import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_provider.dart';
import '../models/user_role.dart';
import '../services/telephony_masking_service.dart';
import 'document_vault_screen.dart';

class HomeMarketplaceScreen extends StatefulWidget {
  const HomeMarketplaceScreen({super.key});

  @override
  State<HomeMarketplaceScreen> createState() => _HomeMarketplaceScreenState();
}

class _HomeMarketplaceScreenState extends State<HomeMarketplaceScreen> {
  final TextEditingController _searchController = TextEditingController();
  final TelephonyMaskingService _telephonyService = TelephonyMaskingService();

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AppProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Row(
          children: [
            Icon(Icons.auto_awesome, color: Color(0xFF6366F1)),
            SizedBox(width: 8),
            Text('EstatoCopilot AI', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
          ],
        ),
        actions: [
          // Role Switching Popup Menu
          PopupMenuButton<UserRole>(
            initialValue: provider.activeRole,
            onSelected: (UserRole role) {
              provider.switchRole(role);
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<UserRole>>[
              const PopupMenuItem<UserRole>(
                value: UserRole.buyer,
                child: Row(
                  children: [
                    Icon(Icons.person, color: Colors.indigo),
                    SizedBox(width: 8),
                    Text('Switch to Buyer'),
                  ],
                ),
              ),
              const PopupMenuItem<UserRole>(
                value: UserRole.owner,
                child: Row(
                  children: [
                    Icon(Icons.home, color: Colors.green),
                    SizedBox(width: 8),
                    Text('Switch to Owner'),
                  ],
                ),
              ),
              const PopupMenuItem<UserRole>(
                value: UserRole.builder,
                child: Row(
                  children: [
                    Icon(Icons.business, color: Colors.amber),
                    SizedBox(width: 8),
                    Text('Switch to Builder'),
                  ],
                ),
              ),
            ],
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              margin: const EdgeInsets.only(right: 12),
              decoration: BoxDecoration(
                color: const Color(0xFF1E293B),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: const Color(0xFF334155)),
              ),
              child: Row(
                children: [
                  Icon(
                    provider.activeRole == UserRole.buyer
                        ? Icons.person
                        : provider.activeRole == UserRole.owner
                            ? Icons.home
                            : Icons.business,
                    size: 16,
                    color: const Color(0xFF818CF8),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    provider.activeRole.name.toUpperCase(),
                    style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search Bar
            TextField(
              controller: _searchController,
              onChanged: (q) => provider.setSearchQuery(q),
              decoration: InputDecoration(
                hintText: 'Search with AI: "3BHK under 1.5 Cr in Whitefield"...',
                prefixIcon: const Icon(Icons.search, color: Color(0xFF818CF8)),
                filled: true,
                fillColor: const Color(0xFF0F172A),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: const BorderSide(color: Color(0xFF334155)),
                ),
              ),
            ),
            const SizedBox(height: 12),

            // Filters
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildFilterDropdown(
                    value: provider.selectedCity,
                    items: ['All Cities', 'Pune', 'Bangalore', 'Mumbai', 'Delhi'],
                    onChanged: (val) => provider.setCityFilter(val!),
                  ),
                  const SizedBox(width: 8),
                  _buildFilterDropdown(
                    value: provider.selectedBhkFilter,
                    items: ['Any', '1BHK', '2BHK', '3BHK', '4BHK+'],
                    onChanged: (val) => provider.setBhkFilter(val!),
                  ),
                  const SizedBox(width: 8),
                  _buildFilterDropdown(
                    value: provider.selectedPropertyType,
                    items: ['Any', 'Owner', 'Builder'],
                    onChanged: (val) => provider.setPropertyTypeFilter(val!),
                  ),
                  const SizedBox(width: 8),
                  ActionChip(
                    label: const Text('Budget', style: TextStyle(color: Colors.white)),
                    backgroundColor: const Color(0xFF1E293B),
                    side: const BorderSide(color: Color(0xFF334155)),
                    onPressed: () {
                      _showBudgetDialog(context, provider);
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Banner Flash Ads
            Builder(
              builder: (context) {
                final flashAds = provider.properties.where((p) => p.isFlashAd).toList();
                if (flashAds.isEmpty) return const SizedBox.shrink();
                
                final flashAd = flashAds.first;
                return Container(
                  padding: const EdgeInsets.all(16),
                  margin: const EdgeInsets.only(bottom: 20),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF1E1B4B), Color(0xFF0F172A)],
                    ),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: const Color(0xFF6366F1).withOpacity(0.4)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.amber,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: const Text('FLASH DEAL', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 10)),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              (flashAd.discountTag != null && flashAd.discountTag!.isNotEmpty) ? flashAd.discountTag! : 'Featured Property',
                              style: const TextStyle(color: Colors.white, fontSize: 12),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(flashAd.title, style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                      Text('${flashAd.location}, ${flashAd.city} • ₹${(flashAd.price / 10000000).toStringAsFixed(2)} Cr', style: const TextStyle(color: Color(0xFF94A3B8), fontSize: 13)),
                    ],
                  ),
                );
              }
            ),

            // Listing Grid Title
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Marketplace Listings', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
                Text('${provider.filteredProperties.length} Results', style: const TextStyle(color: Color(0xFF94A3B8), fontSize: 12)),
              ],
            ),
            const SizedBox(height: 12),

            // Property Cards List
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: provider.filteredProperties.length,
              separatorBuilder: (_, __) => const SizedBox(height: 16),
              itemBuilder: (context, index) {
                final prop = provider.filteredProperties[index];
                return Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xFF0F172A),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: const Color(0xFF1E293B)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.network(
                          prop.imageUrls[0],
                          height: 180,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('₹${(prop.price / 10000000).toStringAsFixed(2)} Cr', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w800, color: Colors.white)),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: const Color(0xFF6366F1).withOpacity(0.2),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text('${prop.suitabilityScore}% Match', style: const TextStyle(color: Color(0xFF818CF8), fontSize: 12, fontWeight: FontWeight.bold)),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(prop.title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.white)),
                      Text(prop.location, style: const TextStyle(color: Color(0xFF94A3B8), fontSize: 12)),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton.icon(
                              onPressed: () async {
                                final session = await _telephonyService.initiateMaskedCall(
                                  propertyId: prop.id,
                                  buyerPhone: '+91 99000 11223',
                                  sellerPhone: prop.sellerContact,
                                );
                                if (context.mounted) {
                                  showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      title: const Text('Masked Proxy Call'),
                                      content: Text('Proxy Line: ${session.proxyVirtualNumber}\nExpires in 30 minutes. Real numbers masked.'),
                                      actions: [
                                        TextButton(
                                          onPressed: () => Navigator.pop(context),
                                          child: const Text('OK'),
                                        ),
                                      ],
                                    ),
                                  );
                                }
                              },
                              icon: const Icon(Icons.call, size: 16),
                              label: const Text('Masked Call'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green,
                                foregroundColor: Colors.white,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: OutlinedButton.icon(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DocumentVaultScreen(property: prop),
                                  ),
                                );
                              },
                              icon: const Icon(Icons.security, size: 16),
                              label: const Text('Legal Docs'),
                              style: OutlinedButton.styleFrom(
                                foregroundColor: Colors.amber,
                                side: const BorderSide(color: Colors.amber),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterDropdown({
    required String value,
    required List<String> items,
    required void Function(String?) onChanged,
  }) {
    return Container(
      height: 36,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: const Color(0xFF1E293B),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF334155)),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          dropdownColor: const Color(0xFF1E293B),
          icon: const Icon(Icons.arrow_drop_down, color: Color(0xFF94A3B8)),
          style: const TextStyle(color: Colors.white, fontSize: 13),
          items: items.map((item) => DropdownMenuItem(value: item, child: Text(item))).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }

  void _showBudgetDialog(BuildContext context, AppProvider provider) {
    double min = provider.minBudget;
    double max = provider.maxBudget;
    
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              backgroundColor: const Color(0xFF0F172A),
              title: const Text('Budget Range', style: TextStyle(color: Colors.white)),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('₹${(min / 100000).toStringAsFixed(0)}L - ₹${(max / 100000).toStringAsFixed(0)}L', style: const TextStyle(color: Color(0xFF6366F1), fontWeight: FontWeight.bold)),
                  RangeSlider(
                    values: RangeValues(min, max),
                    min: 0,
                    max: 50000000,
                    divisions: 100,
                    activeColor: const Color(0xFF6366F1),
                    onChanged: (RangeValues values) {
                      setState(() {
                        min = values.start;
                        max = values.end;
                      });
                    },
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancel', style: TextStyle(color: Color(0xFF94A3B8))),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF6366F1)),
                  onPressed: () {
                    provider.setBudgetRange(min, max);
                    Navigator.pop(context);
                  },
                  child: const Text('Apply', style: TextStyle(color: Colors.white)),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
