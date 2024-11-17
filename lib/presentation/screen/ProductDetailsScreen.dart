import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:lecle_flutter_carousel_pro/lecle_flutter_carousel_pro.dart';
import 'package:photo_view/photo_view.dart';
import 'package:teamkhagrachari/data/model/ProductDetailsModel.dart';
import 'package:teamkhagrachari/presentation/utils/color.dart';
import 'package:teamkhagrachari/presentation/utils/uri_luncher.dart';
import 'package:http/http.dart' as http;
import '../../data/urls..dart';

class ProductDetailsScreen extends StatefulWidget {
  final ProductDetailsModel data;
  final int index;

  const ProductDetailsScreen({
    Key? key,
    required this.data,
    required this.index,
  }) : super(key: key);

  @override
  _ProductDetailsScreenState createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  void _makePhoneCall(String phoneNumber) {
    uriLaunchUrl("$phoneNumber");
  }

  @override
  void initState() {
    load();
    super.initState();
  }

  load() async {
    var res = await http.patch(Uri.parse(
        "${ApiUrl.mainUrl}/products/update-view/${widget.data.data.data[widget.index].id}"));
    print(res.body);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final product = widget.data.data.data[widget.index];

    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white70,
        items: const [
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.phone,color: Color(0xff128C7E),),
            label: 'Call Now',
          ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.whatsapp,color: Color(0xff128C7E),),
            label: 'WhatsApp',
          ),
        ],
        onTap: (index) {
          if (index == 0) {
            _makePhoneCall('tel:${product.phone}');
          } else if (index == 1) {
            _makePhoneCall(
                "https://wa.me/${product.phone.contains("+88")
                    ? product.phone : "+88${product.phone}"}");
          }
        },
      ),
      appBar: AppBar(),
      body: CustomScrollView(
        slivers: [
          _buildSliverAppBar(product),
          SliverToBoxAdapter(
            child: Container(
              color: const Color(0xFF2C2D41),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildProductInfoCard(theme, product),
                    const SizedBox(height: 16),
                    _buildProductConditionBrand(product),
                    const SizedBox(height: 16),
                    _buildProductDescriptionCard(theme, product),
                    const SizedBox(height: 16),
                    _similarProduct(widget.data),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSliverAppBar(ProductDetails product) {
    return SliverAppBar(
      backgroundColor: Colors.indigo,
      expandedHeight: 300.0,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        background: ImageSliderWidget(sliderImagesList: [
          product.img,
          product.img2,
          product.img3,
        ]),
      ),
    );
  }

  Widget _buildProductInfoCard(ThemeData theme, ProductDetails product) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: MyColors.secenderyColor.withOpacity(0.3),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              product.name,
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "৳${product.price}",
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
                      product.userId.upazila,
                      style: theme.textTheme.titleMedium?.copyWith(
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Seller: ${product.userId.name}",
                  style: const TextStyle(color: Colors.white),
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.remove_red_eye,
                      size: 15,
                    ),
                    const SizedBox(
                      width: 3,
                    ),
                    Text(
                      "${product.totalView}",
                      style: const TextStyle(color: Colors.grey),
                    )
                  ],
                ),
              ],
            ),
            Row(
              children: [
                const Icon(
                  Icons.calendar_month,
                  size: 18,
                ),
                Text(
                  DateFormat(" dd MMM yyyy").format(product.createdAt),
                  style: const TextStyle(color: Colors.grey),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildProductConditionBrand(ProductDetails product) {
    return Container(
      padding: const EdgeInsets.all(13),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(15)),
        color: MyColors.secenderyColor.withOpacity(0.3),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Condition:  ${product.isUsed}",
            style: const TextStyle(color: Colors.grey),
          ),
          Text(
            "Brand:  ${product.brand}",
            style: const TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget _buildProductDescriptionCard(ThemeData theme, ProductDetails product) {
    return SizedBox(
      width: double.maxFinite,
      child: Card(
        color: MyColors.secenderyColor.withOpacity(0.3),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const Text(
                "Description",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.white),
              ),
              Text(
                product.desc,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: Colors.white70,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _similarProduct(ProductDetailsModel data) {
    final currentProduct = data.data.data[widget.index];
    final List<ProductDetails> similarProducts =
        data.data.data.where((product) {
      return product.name != currentProduct.name && product != currentProduct;
    }).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Text(
            "Similar Products",
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: similarProducts.length,
          itemBuilder: (context, index) {
            final product = similarProducts[index];
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProductDetailsScreen(
                      data: data,
                      index: data.data.data.indexOf(product),
                    ),
                  ),
                );
              },
              child: _buildSimilarProductCard(product),
            );
          },
        ),
      ],
    );
  }

  Widget _buildSimilarProductCard(ProductDetails product) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Container(
        color: MyColors.secenderyColor.withOpacity(0.3),
        child: ListTile(
          leading: GestureDetector(
            onTap: () {
              // Navigate to the full-screen image view
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => FullScreenImageView(imageUrl: product.img),
                ),
              );
            },
            child: SizedBox(
              width: 70,
              child: Image.network(
                product.img,
                fit: BoxFit.cover,
              ),
            ),
          ),
          title: Text(
            product.name,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
            overflow: TextOverflow.ellipsis,
          ),
          subtitle: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "৳${product.price}",
                style: const TextStyle(
                  color: Colors.tealAccent,
                ),
              ),
              Row(
                children: [
                  const Icon(
                    Icons.location_on,
                    size: 15,
                    color: Colors.grey,
                  ),
                  Text(
                    product.userId.upazila,
                    style: const TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Add this widget for the image slider with clickable images
class ImageSliderWidget extends StatelessWidget {
  const ImageSliderWidget({super.key, required this.sliderImagesList});

  final List<String> sliderImagesList;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: SizedBox(
        height: 140,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(5),
          child: sliderImagesList.isEmpty
              ? const Center(child: CircularProgressIndicator())
              : Carousel(
                  dotSize: 5,
                  dotSpacing: 15,
                  dotPosition:
                      DotPosition.values[DotPosition.bottomCenter.index],
                  boxFit: BoxFit.cover,
                  dotBgColor: Colors.transparent,
                  dotColor: Colors.white,
                  dotVerticalPadding: -15,
                  images: sliderImagesList
                      .map(
                        (url) => ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: GestureDetector(
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => FullScreenImageGallery(
                                  images: sliderImagesList,
                                  initialIndex: 0,
                                ),
                              ),
                            ),
                            child: CachedNetworkImage(
                              imageUrl: url,
                              fit: BoxFit.cover,
                              placeholder: (context, url) => const Center(
                                child: CupertinoActivityIndicator(),
                              ),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
        ),
      ),
    );
  }
}

// Full-screen image gallery with zoom functionality
class FullScreenImageGallery extends StatefulWidget {
  final List<String> images;
  final int initialIndex;

  const FullScreenImageGallery({
    Key? key,
    required this.images,
    this.initialIndex = 0,
  }) : super(key: key);

  @override
  _FullScreenImageGalleryState createState() => _FullScreenImageGalleryState();
}

class _FullScreenImageGalleryState extends State<FullScreenImageGallery> {
  late final PageController _pageController;
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
    _pageController = PageController(initialPage: _currentIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onPageChanged(int index) {
    setState(() => _currentIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('${_currentIndex + 1} / ${widget.images.length}'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: PageView.builder(
        controller: _pageController,
        onPageChanged: _onPageChanged,
        itemCount: widget.images.length,
        itemBuilder: (context, index) {
          final imageUrl = widget.images[index];
          return PhotoView(
            imageProvider: NetworkImage(imageUrl),
            backgroundDecoration: const BoxDecoration(color: Colors.black),
          );
        },
      ),
    );
  }
}

// Full-screen image view for single images
class FullScreenImageView extends StatelessWidget {
  final String imageUrl;

  const FullScreenImageView({Key? key, required this.imageUrl})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Image View'),
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: PhotoView(
          imageProvider: NetworkImage(imageUrl),
          backgroundDecoration: const BoxDecoration(color: Colors.black),
        ),
      ),
    );
  }
}
