import 'dart:async';
import 'dart:math';
import '../models/call_log.dart';

class MaskedCallSession {
  final String sessionId;
  final String propertyId;
  final String buyerPhone;
  final String sellerPhone;
  final String proxyVirtualNumber;
  final DateTime expiresAt;
  bool isActive;

  MaskedCallSession({
    required this.sessionId,
    required this.propertyId,
    required this.buyerPhone,
    required this.sellerPhone,
    required this.proxyVirtualNumber,
    required this.expiresAt,
    this.isActive = true,
  });
}

class TelephonyMaskingService {
  final Map<String, MaskedCallSession> _activeSessions = {};
  final List<CallLog> _callLogs = [];
  Timer? _cleanupTimer;

  TelephonyMaskingService() {
    _startCleanupRoutine();
  }

  void _startCleanupRoutine() {
    _cleanupTimer = Timer.periodic(const Duration(minutes: 1), (_) {
      final now = DateTime.now();
      for (var session in _activeSessions.values) {
        if (session.isActive && now.isAfter(session.expiresAt)) {
          session.isActive = false;
          _updateCallLogStatus(session.sessionId, CallStatus.expired);
        }
      }
    });
  }

  List<CallLog> get callLogs => _callLogs;

  /// Initiate Uber-style call masking with temporary proxy number
  Future<MaskedCallSession> initiateMaskedCall({
    required String propertyId,
    required String buyerPhone,
    required String sellerPhone,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    final randomNum = 1000 + Random().nextInt(8999);
    final proxyNumber = "+1 (888) 555-$randomNum";
    final sessionId = "CALL_${DateTime.now().millisecondsSinceEpoch}";

    final session = MaskedCallSession(
      sessionId: sessionId,
      propertyId: propertyId,
      buyerPhone: buyerPhone,
      sellerPhone: sellerPhone,
      proxyVirtualNumber: proxyNumber,
      expiresAt: DateTime.now().add(const Duration(minutes: 30)),
    );

    _activeSessions[sessionId] = session;
    
    // Log the initial attempt
    _callLogs.add(CallLog(
      id: "LOG_${DateTime.now().millisecondsSinceEpoch}",
      sessionId: sessionId,
      propertyId: propertyId,
      callerRole: 'Buyer',
      receiverRole: 'Seller',
      timestamp: DateTime.now(),
      status: CallStatus.initiated,
    ));

    // Simulate Webhook lifecycle events from Twilio/Exotel
    _simulateWebhookLifecycle(sessionId);

    return session;
  }

  void _updateCallLogStatus(String sessionId, CallStatus status, {int duration = 0}) {
    final logIndex = _callLogs.indexWhere((log) => log.sessionId == sessionId);
    if (logIndex != -1) {
      _callLogs[logIndex].status = status;
      if (duration > 0) {
        // Create a new log entry or update existing if needed, but since it's a mock we'll just mutate
      }
    }
  }

  void _simulateWebhookLifecycle(String sessionId) {
    Future.delayed(const Duration(seconds: 3), () {
      _updateCallLogStatus(sessionId, CallStatus.ringing);
    });
    Future.delayed(const Duration(seconds: 8), () {
      _updateCallLogStatus(sessionId, CallStatus.inProgress);
    });
    Future.delayed(const Duration(seconds: 25), () {
      _updateCallLogStatus(sessionId, CallStatus.completed, duration: 17);
      // Mark session as inactive after call completes to free up the proxy number immediately
      if (_activeSessions.containsKey(sessionId)) {
        _activeSessions[sessionId]!.isActive = false;
      }
    });
  }

  void dispose() {
    _cleanupTimer?.cancel();
  }
}
