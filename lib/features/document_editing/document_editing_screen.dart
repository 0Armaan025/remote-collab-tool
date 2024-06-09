import 'dart:async';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:remote_collab_tool/common/appbar/appbar.dart';
import 'package:remote_collab_tool/common/navbar/navbar.dart';

class DocumentEditingScreen extends StatefulWidget {
  @override
  _DocumentEditingScreenState createState() => _DocumentEditingScreenState();
}

class _DocumentEditingScreenState extends State<DocumentEditingScreen> {
  final TextEditingController _controller = TextEditingController();
  late DocumentReference _documentRef;
  late StreamSubscription<DocumentSnapshot> _subscription;
  late TextStyle _selectedTextStyle = TextStyle();

  @override
  void initState() {
    super.initState();
    _documentRef = FirebaseFirestore.instance
        .collection('documents')
        .doc('sharedDocument');

    // Listen for real-time updates
    _subscription = _documentRef.snapshots().listen((snapshot) {
      if (snapshot.exists) {
        final data = snapshot.data() as Map<String, dynamic>;
        _controller.text = data['content'];
      }
    });

    // Initialize document if it doesn't exist
    _documentRef.get().then((snapshot) {
      if (!snapshot.exists) {
        _documentRef.set({'content': ''});
      }
    });
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }

  void _updateDocument(String content) {
    _documentRef.update({'content': content});
  }

  void _applyTextStyle(TextStyle textStyle) {
    setState(() {
      _selectedTextStyle = textStyle;
    });
  }

  void _applyFormatting({String prefix = '', String suffix = ''}) {
    final text = _controller.value.text;
    final selection = _controller.selection;
    final newText = StringBuffer(text.substring(0, selection.start));
    newText.write(prefix);
    newText.write(text.substring(selection.start, selection.end));
    newText.write(suffix);
    newText.write(text.substring(selection.end));
    final newSelection = TextSelection.collapsed(
      offset: selection.start + prefix.length + suffix.length,
    );
    _controller.value = TextEditingValue(
      text: newText.toString(),
      selection: newSelection,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: MyBottomNavigationBar(),
      appBar: createAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    maxLines: null,
                    decoration: InputDecoration(
                      hintText: 'Start typing...',
                      border: InputBorder.none,
                    ),
                    onChanged: _updateDocument,
                    style: _selectedTextStyle,
                    textAlignVertical: TextAlignVertical.center,
                  ),
                ),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      icon: Icon(Icons.format_bold),
                      onPressed: () =>
                          _applyFormatting(prefix: '**', suffix: '**'),
                    ),
                    IconButton(
                      icon: Icon(Icons.format_italic),
                      onPressed: () =>
                          _applyFormatting(prefix: '*', suffix: '*'),
                    ),
                    IconButton(
                      icon: Icon(Icons.format_underlined),
                      onPressed: () =>
                          _applyFormatting(prefix: '__', suffix: '__'),
                    ),
                    // Add more formatting tools as needed
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
