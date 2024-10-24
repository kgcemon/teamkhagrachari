import 'package:flutter/material.dart';
import 'package:teamkhagrachari/presentation/utils/color.dart';
import 'dashboard/home_screen.dart';

class ProductDetailsScreen extends StatefulWidget {
  final String title;
  final String price;
  final String address;
  final String desc;
  final String callNumber;
  final List<String> img;

  const ProductDetailsScreen({
    Key? key,
    required this.title,
    required this.price,
    required this.address,
    required this.callNumber,
    required this.desc,
    required this.img,
  }) : super(key: key);

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  void _makePhoneCall(String phoneNumber) {
    
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => _makePhoneCall(widget.callNumber),
        backgroundColor: Colors.teal,
        child: const Icon(Icons.call),
      ),
      appBar: AppBar(),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.indigo,
            expandedHeight: 300.0,
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                widget.title,
                style: const TextStyle(color: Colors.white),
              ),
              background: Hero(
                tag: 'product-image-${widget.title}',
                child: ImageSliderWidget(sliderImagesList: widget.img),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              color: const Color(0xFF2C2D41),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Product Price and Address
                 Container(
                   decoration: BoxDecoration(
                     borderRadius: BorderRadius.circular(10),
                       color: MyColors.secenderyColor.withOpacity(0.3)),
                   child: Padding(
                     padding: const EdgeInsets.all(10.0),
                     child: Column(children: [
                       Row(
                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                         children: [
                           Text(
                             "৳${widget.price}",
                             style: theme.textTheme.titleLarge?.copyWith(
                               fontWeight: FontWeight.bold,
                               color: Colors.tealAccent,
                             ),
                           ),
                           Row(
                             children: [
                               const Icon(
                                 Icons.location_on,
                                 color: Colors.white70,
                               ),
                               const SizedBox(width: 4),
                               Text(
                                 widget.address,
                                 style: theme.textTheme.titleMedium?.copyWith(
                                   color: Colors.white70,
                                 ),
                               ),
                             ],
                           ),
                         ],
                       ),
                       const SizedBox(height: 5,),
                       const Row(children: [
                         Text("বিক্রেতাঃ emon khan",style: TextStyle(color: Colors.white),)
                       ],),
                     ],),
                   ),
                 ),
                    const SizedBox(height: 16),
                    // Product Description
                    Card(
                      color: MyColors.secenderyColor.withOpacity(0.3),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 4,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          widget.desc,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: Colors.white70,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    // Action Buttons
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
