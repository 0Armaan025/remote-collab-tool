import 'package:flutter/material.dart';
import 'package:remote_collab_tool/features/auth/models/poll.dart';
import 'package:remote_collab_tool/features/auth/repositories/poll_repository.dart';

class PollController {
  final PollRepository _pollRepository = PollRepository();

  void createPoll(BuildContext context, PollModel poll) {
    _pollRepository.createPoll(context, poll);
  }
}
