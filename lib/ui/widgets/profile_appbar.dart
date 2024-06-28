
import 'package:flutter/material.dart';

import '../utility/app_colors.dart';

AppBar profileAppBar() {
  return AppBar(
    backgroundColor: AppColors.themeColor,
    title: const Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          'Dummy Name',
          style: TextStyle(fontSize: 16, color: Colors.white),
        ),
        Text(
          'email@email.com',
          style: TextStyle(
              fontSize: 12,
              color: Colors.white,
              fontWeight: FontWeight.w400),
        )
      ],
    ),
    leading: const Padding(
      padding: EdgeInsets.all(8.0),
      child: CircleAvatar(

        // child: NetworkCachedImage(url: ''),
      ),
    ),
    actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.logout))],
  );
}