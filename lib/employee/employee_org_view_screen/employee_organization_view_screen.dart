import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:remote_collab_tool/common/navbar/navbar.dart';
import 'package:remote_collab_tool/constants/utils/utils.dart';
import 'package:remote_collab_tool/features/poll_screen/poll_list_screen.dart';
import 'package:remote_collab_tool/features/pomodoro_timer/pomodoro_timer_screen.dart';
import 'package:remote_collab_tool/features/share_files/share_files_screen.dart';
import 'package:remote_collab_tool/theme/pallete.dart';

class EmployeeOrganizationViewScreen extends StatefulWidget {
  const EmployeeOrganizationViewScreen({super.key});

  @override
  State<EmployeeOrganizationViewScreen> createState() =>
      _EmployeeOrganizationViewScreenState();
}

class _EmployeeOrganizationViewScreenState
    extends State<EmployeeOrganizationViewScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "RCT",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 223, 223, 223).withOpacity(0.7),
                Color.fromARGB(255, 0, 0, 0).withOpacity(0.2)
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10,
                offset: Offset(0, 5),
              ),
            ],
          ),
        ),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.grey[300],
          tabs: [
            Tab(text: "Tasks"),
            Tab(text: "Members"),
            Tab(text: "Chat"),
          ],
        ),
      ),
      bottomNavigationBar: MyBottomNavigationBar(),
      backgroundColor: Pallete.bgColor,
      body: Column(
        children: [
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                TasksScreen(),
                MembersScreen(),
                ChatScreen(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class TasksScreen extends StatefulWidget {
  @override
  _TasksScreenState createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  List<bool> _taskCompletion = [false, false, false];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      margin: EdgeInsets.only(top: size.height * 0.17),
      child: ListView(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        children: [
          // Section: My Tasks
          _buildSectionHeader('My Tasks'),
          _buildTaskItem('Task 1', 0),
          _buildTaskItem('Task 2', 1),
          _buildTaskItem('Task 3', 2),
          // Section: Groupmates' Tasks
          _buildSectionHeader('Groupmates\' Tasks'),
          _buildGroupmateTaskItem(
              'Think of a hackathon', Icons.close, 'Sanjay', '24h'),
          _buildGroupmateTaskItem(
              'Plan a meeting', Icons.check, 'Varun', '12h'),
          _buildGroupmateTaskItem(
              'Research on Idea', Icons.close, 'MrFeast', '48h'),
          const SizedBox(height: 40),
          Center(
            child: InkWell(
              onTap: () {
                moveScreen(context: context, widget: ShareFilesScreen());
              },
              child: Container(
                width: double.infinity,
                height: size.height * 0.05,
                margin: const EdgeInsets.symmetric(horizontal: 50),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Pallete.buttonColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  "Share files 📁",
                  style: GoogleFonts.roboto(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Text(
        title,
        style: GoogleFonts.poppins(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildTaskItem(String taskName, int index) {
    return InkWell(
      onTap: () {
        moveScreen(context: context, widget: PomodoroTimer());
      },
      child: ListTile(
        title: Text(
          taskName,
          style: GoogleFonts.poppins(),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Checkbox(
              value: _taskCompletion[
                  index], // Change this to manage task completion
              onChanged: (value) {
                setState(() {
                  _taskCompletion[index] = value!;
                });
              },
            ),
            SizedBox(width: 10),
            // Timer Widget (You can replace this with your timer implementation)
            _buildTimer('12h'),
          ],
        ),
      ),
    );
  }

  Widget _buildGroupmateTaskItem(
      String taskName, IconData icon, String userName, String timeLeft) {
    return ListTile(
      leading: CircleAvatar(
        child: Text(userName[0]),
        backgroundColor: const Color.fromARGB(255, 224, 224, 224),
      ),
      title: Text(
        taskName,
        style: GoogleFonts.poppins(),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon),
          SizedBox(width: 10),
          _buildTimer(timeLeft),
        ],
      ),
    );
  }

  Widget _buildTimer(String timeLeft) {
    return Container(
      padding: EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: Colors.pinkAccent,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.timer, color: Colors.white),
          SizedBox(width: 5),
          Text(
            timeLeft,
            style: TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }
}

class MembersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      margin: EdgeInsets.only(top: size.height * 0.2),
      child: ListView(
        padding: EdgeInsets.symmetric(horizontal: 20),
        children: [
          _buildSectionHeader('Leader'),
          _buildLeaderTile('Fire Squad',
              'https://media.discordapp.net/attachments/1248667871954079917/1249434675932434462/image.png?ex=66674a38&is=6665f8b8&hm=cb9ec2fce2c5ffbeae3d78ff6ecb7c7918a86273894f145900795e739108c1f2&=&format=webp&quality=lossless&width=477&height=453'),
          _buildSectionHeader('Members'),
          _buildMemberTile('Armaan',
              'https://cdn-icons-png.flaticon.com/128/3135/3135715.png'),
          _buildMemberTile('Varun',
              'https://cdn-icons-png.flaticon.com/128/3135/3135715.png'),
          _buildMemberTile('MrFeast',
              'https://cdn-icons-png.flaticon.com/128/3135/3135715.png'),
          _buildMemberTile('Sanjay',
              'https://cdn-icons-png.flaticon.com/128/3135/3135715.png'),
          // Add more member tiles as needed
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Text(
        title,
        style: GoogleFonts.poppins(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildLeaderTile(String leaderName, String profileImage) {
    return ListTile(
      title: Row(
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(profileImage),
          ),
          SizedBox(width: 10),
          Text(
            leaderName,
            style: GoogleFonts.poppins(),
          ),
        ],
      ),
    );
  }

  Widget _buildMemberTile(String memberName, String profileImage) {
    return ListTile(
      title: Row(
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(profileImage),
          ),
          SizedBox(width: 10),
          Text(
            memberName,
            style: GoogleFonts.poppins(),
          ),
        ],
      ),
    );
  }
}

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();

  void _sendMessage() {
    if (_controller.text.isEmpty) return;
    FirebaseFirestore.instance.collection('messages').add({
      'content': _controller.text,
      'sender': FirebaseAuth.instance.currentUser?.uid ??
          '', // Replace with actual user data
      'timestamp': FieldValue.serverTimestamp(),
    });
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Chat'),
        actions: [
          IconButton(
            icon: Icon(Icons.poll),
            onPressed: () {
              moveScreen(context: context, widget: PollListScreen());
            },
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('messages')
                  .orderBy('timestamp', descending: true)
                  .snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                }
                final messages = snapshot.data!.docs.map((doc) {
                  return Message(
                    content: doc['content'],
                    sender: doc['sender'],
                    isMe: doc['sender'] ==
                        FirebaseAuth.instance.currentUser!
                            .uid, // Replace with actual user check
                  );
                }).toList();
                return ListView.builder(
                  reverse: true,
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    return ChatBubble(message: messages[index]);
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: 'Type a message',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      filled: true,
                      fillColor: Colors.pink[50],
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send, color: Colors.pink),
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Message {
  final String content;
  final String sender;
  final bool isMe;

  Message({required this.content, required this.sender, required this.isMe});
}

class ChatBubble extends StatelessWidget {
  final Message message;

  const ChatBubble({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.only(
      topLeft: Radius.circular(12.0),
      topRight: Radius.circular(12.0),
      bottomLeft: message.isMe ? Radius.circular(12.0) : Radius.circular(0),
      bottomRight: message.isMe ? Radius.circular(0) : Radius.circular(12.0),
    );

    final alignment =
        message.isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: alignment,
        children: <Widget>[
          Text(
            message.sender,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: message.isMe ? Colors.pink : Colors.blue,
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: message.isMe ? Colors.pink[100] : Colors.blue[100],
              borderRadius: borderRadius,
            ),
            padding: const EdgeInsets.all(12.0),
            child: Text(message.content),
          ),
        ],
      ),
    );
  }
}
