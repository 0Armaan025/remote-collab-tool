// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class PollModel {
  final String id;
  final String question;
  final List<String> options;
  final List<int> votes;
  PollModel({
    required this.id,
    required this.question,
    required this.options,
    required this.votes,
  });

  PollModel copyWith({
    String? id,
    String? question,
    List<String>? options,
    List<int>? votes,
  }) {
    return PollModel(
      id: id ?? this.id,
      question: question ?? this.question,
      options: options ?? this.options,
      votes: votes ?? this.votes,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'question': question,
      'options': options,
      'votes': votes,
    };
  }

  factory PollModel.fromMap(Map<String, dynamic> map) {
    return PollModel(
        id: map['id'] as String,
        question: map['question'] as String,
        options: List<String>.from((map['options'] as List<String>)),
        votes: List<int>.from(
          (map['votes'] as List<int>),
        ));
  }

  String toJson() => json.encode(toMap());

  factory PollModel.fromJson(String source) =>
      PollModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'PollModel(id: $id, question: $question, options: $options, votes: $votes)';
  }

  @override
  bool operator ==(covariant PollModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.question == question &&
        listEquals(other.options, options) &&
        listEquals(other.votes, votes);
  }

  @override
  int get hashCode {
    return id.hashCode ^ question.hashCode ^ options.hashCode ^ votes.hashCode;
  }
}
