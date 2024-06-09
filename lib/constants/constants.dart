import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

const String appName = "";
const String appTagLine = "";

String? fileType;
String? fileName;

int selectedIndex = 0;
final firestore = FirebaseFirestore.instance;
final storage = FirebaseStorage.instance;
final auth = FirebaseAuth.instance;
