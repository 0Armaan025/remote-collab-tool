// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserModal {
  final String uid;
  final String email;
  final String username;
  final String profilePictureUrl;
  final String points;
  UserModal({
    required this.uid,
    required this.email,
    required this.username,
    required this.profilePictureUrl,
    required this.points,
  });

  UserModal copyWith({
    String? uid,
    String? email,
    String? username,
    String? profilePictureUrl,
    String? points,
  }) {
    return UserModal(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      username: username ?? this.username,
      profilePictureUrl: profilePictureUrl ?? this.profilePictureUrl,
      points: points ?? this.points,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'email': email,
      'username': username,
      'profilePictureUrl': profilePictureUrl,
      'points': points,
    };
  }

  factory UserModal.fromMap(Map<String, dynamic> map) {
    return UserModal(
      uid: map['uid'] as String,
      email: map['email'] as String,
      username: map['username'] as String,
      profilePictureUrl: map['profilePictureUrl'] as String,
      points: map['points'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModal.fromJson(String source) =>
      UserModal.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserModal(uid: $uid, email: $email, username: $username, profilePictureUrl: $profilePictureUrl, points: $points)';
  }

  @override
  bool operator ==(covariant UserModal other) {
    if (identical(this, other)) return true;

    return other.uid == uid &&
        other.email == email &&
        other.username == username &&
        other.profilePictureUrl == profilePictureUrl &&
        other.points == points;
  }

  @override
  int get hashCode {
    return uid.hashCode ^
        email.hashCode ^
        username.hashCode ^
        profilePictureUrl.hashCode ^
        points.hashCode;
  }
}
