import 'dart:io';

import 'package:flutter/material.dart';

class RentalOutput {
  String bikeName;
  int price;
  String frameset;
  String fork;
  String cranks;
  String features;
  File img;

  RentalOutput({
    this.bikeName,
    this.price,
    this.frameset,
    this.fork,
    this.cranks,
    this.features,
    this.img
});
}