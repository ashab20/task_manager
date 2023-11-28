import 'package:flutter/material.dart';
import 'package:task_manager/ui/widget/profile_summary_card.dart';
import 'package:task_manager/ui/widget/task_item_card.dart';

class CancelledTaskScreen extends StatefulWidget {
  const CancelledTaskScreen({super.key});

  @override
  State<CancelledTaskScreen> createState() => _CancelledTaskScreenState();
}

class _CancelledTaskScreenState extends State<CancelledTaskScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const profileSummaryCard(),
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
