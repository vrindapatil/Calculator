import 'package:flutter/cupertino.dart';

abstract class HomeEvent{}

class HomeNumPadButtonClickEvent extends HomeEvent{
  dynamic value;
  HomeNumPadButtonClickEvent({required this.value});
}