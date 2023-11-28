
import 'package:flutter/material.dart';
import 'package:task_manager/ui/widget/body_background.dart';
import 'package:task_manager/ui/widget/profile_summary_card.dart';

class AddNewTaskScreen extends StatefulWidget {
  const AddNewTaskScreen({super.key});

  @override
  State<AddNewTaskScreen> createState() => _AddNewTaskScreenState();
}

class _AddNewTaskScreenState extends State<AddNewTaskScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const profileSummaryCard(),
            Expanded(
              child: BodyBackground(child:SingleChildScrollView(
                child: Column(
              children: [
                const SizedBox(height: 32,),
                Text("Add New Task",style: Theme.of(context).textTheme.titleLarge),
                TextField(
                  decoration: const InputDecoration(
                    hintText: "Subject"
                  ),
                ),const SizedBox(height: 8,),
                TextField(
                  maxLines: 8,
                  decoration: const InputDecoration(
                    hintText: "Description"
                  ),
                ),
                const SizedBox(height: 16,),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: (){},
                      child: Icon(Icons.arrow_circle_right_outlined),
                  ),
                ),
              ],
            ),
            ),
            ),
            ),
          ],
        ),
      ),
    );
  }
}
