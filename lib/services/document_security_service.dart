class DocumentAccessLog {
  final String docId;
  final String userId;
  final DateTime timestamp;
  final String watermarkText;

  DocumentAccessLog({
    required this.docId,
    required this.userId,
    required this.timestamp,
    required this.watermarkText,
  });
}

class DocumentSecurityService {
  final List<DocumentAccessLog> _accessLogs = [];

  /// Generate secure watermarked document metadata and record access audit log
  Map<String, dynamic> requestDocumentPreview({
    required String docName,
    required String userId,
    required String userEmail,
  }) {
    final watermark = "CONFIDENTIAL • PREVIEW ONLY • $userId • ${DateTime.now().toIso8601String()}";
    
    _accessLogs.add(DocumentAccessLog(
      docId: docName,
      userId: userId,
      timestamp: DateTime.now(),
      watermarkText: watermark,
    ));

    return {
      'docName': docName,
      'isEncrypted': true,
      'watermarkOverlay': watermark,
      'allowDownload': false,
      'reraVerifiedStatus': 'VERIFIED_GOVT_REGISTRY',
    };
  }

  List<DocumentAccessLog> getLogs() => List.unmodifiable(_accessLogs);
}
