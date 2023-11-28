import 'package:flutter/material.dart';
import 'package:task_manager/ui/screens/add_new_tasks_screen.dart';
import 'package:task_manager/ui/widget/profile_summary_card.dart';
import 'package:task_manager/ui/widget/summary_card.dart';
import 'package:task_manager/ui/widget/task_item_card.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({super.key});

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=> AddNewTaskScreen()));
        },
        child: Icon(Icons.add),
      ),
      body: SafeArea(
        child: Column(
            children: [
              const profileSummaryCard(),
              const SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Padding(
                  padding: EdgeInsets.only(left: 16,right: 16),
                  child: Row(
                    children: [
                      SummaryCard(title: 'New', count: '09'),
                      SummaryCard(title: 'Progress', count: '09'),
                      SummaryCard(title: 'Completed', count: '09'),
                      SummaryCard(title: 'Cancelled', count: '09'),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return const taskItemCard();
                    }),
              )
            ],
        ),
      ),
    );
  }
}

