import 'package:flutter/material.dart';
import 'package:remote_collab_tool/features/poll_screen/poll_list_screen.dart';

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
