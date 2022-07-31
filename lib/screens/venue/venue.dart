import 'package:flutter/material.dart';
import 'package:wedding_planner/widgets/app_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Venue extends StatefulWidget {
  const Venue({Key? key}) : super(key: key);

  @override
  State<Venue> createState() => _VenueState();
}

class _VenueState extends State<Venue> {
  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    String name = '';
    List<String> names = [];
    return Scaffold(
      appBar: WPAppBar(
        title: 'Venue',
      ),
      body: ListView(children: [
        GetUserName('OsMCCWfa7bGLqtOtMaDZ'),
        AddUser(
          fullName: 'Julia',
          age: 26,
          company: 'Acumen',
        ),
        Container(
          child: TextButton(
            onPressed: () {
              firestore
                  .collection('Guests')
                  .get()
                  .then((QuerySnapshot querySnapshop) {
                querySnapshop.docs.forEach((doc) {
                  name = doc['name'];
                  setState(() {
                    names.add(name);
                  });
                });
              });
            },
            child: Text(
              'Press me',
              style: TextStyle(color: Colors.black),
            ),
          ),
        ),
        for (var name in names) ...[Text(name)]
      ]),
    );
  }
}

class AddUser extends StatelessWidget {
  final String fullName;
  final String company;
  final int age;

  AddUser({required this.fullName, required this.company, required this.age});

  @override
  Widget build(BuildContext context) {
    // Create a CollectionReference called users that references the firestore collection
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    Future<void> addUser() {
      // Call the user's CollectionReference to add a new user
      return users
          .add({
            'full_name': fullName, // John Doe
            'company': company, // Stokes and Sons
            'age': age // 42
          })
          .then((value) => print("User Added"))
          .catchError((error) => print("Failed to add user: $error"));
    }

    return TextButton(
      onPressed: addUser,
      child: Text(
        "Add User",
      ),
    );
  }
}

class GetUserName extends StatelessWidget {
  final String documentId;

  GetUserName(this.documentId);

  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(documentId).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text("Something went wrong");
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          return Text("Document does not exist");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          return Text("Full Name: ${data['full_name']} ${data['last_name']}");
        }

        return Text("loading");
      },
    );
  }
}