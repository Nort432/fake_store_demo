class LoginTokensDto {
  const LoginTokensDto({required this.accessToken, required this.refreshToken});

  final String accessToken;
  final String refreshToken;

  factory LoginTokensDto.fromJson(Map<String, dynamic> json) {
    return LoginTokensDto(
      accessToken: json['access_token'] as String? ?? '',
      refreshToken: json['refresh_token'] as String? ?? '',
    );
  }
}
