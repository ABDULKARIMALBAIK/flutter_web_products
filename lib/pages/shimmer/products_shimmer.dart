import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ProductsShimmer extends StatelessWidget {
  const ProductsShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: GridView.builder(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.vertical,
            padding: const EdgeInsets.all(16),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: MediaQuery.of(context).size.width /
                  (MediaQuery.of(context).size.height * 2.1), // width/height
              crossAxisCount: 3,
              crossAxisSpacing: 8,
              mainAxisSpacing: 5,
            ),
            itemCount: 9,
            itemBuilder: (context, index) => const ProductShimmerItem(),
          ),
        ),
      ),
    );
  }
}

class ProductShimmerItem extends StatefulWidget {
  const ProductShimmerItem({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ProductShimmerItemState();
}

class _ProductShimmerItemState extends State<ProductShimmerItem> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        child: Shimmer.fromColors(
      baseColor: Theme.of(context).backgroundColor,
      highlightColor: Theme.of(context).primaryColor.withOpacity(0.1),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.5,
            decoration: BoxDecoration(
              color: Theme.of(context).backgroundColor,
              borderRadius: BorderRadius.circular(18),
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Center(
                child: Container(
              width: 100,
              height: 20,
              decoration: BoxDecoration(
                color: Theme.of(context).backgroundColor,
                borderRadius: BorderRadius.circular(300),
              ),
            )),
          ),
          const SizedBox(
            height: 5,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Center(
                child: Container(
              width: 100,
              height: 10,
              decoration: BoxDecoration(
                color: Theme.of(context).backgroundColor,
                borderRadius: BorderRadius.circular(300),
              ),
            )),
          ),
        ],
      ),
    ));
  }
}
