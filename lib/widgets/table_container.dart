import 'package:flutter/material.dart';
import 'data_table.dart';
class TableContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        color:Color(0xFFf4f6f3),
        padding:EdgeInsets.symmetric(vertical:10,horizontal:10),
        child:Expanded(
          child: Column(
              crossAxisAlignment:CrossAxisAlignment.start,
              children:[
                Container(
                  padding:const EdgeInsets.symmetric(vertical:10,horizontal:5),
                  child:const Text('Dog Breed',
                      style:TextStyle(
                        fontSize:20,
                        fontWeight:FontWeight.bold,
                      )
                  ),
                ),
                TableData()
              ]
          ),
        )
    );
  }
}
