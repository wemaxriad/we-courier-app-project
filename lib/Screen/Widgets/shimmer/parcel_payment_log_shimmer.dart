import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ParcelPaymentLogShimmer extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ParcelPaymentLogShimmerState();
  }
}

class _ParcelPaymentLogShimmerState extends State<ParcelPaymentLogShimmer> {
  var mainHeight, mainWidth;

  @override
  Widget build(BuildContext context) {
    mainHeight = MediaQuery.of(context).size.height;
    mainWidth = MediaQuery.of(context).size.width;

    return  Expanded(
      child: ListView.separated(
        itemCount: 15,
        itemBuilder: (context, index) {
          return Shimmer.fromColors(
              highlightColor: Colors.grey[400]!,
              baseColor: Colors.grey[300]!,
              child:
            Padding(
            padding: const EdgeInsets.symmetric(vertical: 18.0, horizontal: 10),
            child:
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Text(
                    'parcel date',
                    style: TextStyle(fontSize: 14),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Text(
                    'parcel delivery',
                    style: TextStyle(fontSize: 14),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Text(
                    '0.00',
                    textAlign: TextAlign.end,
                    style: TextStyle(fontSize: 14),
                  ),
                ),
              ],
            )
          ));
        },
        separatorBuilder: (context, index) {
          return Divider(height: 1, color: Colors.grey.withOpacity(.5));
        },
      ),
    );

  }
}

