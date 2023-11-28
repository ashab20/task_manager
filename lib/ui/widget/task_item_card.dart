import 'package:flutter/material.dart';

class taskItemCard extends StatelessWidget {
  const taskItemCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 16,horizontal: 16),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              Text("title will be here",
                style: TextStyle(
                    fontSize: 18,fontWeight: FontWeight.w500
                ),),
              Text("Description"),
              Text("Date: 12-10-2023"),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Chip(label: Text("New",style: TextStyle(color: Colors.white),),backgroundColor: Colors.blue,),
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
