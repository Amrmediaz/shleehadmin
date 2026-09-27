/// Result of a successful [AppOwnerLogin] call.
class OwnerSession {
  final String token;
  final String? expiresAt;
  final bool status;

  const OwnerSession({
    required this.token,
    required this.status,
    this.expiresAt,
  });

  factory OwnerSession.fromJson(Map<String, dynamic> json) {
    return OwnerSession(
      token: json['token']?.toString() ?? '',
      // Note: the API spells this field "expaire", not "expires".
      expiresAt: json['expaire']?.toString() ?? json['expire']?.toString(),
      status: json['status'] == true,
    );
  }
}
