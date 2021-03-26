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
    ..html = "<h1>Rental Request Successfull</h1>\nYour rental is still up to pending until you have completed the needed requirements exclusively in the store."
        "Please arrive before the specified time of pick up and prepare the exact amount for the rental, you are also required to prepare a two valid ID. Thank you!"
        "<br/><br/><br/>"
        "<h3>It shall be the responsibility of the Biker-Borrower to comply with the following:</h3><br/><br/>"
        ""
        "1. It shall be the responsibility of the Biker to not ride on any lake or leave unsheltered on precipitous environments.<br/>"
        "2. Biker shall comply with the proper traffic laws at all times.<br/>"
        "3. Biker is not allowed to replace or substitute any parts or portion of the bicycle.<br/>"
        "4. Biker is not required nor recommended to clean the bicycle prior to returning the said bicycle.<br/>"
        "5. Biker is required to maintain proper responsibility in the user of the bicycle. BIker shall assume for any and all"
        "liabilities, damage, loss, to property, or injury ralated to the rent and use of bicycle.<br/>"
        "6. Biker is not allowed to sublease the bicycle rented with us.</p>";

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