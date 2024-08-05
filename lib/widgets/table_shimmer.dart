import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'shimmer.dart';
class TableShimmerUi extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[200]!,
        child: Column(
          children: [1,2,3].map((item){
            return Row(
            mainAxisAlignment:MainAxisAlignment.spaceBetween,
            children: [
              Expanded(child: ShimmerContainer(30,double.infinity,EdgeInsets.symmetric(vertical:10,horizontal:10))),
              Expanded(child: ShimmerContainer(30,double.infinity,EdgeInsets.symmetric(vertical:10,horizontal:10))),
              Expanded(child: ShimmerContainer(30,double.infinity,EdgeInsets.symmetric(vertical:10,horizontal:10))),
              Expanded(child: ShimmerContainer(30,double.infinity,EdgeInsets.symmetric(vertical:10,horizontal:10))),
              Expanded(child: ShimmerContainer(30,double.infinity,EdgeInsets.symmetric(vertical:10,horizontal:10))),
              Expanded(child: ShimmerContainer(30,double.infinity,EdgeInsets.symmetric(vertical:10,horizontal:10))),
            ],
          );
          }).toList(),
        )
      ),
    );
  }
}
