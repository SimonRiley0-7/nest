enum CallStatus { initiated, ringing, inProgress, completed, failed, expired }

class CallLog {
  final String id;
  final String sessionId;
  final String propertyId;
  final String callerRole; // Buyer
  final String receiverRole; // Owner/Builder
  final DateTime timestamp;
  CallStatus status;
  final int durationSeconds;

  CallLog({
    required this.id,
    required this.sessionId,
    required this.propertyId,
    required this.callerRole,
    required this.receiverRole,
    required this.timestamp,
    this.status = CallStatus.initiated,
    this.durationSeconds = 0,
  });
}
