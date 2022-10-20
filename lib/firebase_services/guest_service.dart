import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';
import 'package:wedding_planner/firebase_models/guest_model.dart';

import 'google_auth_service.dart';

class GuestService {
  FirebaseFirestore db = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> addGuest(
      {required String name,
      required String email,
      required String cell,
      required String relationship,
      bool rsvpStatus = false}) async {
    try {
      db
          .collection('users')
          .doc(_auth.currentUser!.uid)
          .collection('Guests')
          .add({
        'name': name,
        'email': email,
        'cell': cell,
        'relationship': relationship,
        'rsvpStatus': rsvpStatus
      });
    } catch (e) {
      print("Failed to add guest: $e");
    }
  }

  addGuests({required List<GuestModel> guests}) async {
    try {
      for (var guest in guests) {
        await db
            .collection('users')
            .doc(_auth.currentUser!.uid)
            .collection('Guests')
            .add(guest.toMap());
      }
    } catch (e) {
      print("Failed to add guest: $e");
    }
  }

  addGuestsssss({required List<GuestModel> guests}) async {
    try {
      await db
          .collection('users')
          .doc(_auth.currentUser!.uid)
          .collection('Guests')
          .add({
        for (int i = 0; i < guests.length; i++)
          'Guest${i + 1}': guests[i].toMap()
      });
    } catch (e) {
      print("Failed to add guest: $e");
    }
  }

  setGuestRsvpStatus(
      {required String docId,
      required String guestKey,
      required String guestId,
      required bool status}) async {
    try {
      await db
          .collection('users')
          .doc(_auth.currentUser!.uid)
          .collection('Guests')
          .doc(docId)
          .update({'$guestKey.rsvpStatus': status});
    } catch (e) {
      print('Could not set guest rsvp status Error: $e');
    }
  }

  fetchGuests() async {
    List<GuestListsModel> guestLists = [];
    List<GuestModel> allGuests = [];
    try {
      await db
          .collection('users')
          .doc(_auth.currentUser!.uid)
          .collection('Guests')
          .get()
          .then((guests) {
        for (var guestDoc in guests.docs) {
          guestDoc.data().forEach((key, value) {});

          guestDoc.data().forEach((key, value) {
            List<GuestModel> list = [];
            list.add(GuestModel.fromMap(value, key));
            guestLists.add(GuestListsModel(id: guestDoc.id, guestList: list));
          });
        }
        return guestLists.toList();
      });
      return guestLists.toList();
    } catch (e) {
      print('Failed to fetch guests. Error: $e');
    }
    return guestLists.toList();
  }

  sendEmails() async {
    final user = await GoogleAuthApi.signIn();
    if (user == null) return;

    final myEmail = user.email;

    final auth = await user.authentication;

    final token = auth.accessToken!;

    final smtpServer = gmailSaslXoauth2(myEmail, token);

    // Creating the Gmail server

    // Create our email message.

    final message = Message()
      ..from = Address(myEmail, 'Julia')
      ..recipients = [myEmail] //recipent email

      // ..ccRecipients.addAll(['destCc1@example.com', 'destCc2@example.com']) //cc Recipents emails
      //
      // ..bccRecipients.add(Address('bccAddress@example.com')) //bcc Recipents emails

      ..subject =
          'Test Dart Mailer library :: 😀 :: ${DateTime.now()}' //subject of the email
      ..text =
          'This is the plain text.\nThis is line 2 of the text part.'; //body of the email

    try {
      final sendReport = await send(message, smtpServer);

      print('Message sent: ' +
          sendReport.toString()); //print if the email is sent
      return showSnackBar('Emails sent successfully!');
    } on MailerException catch (e) {
      print('Message not sent. \n' +
          e.toString()); //print if the email is not sent

      // e.toString() will show why the email is not sending

    }
  }

  void showSnackBar(String text) {
    final snackBar = SnackBar(
        content: Text(
      text,
      style: TextStyle(fontSize: 20),
    ));
  }
}