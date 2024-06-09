import 'package:flutter/material.dart';
import 'package:remote_collab_tool/common/appbar/appbar.dart';
import 'package:remote_collab_tool/common/navbar/navbar.dart';
import 'package:remote_collab_tool/theme/pallete.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cool Poll App',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: PollListScreen(),
    );
  }
}

class PollListScreen extends StatefulWidget {
  @override
  _PollListScreenState createState() => _PollListScreenState();
}

class _PollListScreenState extends State<PollListScreen> {
  List<Poll> polls = [
    Poll(
        question: "Your favorite programming language?",
        options: ["Dart", "Python", "JavaScript"],
        votes: [50, 30, 20],
        hasVoted: false),
    // More polls can be added here
  ];

  void _addPoll(Poll poll) {
    setState(() {
      polls.add(poll);
    });
  }

  void _vote(Poll poll, int optionIndex) {
    setState(() {
      poll.votes[optionIndex]++;
      poll.hasVoted = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Pallete.bgColor,
      appBar: createAppBar(),
      bottomNavigationBar: MyBottomNavigationBar(),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: ListView(
          children:
              polls.map((poll) => PollCard(poll: poll, onVote: _vote)).toList(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (BuildContext context) {
              return PollCreationSheet(onPollCreated: _addPoll);
            },
          );
        },
        child: Icon(Icons.add),
        backgroundColor: Pallete.buttonColor,
      ),
    );
  }
}

class Poll {
  String question;
  List<String> options;
  List<int> votes;
  bool hasVoted;

  Poll(
      {required this.question,
      required this.options,
      required this.votes,
      this.hasVoted = false});
}

class PollCard extends StatefulWidget {
  final Poll poll;
  final void Function(Poll, int) onVote;

  PollCard({required this.poll, required this.onVote});

  @override
  _PollCardState createState() => _PollCardState();
}

class _PollCardState extends State<PollCard> {
  int? selectedOptionIndex;

  void _handleVote(int index) {
    if (widget.poll.hasVoted) return;
    setState(() {
      selectedOptionIndex = index;
      widget.onVote(widget.poll, index);
    });
  }

  @override
  Widget build(BuildContext context) {
    int totalVotes = widget.poll.votes.reduce((a, b) => a + b);
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 5,
      margin: EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.poll.question,
                style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 18,
                    fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            ...widget.poll.options.asMap().entries.map((entry) {
              int idx = entry.key;
              String option = entry.value;
              double percentage = totalVotes == 0
                  ? 0
                  : (widget.poll.votes[idx] / totalVotes) * 100;
              bool isSelected = selectedOptionIndex == idx;

              return InkWell(
                onTap: widget.poll.hasVoted ? null : () => _handleVote(idx),
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 5),
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: isSelected ? Colors.white : Colors.grey[300],
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.black, width: 2),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(option,
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 16,
                              color: isSelected ? Colors.black : Colors.black)),
                      Text('${percentage.toStringAsFixed(1)}%',
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 16,
                              color: isSelected ? Colors.black : Colors.black)),
                    ],
                  ),
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}

class PollCreationSheet extends StatefulWidget {
  final Function(Poll) onPollCreated;

  PollCreationSheet({required this.onPollCreated});

  @override
  _PollCreationSheetState createState() => _PollCreationSheetState();
}

class _PollCreationSheetState extends State<PollCreationSheet> {
  final _formKey = GlobalKey<FormState>();
  String questionText = '';
  List<String> options = ['', ''];

  void _addOption() {
    setState(() {
      options.add('');
    });
  }

  void _removeOption(int index) {
    setState(() {
      options.removeAt(index);
    });
  }

  void _submitPoll() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      widget.onPollCreated(Poll(
          question: questionText,
          options: options,
          votes: List.filled(options.length, 0)));
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        left: 16,
        right: 16,
        top: 16,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Create Poll',
              style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 18,
                  fontWeight: FontWeight.bold)),
          Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(
                      labelText: 'Question',
                      border: OutlineInputBorder(),
                      labelStyle: TextStyle(fontFamily: 'Poppins')),
                  validator: (value) =>
                      value!.isEmpty ? 'Please enter a question' : null,
                  onSaved: (value) => questionText = value!,
                ),
                SizedBox(height: 16),
                ...options.asMap().entries.map((entry) {
                  int index = entry.key;
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Option ${index + 1}',
                        border: OutlineInputBorder(),
                        labelStyle: TextStyle(fontFamily: 'Poppins'),
                        suffixIcon: options.length > 2
                            ? IconButton(
                                icon: Icon(Icons.delete),
                                onPressed: () => _removeOption(index),
                              )
                            : null,
                      ),
                      validator: (value) =>
                          value!.isEmpty ? 'Please enter an option' : null,
                      onSaved: (value) => options[index] = value!,
                    ),
                  );
                }).toList(),
                SizedBox(height: 8),
                ElevatedButton(
                  onPressed: _addOption,
                  child: Text('Add Option',
                      style: TextStyle(fontFamily: 'Poppins')),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0)),
                  ),
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: _submitPoll,
                  child: Text('Create Poll',
                      style: TextStyle(fontFamily: 'Poppins')),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
