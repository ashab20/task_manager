
import 'package:flutter/material.dart';
import 'package:task_manager/controllers/auth_controller.dart';
import 'package:task_manager/ui/screens/edit_profile_screen.dart';
import 'package:task_manager/ui/screens/login_screen.dart';
import 'package:task_manager/ui/widget/snack_message.dart';

class profileSummaryCard extends StatefulWidget {
   const profileSummaryCard({
    super.key,this.enableOnTap=true
  });
 final bool enableOnTap;

  @override
  State<profileSummaryCard> createState() => _profileSummaryCardState();
}

class _profileSummaryCardState extends State<profileSummaryCard> {
  @override
  Widget build(BuildContext context) {
    return  ListTile(
      onTap: (){
        if(widget.enableOnTap){
          Navigator.push(context, MaterialPageRoute(builder: (context)=> const EditProfileScreen()));
        }
      },
      tileColor: Colors.green,
      subtitle: Text(
        AuthController.user?.email ?? '',
        style: TextStyle(color: Colors.white),
      ),
      leading: CircleAvatar(
        child: Icon(Icons.person),
      ),
      trailing: IconButton(
        onPressed: () async{
          await AuthController.clearAuthUser();
          if(mounted){
            showSnackMessage(context, "Logout");
          }
          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=> LoginScreen()), (route) => false);
        },
        icon:const Icon(Icons.logout),
      ),
      title: Text(
        getFullName!,
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
      ),
    );
  }

  String? get getFullName{
    return (AuthController.user?.firstName ?? '' )+ ' ' + (AuthController.user?.lastName ?? '');
}
}
