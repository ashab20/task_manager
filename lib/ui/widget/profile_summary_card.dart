
import 'package:flutter/material.dart';

class profileSummaryCard extends StatelessWidget {
  const profileSummaryCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const ListTile(
      tileColor: Colors.green,
      subtitle: Text(
        'ashab@gmail.com',
        style: TextStyle(color: Colors.white),
      ),
      leading: CircleAvatar(
        child: Icon(Icons.person),
      ),
      trailing: Icon(Icons.forward_rounded),
      title: Text(
        "Ashab Uddin",
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
      ),
    );
  }
}
