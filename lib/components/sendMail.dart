import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cycle_up/components/databaseManager.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:firebase_auth/firebase_auth.dart';

SendMail() async {
  final user = FirebaseAuth.instance.currentUser;

  String username = 'cycleupbaguio@gmail.com';
  String password = 'CycleUp123';

  final smtpServer = gmail(username, password);
  // Use the SmtpServer class to configure an SMTP server:
  // final smtpServer = SmtpServer('smtp.domain.com');
  // See the named arguments of SmtpServer for further configuration
  // options.

  // Create our message.
  final message = Message()
    ..from = Address(username, 'Cycle Up')
    ..recipients.add(user.email)
    ..subject = 'CycleUp Baguio  ${DateTime.now()}'
    ..text = 'bobby pogi!!!!!.\nThis is line 2 of the text part.'
    ..html = "<h1>Rental Successfull</h1>\n<p>You will be notified once the bike you have rented is ready for pickup."
        "Please arrive at the specified time of pick up and prepare the exact amount for the rental, you are also required to prepare a two valid ID. Thank you!.</p>";

  try {
    final sendReport = await send(message, smtpServer);
    print('Message sent: ' + sendReport.toString());
  } on MailerException catch (e) {
    print('Message not sent.');
    for (var p in e.problems) {
      print('Problem: ${p.code}: ${p.msg}');
    }
  }

}