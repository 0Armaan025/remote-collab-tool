// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserModal {
  final String uid;
  final String email;
  final String username;
  final String profilePictureUrl;
  final String role;
  UserModal({
    required this.uid,
    required this.email,
    required this.username,
    required this.profilePictureUrl,
    required this.role,
  });

  UserModal copyWith({
    String? uid,
    String? email,
    String? username,
    String? profilePictureUrl,
    String? role,
  }) {
    return UserModal(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      username: username ?? this.username,
      profilePictureUrl: profilePictureUrl ?? this.profilePictureUrl,
      role: role ?? this.role,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'email': email,
      'username': username,
      'profilePictureUrl': profilePictureUrl,
      'role': role,
    };
  }

  factory UserModal.fromMap(Map<String, dynamic> map) {
    return UserModal(
      uid: map['uid'] as String,
      email: map['email'] as String,
      username: map['username'] as String,
      profilePictureUrl: map['profilePictureUrl'] as String,
      role: map['role'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModal.fromJson(String source) =>
      UserModal.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserModal(uid: $uid, email: $email, username: $username, profilePictureUrl: $profilePictureUrl, role: $role)';
  }

  @override
  bool operator ==(covariant UserModal other) {
    if (identical(this, other)) return true;

    return other.uid == uid &&
        other.email == email &&
        other.username == username &&
        other.profilePictureUrl == profilePictureUrl &&
        other.role == role;
  }

  @override
  int get hashCode {
    return uid.hashCode ^
        email.hashCode ^
        username.hashCode ^
        profilePictureUrl.hashCode ^
        role.hashCode;
  }
}
