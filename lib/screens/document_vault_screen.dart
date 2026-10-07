import 'package:flutter/material.dart';
import '../models/property.dart';
import '../services/document_security_service.dart';

class DocumentVaultScreen extends StatefulWidget {
  final PropertyListing property;

  const DocumentVaultScreen({super.key, required this.property});

  @override
  State<DocumentVaultScreen> createState() => _DocumentVaultScreenState();
}

class _DocumentVaultScreenState extends State<DocumentVaultScreen> {
  final DocumentSecurityService _docService = DocumentSecurityService();

  void _openSecureViewer(String docName) {
    // In a real app, userId/email would come from AuthProvider
    final docInfo = _docService.requestDocumentPreview(
      docName: docName,
      userId: 'USER_8891',
      userEmail: 'buyer@example.com',
    );

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SecureDocumentViewer(docInfo: docInfo),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      appBar: AppBar(
        title: const Text('Secure Document Vault'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(Icons.shield, color: Colors.green),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Documents are encrypted and logged upon access. Downloads are restricted.',
                    style: TextStyle(color: Colors.green, fontSize: 13),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Text(
              widget.property.title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            const SizedBox(height: 16),
            if (widget.property.legalDocs.isEmpty)
              const Center(child: Text('No legal documents uploaded yet.', style: TextStyle(color: Color(0xFF94A3B8))))
            else
              Expanded(
                child: ListView.builder(
                  itemCount: widget.property.legalDocs.length,
                  itemBuilder: (context, index) {
                    final doc = widget.property.legalDocs[index];
                    return Card(
                      color: const Color(0xFF1E293B),
                      margin: const EdgeInsets.only(bottom: 12),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      child: ListTile(
                        leading: const Icon(Icons.picture_as_pdf, color: Colors.redAccent),
                        title: Text(doc, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                        subtitle: const Text('Verified by Govt Registry API', style: TextStyle(color: Color(0xFF94A3B8), fontSize: 12)),
                        trailing: ElevatedButton(
                          onPressed: () => _openSecureViewer(doc),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF6366F1),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                          ),
                          child: const Text('View Securely', style: TextStyle(color: Colors.white)),
                        ),
                      ),
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class SecureDocumentViewer extends StatelessWidget {
  final Map<String, dynamic> docInfo;

  const SecureDocumentViewer({super.key, required this.docInfo});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(docInfo['docName']),
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Access logged securely. Download disabled.')),
              );
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          // Simulated Document Image
          Center(
            child: Container(
              margin: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Padding(
                padding: EdgeInsets.all(32.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.account_balance, size: 64, color: Colors.grey),
                    SizedBox(height: 24),
                    Text('OFFICIAL LEGAL DOCUMENT', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black)),
                    SizedBox(height: 16),
                    Text(
                      'This is a simulated view of a confidential legal document (e.g., Title Deed, 7/12 extract). '
                      'The actual file is encrypted in Firebase Storage and accessed via a temporary signed URL.',
                      style: TextStyle(color: Colors.black54, fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 64),
                  ],
                ),
              ),
            ),
          ),
          // Watermark Overlay
          IgnorePointer(
            child: Container(
              color: Colors.transparent,
              child: Center(
                child: Transform.rotate(
                  angle: -0.5,
                  child: Text(
                    docInfo['watermarkOverlay'],
                    style: TextStyle(
                      color: Colors.red.withOpacity(0.3),
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
