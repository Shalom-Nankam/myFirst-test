class LoginResponse {
  bool success;
  String message;
  LoginResponse({
    required this.success,
    required this.message,
  });

  Map<String, dynamic> toMap() {
    return {
      'success': success,
      'message': message,
    };
  }

  factory LoginResponse.fromMap(Map<String, dynamic> map) {
    return LoginResponse(
      success: map['success'] ?? false,
      message: map['message'] ?? '',
    );
  }

  @override
  String toString() => 'LoginResponse(success: $success, message: $message)';
}
