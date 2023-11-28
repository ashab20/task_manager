
import 'package:flutter/material.dart';
import 'package:task_manager/ui/screens/edit_profile_screen.dart';

class profileSummaryCard extends StatelessWidget {
   const profileSummaryCard({
    super.key,this.enableOnTap=true
  });
 final bool enableOnTap;
  @override
  Widget build(BuildContext context) {
    return  ListTile(
      onTap: (){
        if(enableOnTap){
          Navigator.push(context, MaterialPageRoute(builder: (context)=> const EditProfileScreen()));
        }
      },
      tileColor: Colors.green,
      subtitle: Text(
        'ashab@gmail.com',
        style: TextStyle(color: Colors.white),
      ),
      leading: CircleAvatar(
        child: Icon(Icons.person),
      ),
      trailing:enableOnTap ? Icon(Icons.arrow_forward) : null,
      title: Text(
        "Ashab Uddin",
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
      ),
    );
  }
}
