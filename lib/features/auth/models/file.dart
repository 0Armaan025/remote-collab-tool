// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class FileModel {
  final String type;
  final String name;
  final String downloadUrl;
  final String companyName;
  final String uploadedByUid;
  FileModel({
    required this.type,
    required this.name,
    required this.downloadUrl,
    required this.companyName,
    required this.uploadedByUid,
  });

  FileModel copyWith({
    String? type,
    String? name,
    String? downloadUrl,
    String? companyName,
    String? uploadedByUid,
  }) {
    return FileModel(
      type: type ?? this.type,
      name: name ?? this.name,
      downloadUrl: downloadUrl ?? this.downloadUrl,
      companyName: companyName ?? this.companyName,
      uploadedByUid: uploadedByUid ?? this.uploadedByUid,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'type': type,
      'name': name,
      'downloadUrl': downloadUrl,
      'companyName': companyName,
      'uploadedByUid': uploadedByUid,
    };
  }

  factory FileModel.fromMap(Map<String, dynamic> map) {
    return FileModel(
      type: map['type'] as String,
      name: map['name'] as String,
      downloadUrl: map['downloadUrl'] as String,
      companyName: map['companyName'] as String,
      uploadedByUid: map['uploadedByUid'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory FileModel.fromJson(String source) =>
      FileModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'FileModel(type: $type, name: $name, downloadUrl: $downloadUrl, companyName: $companyName, uploadedByUid: $uploadedByUid)';
  }

  @override
  bool operator ==(covariant FileModel other) {
    if (identical(this, other)) return true;

    return other.type == type &&
        other.name == name &&
        other.downloadUrl == downloadUrl &&
        other.companyName == companyName &&
        other.uploadedByUid == uploadedByUid;
  }

  @override
  int get hashCode {
    return type.hashCode ^
        name.hashCode ^
        downloadUrl.hashCode ^
        companyName.hashCode ^
        uploadedByUid.hashCode;
  }
}
