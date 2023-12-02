import 'package:flutter/material.dart';
import 'package:task_manager/data/models/task_model.dart';

class taskItemCard extends StatelessWidget {
  // final TaskData taskData;

   const taskItemCard({
    super.key,
    required this.taskData
  });

  final TaskData taskData;
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 16,horizontal: 16),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              Text(taskData.title ?? '',
                style: const TextStyle(
                    fontSize: 18,fontWeight: FontWeight.w500
                ),),
              Text(taskData.description ?? ''),
              Text("Date: ${taskData.createdDate}"),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Chip(label: Text( taskData.status ?? "New",style: TextStyle(color: Colors.white),),backgroundColor: Colors.blue,),
                  Wrap(
                    children: [
                      IconButton(onPressed: (){}, icon: Icon(Icons.edit)),
                      IconButton(onPressed: (){}, icon: Icon(Icons.delete,),)
                    ],
                  )
                ],
              )
            ]),
      ),
    );
  }
}
