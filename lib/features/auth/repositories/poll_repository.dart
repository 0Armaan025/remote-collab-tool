import 'package:flutter/material.dart';
import 'package:remote_collab_tool/constants/constants.dart';
import 'package:remote_collab_tool/features/auth/models/poll.dart';

class PollRepository {
  void createPoll(BuildContext context, PollModel poll) {
    // Create a new poll
    firestore.collection('polls').doc(poll.id).set(poll.toMap()).then((value) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Poll created successfully'),
        ),
      );
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to create poll: $error'),
        ),
      );
    });
  }
}
