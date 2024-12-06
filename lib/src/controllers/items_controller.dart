import 'package:flutter/material.dart';
import 'package:nettverk/src/models/index.dart';

class ItemsController with ChangeNotifier {
  ItemsController();

  List<Chat> items() => [
    const Chat(1, "Nettverk i Oslo", "assets/images/oslo_logo.png", "assets/images/ai_oslo.jpg", "oslouk"),
    const Chat(2, "Nettvek i Bergen", "assets/images/bergen_logo.png", "assets/images/ai_bergen.jpg", "bergenvolonterchat"),
  ];
}
