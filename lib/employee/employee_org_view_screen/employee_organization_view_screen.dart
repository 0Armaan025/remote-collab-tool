import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:remote_collab_tool/common/appbar/appbar.dart';
import 'package:remote_collab_tool/common/navbar/navbar.dart';
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
          _buildGroupmateTaskItem('Task A', Icons.close, 'John', '24h'),
          _buildGroupmateTaskItem('Task B', Icons.check, 'Emma', '12h'),
          _buildGroupmateTaskItem('Task C', Icons.close, 'Mike', '48h'),
          const SizedBox(height: 40),
          Center(
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
    return ListTile(
      title: Text(
        taskName,
        style: GoogleFonts.poppins(),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Checkbox(
            value:
                _taskCompletion[index], // Change this to manage task completion
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
          _buildLeaderTile('John Doe', 'assets/profile_pic.jpg'),
          _buildSectionHeader('Members'),
          _buildMemberTile('Member 1', 'assets/profile_pic.jpg'),
          _buildMemberTile('Member 2', 'assets/profile_pic.jpg'),
          _buildMemberTile('Member 3', 'assets/profile_pic.jpg'),
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
            backgroundImage: AssetImage(profileImage),
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
            backgroundImage: AssetImage(profileImage),
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
  final List<Message> messages = [
    Message(content: "Hello!", sender: "Alice", isMe: false),
    Message(content: "Hi, how are you?", sender: "Me", isMe: true),
    Message(content: "I'm good, thanks!", sender: "Alice", isMe: false),
    Message(content: "What about you?", sender: "Alice", isMe: false),
    Message(content: "I'm doing well too!", sender: "Me", isMe: true),
  ];

  final TextEditingController _controller = TextEditingController();

  void _sendMessage() {
    if (_controller.text.isEmpty) return;
    setState(() {
      messages
          .add(Message(content: _controller.text, sender: "Me", isMe: true));
      _controller.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Pallete.bgColor,
      appBar: AppBar(
        title: Text('Chat'),
        actions: [
          IconButton(
            icon: Icon(Icons.poll),
            onPressed: () {
              setState(() {});
            },
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              reverse: true,
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final message = messages[messages.length - 1 - index];
                return ChatBubble(message: message);
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
