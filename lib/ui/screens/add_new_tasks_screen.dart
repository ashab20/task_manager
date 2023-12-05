
import 'package:flutter/material.dart';
import 'package:task_manager/data/network_caller/network_caller.dart';
import 'package:task_manager/data/network_caller/network_response.dart';
import 'package:task_manager/data/utilities/urls.dart';
import 'package:task_manager/ui/widget/body_background.dart';
import 'package:task_manager/ui/widget/profile_summary.dart';
import 'package:task_manager/ui/widget/snack_message.dart';

class AddNewTaskScreen extends StatefulWidget {
  const AddNewTaskScreen({super.key});

  @override
  State<AddNewTaskScreen> createState() => _AddNewTaskScreenState();
}

class _AddNewTaskScreenState extends State<AddNewTaskScreen> {
  TextEditingController _subjectTextEditController = TextEditingController();
  TextEditingController _descriptionTextEditController = TextEditingController();
  final GlobalKey<FormState> _taskFormKey = GlobalKey<FormState>();
  bool createTaskInProgress = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const ProfileSummary(),
            Expanded(
              child: BodyBackground(child:SingleChildScrollView(
                child: Form(
                  key: _taskFormKey,
                  child: Column(
                                children: [
                  const SizedBox(height: 32,),
                  Text("Add New Task",style: Theme.of(context).textTheme.titleLarge),
                  TextFormField(
                    validator: (value){
                      if(value?.trim().isEmpty ?? true){
                        return "Please Insert the subject";
                      }
                      return null;
                    },
                    controller: _subjectTextEditController,
                    decoration: const InputDecoration(
                      hintText: "Subject"
                    ),
                  ),const SizedBox(height: 8,),
                  TextFormField(
                    validator: (value){
                      if(value?.trim().isEmpty ?? true){
                        return "Please Insert  Description";
                      }
                      return null;
                    },
                    controller: _descriptionTextEditController,
                    maxLines: 8,
                    decoration: const InputDecoration(
                      hintText: "Description"
                    ),
                  ),
                  const SizedBox(height: 16,),
                  SizedBox(
                    width: double.infinity,
                    child: Visibility(
                      visible: !createTaskInProgress,
                      replacement: const Center(child:  CircularProgressIndicator()),
                      child: ElevatedButton(
                          onPressed: createTask,
                          child: const Icon(Icons.arrow_circle_right_outlined),
                      ),
                    ),
                  ),
                                ],
                              ),
                ),
            ),
            ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> createTask() async{
    if(_taskFormKey.currentState!.validate()){
      createTaskInProgress = true;
      if(mounted){
        setState(() { });
      }

      final NetworkResponse response = await NetworkCaller().postRequest(Urls.createTask,body: {
        "title":_subjectTextEditController.text.trim(),
        "description": _descriptionTextEditController.text.trim(),
        "status" : "New"
      });

      createTaskInProgress = false;
      if(mounted){
        setState(() { });
      }

      if(response.isSuccess){
        if(mounted){
          showSnackMessage(context, "Task Creation Successful");
        }

      }else{
        if(mounted){
          print(response.statusCode.toString());
        showSnackMessage(context, "Something Goes Wrong! Please Try Again",true);
        }
      }

    }
  }

  @override
  void dispose() {
    _descriptionTextEditController.dispose();
    _subjectTextEditController.dispose();
    super.dispose();
  }
}
