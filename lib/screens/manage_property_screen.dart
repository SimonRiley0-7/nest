import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import '../providers/app_provider.dart';
import '../models/property.dart';
import '../models/user_role.dart';
import '../services/firebase_property_service.dart';

class ManagePropertyScreen extends StatefulWidget {
  final PropertyListing? property;
  const ManagePropertyScreen({super.key, this.property});

  @override
  State<ManagePropertyScreen> createState() => _ManagePropertyScreenState();
}

class _ManagePropertyScreenState extends State<ManagePropertyScreen> {
  final _formKey = GlobalKey<FormState>();
  final _firebaseService = FirebasePropertyService();
  final _picker = ImagePicker();

  late String _title;
  late String _location;
  late String _city;
  late double _price;
  late String _bhk;
  late String _description;
  late double _areaSqFt;
  late bool _isFlashAd;
  late String _discountTag;

  List<String> _existingImageUrls = []; // Already uploaded URLs
  List<File> _newImageFiles = [];       // Newly picked local files
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    final p = widget.property;
    if (p != null) {
      _title = p.title;
      _location = p.location;
      _city = p.city;
      _price = p.price;
      _bhk = p.bhk;
      _description = p.description;
      _areaSqFt = p.areaSqFt;
      _existingImageUrls = List.from(p.imageUrls);
      _isFlashAd = p.isFlashAd;
      _discountTag = p.discountTag ?? '';
    } else {
      _title = '';
      _location = '';
      _city = 'Pune';
      _price = 0.0;
      _bhk = '2BHK';
      _description = '';
      _areaSqFt = 0.0;
      _isFlashAd = false;
      _discountTag = '';
    }
  }

  Future<void> _pickImage() async {
    final picked = await _picker.pickMultiImage(imageQuality: 70);
    if (picked.isNotEmpty) {
      setState(() {
        _newImageFiles.addAll(picked.map((x) => File(x.path)));
      });
    }
  }

  Future<void> _saveProperty() async {
    if (!_formKey.currentState!.validate()) return;
    _formKey.currentState!.save();
    setState(() => _isLoading = true);

    try {
      final provider = Provider.of<AppProvider>(context, listen: false);
      final isOwner = provider.activeRole == UserRole.owner;
      final propertyId = widget.property?.id ?? DateTime.now().millisecondsSinceEpoch.toString();

      // Upload new images to Firebase Storage
      final uploadedUrls = <String>[];
      for (final file in _newImageFiles) {
        final url = await _firebaseService.uploadImage(file, propertyId);
        uploadedUrls.add(url);
      }

      final allImageUrls = [..._existingImageUrls, ...uploadedUrls];
      if (allImageUrls.isEmpty) {
        allImageUrls.add('https://images.unsplash.com/photo-1564013799919-ab600027ffc6?w=800');
      }

      final newProperty = PropertyListing(
        id: propertyId,
        title: _title,
        sellerRole: isOwner ? SellerRole.owner : SellerRole.builder,
        sellerName: 'Current User',
        sellerContact: '+91 00000 00000',
        location: _location,
        city: _city,
        price: _price,
        areaSqFt: _areaSqFt,
        bhk: _bhk,
        description: _description,
        imageUrls: allImageUrls,
        estimatedValuation: _price * 1.05,
        projected5YrAppreciation: 15.0,
        suitabilityScore: 85.0,
        isFlashAd: _isFlashAd,
        discountTag: _discountTag.isEmpty ? null : _discountTag,
        viewCount: widget.property?.viewCount ?? 0,
        leadCount: widget.property?.leadCount ?? 0,
        geologicalRisks: widget.property?.geologicalRisks ?? {},
        legalDocs: widget.property?.legalDocs ?? [],
        createdAt: widget.property?.createdAt ?? DateTime.now(),
      );

      if (widget.property == null) {
        await provider.addProperty(newProperty);
      } else {
        await provider.updateProperty(newProperty);
      }

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(widget.property == null ? '✅ Listing created!' : '✅ Changes saved!'),
            backgroundColor: const Color(0xFF10B981),
          ),
        );
        Navigator.pop(context);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('❌ Failed to save: $e'),
            backgroundColor: Colors.redAccent,
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      appBar: AppBar(
        title: Text(widget.property == null ? 'Add Property' : 'Edit Property',
            style: const TextStyle(color: Colors.white)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          if (_isLoading)
            const Padding(
              padding: EdgeInsets.all(16),
              child: SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2)),
            )
          else
            IconButton(
              icon: const Icon(Icons.check, color: Color(0xFF6366F1)),
              onPressed: _saveProperty,
            ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            _buildField(label: 'Property Title', init: _title, onSaved: (v) => _title = v!),
            _buildField(label: 'Exact Location (e.g. Koregaon Park)', init: _location, onSaved: (v) => _location = v!),
            _buildField(
              label: 'Price (₹)',
              init: _price == 0.0 ? '' : _price.toStringAsFixed(0),
              keyboard: TextInputType.number,
              onSaved: (v) => _price = double.tryParse(v!) ?? 0.0,
            ),
            _buildField(
              label: 'Area (Sq Ft)',
              init: _areaSqFt == 0.0 ? '' : _areaSqFt.toStringAsFixed(0),
              keyboard: TextInputType.number,
              onSaved: (v) => _areaSqFt = double.tryParse(v!) ?? 0.0,
            ),
            _buildDropdown(
              value: _bhk,
              label: 'Configuration',
              items: ['1BHK', '2BHK', '3BHK', '4BHK+'],
              onChanged: (v) => setState(() => _bhk = v!),
            ),
            _buildDropdown(
              value: _city,
              label: 'City',
              items: ['Pune', 'Bangalore', 'Mumbai', 'Delhi'],
              onChanged: (v) => setState(() => _city = v!),
            ),
            _buildField(label: 'Description', init: _description, maxLines: 4, onSaved: (v) => _description = v!),
            const SizedBox(height: 8),

            // ── Photos Section ──────────────────────────────────────────
            const Text('Photos', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15)),
            const SizedBox(height: 8),
            GestureDetector(
              onTap: _pickImage,
              child: Container(
                height: 100,
                decoration: BoxDecoration(
                  color: const Color(0xFF1E293B),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFF6366F1), style: BorderStyle.solid),
                ),
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.add_photo_alternate_outlined, size: 36, color: Color(0xFF6366F1)),
                    SizedBox(height: 6),
                    Text('Tap to pick photos from gallery', style: TextStyle(color: Color(0xFF94A3B8), fontSize: 13)),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),

            // Show existing + new images
            if (_existingImageUrls.isNotEmpty || _newImageFiles.isNotEmpty)
              SizedBox(
                height: 90,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    ..._existingImageUrls.asMap().entries.map((e) => _buildExistingImageTile(e.key, e.value)),
                    ..._newImageFiles.asMap().entries.map((e) => _buildNewImageTile(e.key, e.value)),
                  ],
                ),
              ),

            const SizedBox(height: 16),

            // ── Flash Ad Toggle ─────────────────────────────────────────
            SwitchListTile(
              title: const Text('Promote as Flash Ad', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              subtitle: const Text('Featured at the top of marketplace', style: TextStyle(color: Color(0xFF94A3B8))),
              value: _isFlashAd,
              activeColor: const Color(0xFFF59E0B),
              tileColor: const Color(0xFF1E293B),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              onChanged: (val) => setState(() { _isFlashAd = val; if (!val) _discountTag = ''; }),
            ),
            if (_isFlashAd) ...[
              const SizedBox(height: 12),
              _buildField(
                label: 'Discount / Deal Tag (e.g. 5% Off)',
                init: _discountTag,
                required: false,
                onSaved: (v) => _discountTag = v ?? '',
              ),
            ],

            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: _isLoading ? null : _saveProperty,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF6366F1),
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: _isLoading
                  ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                  : Text(
                      widget.property == null ? 'Create Listing' : 'Save Changes',
                      style: const TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),
                    ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildExistingImageTile(int index, String url) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      width: 80,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        image: DecorationImage(image: NetworkImage(url), fit: BoxFit.cover),
      ),
      child: Align(
        alignment: Alignment.topRight,
        child: GestureDetector(
          onTap: () => setState(() => _existingImageUrls.removeAt(index)),
          child: Container(
            margin: const EdgeInsets.all(2),
            decoration: const BoxDecoration(color: Colors.black54, shape: BoxShape.circle),
            child: const Icon(Icons.close, color: Colors.white, size: 16),
          ),
        ),
      ),
    );
  }

  Widget _buildNewImageTile(int index, File file) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      width: 80,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        image: DecorationImage(image: FileImage(file), fit: BoxFit.cover),
      ),
      child: Align(
        alignment: Alignment.topRight,
        child: GestureDetector(
          onTap: () => setState(() => _newImageFiles.removeAt(index)),
          child: Container(
            margin: const EdgeInsets.all(2),
            decoration: const BoxDecoration(color: Colors.black54, shape: BoxShape.circle),
            child: const Icon(Icons.close, color: Colors.white, size: 16),
          ),
        ),
      ),
    );
  }

  Widget _buildField({
    required String label,
    required String init,
    int maxLines = 1,
    TextInputType keyboard = TextInputType.text,
    bool required = true,
    required void Function(String?) onSaved,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14.0),
      child: TextFormField(
        initialValue: init,
        style: const TextStyle(color: Colors.white),
        maxLines: maxLines,
        keyboardType: keyboard,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: Color(0xFF94A3B8)),
          filled: true,
          fillColor: const Color(0xFF1E293B),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
        ),
        validator: required ? (v) => (v == null || v.isEmpty) ? '$label is required' : null : null,
        onSaved: onSaved,
      ),
    );
  }

  Widget _buildDropdown({
    required String value,
    required String label,
    required List<String> items,
    required void Function(String?) onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14.0),
      child: DropdownButtonFormField<String>(
        value: value,
        dropdownColor: const Color(0xFF1E293B),
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: Color(0xFF94A3B8)),
          filled: true,
          fillColor: const Color(0xFF1E293B),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
        ),
        items: items.map((item) => DropdownMenuItem(value: item, child: Text(item))).toList(),
        onChanged: onChanged,
      ),
    );
  }
}
