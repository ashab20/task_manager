import 'package:flutter/material.dart';
import 'package:task_manager/ui/widget/profile_summary_card.dart';
import 'package:task_manager/ui/widget/summary_card.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({super.key});

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              profileSummaryCard(),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    SummaryCard(title: 'New', count: '09'),
                    SummaryCard(title: 'Progress', count: '09'),
                    SummaryCard(title: 'Completed', count: '09'),
                    SummaryCard(title: 'Cancelled', count: '09'),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

