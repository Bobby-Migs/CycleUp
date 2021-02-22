import 'dart:io';

import 'package:flutter/material.dart';

class RentalOutput {
  String bikeName;
  int price;
  String frameset;
  String fork;
  String cranks;
  File img;

  RentalOutput({
    this.bikeName,
    this.price,
    this.frameset,
    this.fork,
    this.cranks,
    this.img
});
}