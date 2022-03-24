import 'package:flutter/material.dart';

getHeight(BuildContext context) => MediaQuery.of(context).size.height;
getWidth(BuildContext context) => MediaQuery.of(context).size.width;
TextTheme getText(BuildContext context) => Theme.of(context).textTheme;
