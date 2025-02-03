import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:teamkhagrachari/data/model/news_model.dart';
import 'package:teamkhagrachari/presentation/utils/color.dart';

class NewsViewScreen extends StatefulWidget {
  final int index;
  final List<NewsModel> newsViewList;
  const NewsViewScreen({
    super.key,
    required this.newsViewList,
    required this.index,
  });

  @override
  State<NewsViewScreen> createState() => _NewsViewScreenState();
}

class _NewsViewScreenState extends State<NewsViewScreen> {
  BannerAd? _bannerAd;
  bool _isAdLoaded = false;

  // Test Ad Unit ID - Replace with production ID before release
  static const String _bannerAdUnitId = 'ca-app-pub-2912066127127483/5034334282';

  @override
  void initState() {
    super.initState();
    _loadBannerAd();
  }

  @override
  void dispose() {
    _bannerAd?.dispose();
    super.dispose();
  }

  void _loadBannerAd() {
    _bannerAd = BannerAd(
      adUnitId: _bannerAdUnitId,
      request: const AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          if (!mounted) return;
          setState(() => _isAdLoaded = true);
        },
        onAdFailedToLoad: (ad, error) {
          ad.dispose();
          debugPrint('Banner ad failed to load: $error');
        },
      ),
    )..load();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: MyColors.primaryColor,
        title: const Text('News Details'),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  Text(
                    widget.newsViewList[widget.index].title,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(widget.newsViewList[widget.index].date),
                  const SizedBox(height: 10),
                  Image.network(
                    widget.newsViewList[widget.index].thumbnail,
                    height: 230,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(height: 20),
                  HtmlWidget(widget.newsViewList[widget.index].content),
                ],
              ),
            ),
          ),
          // Banner Ad at bottom with safe area
          if (_isAdLoaded)
            SafeArea(
              child: Container(
                alignment: Alignment.center,
                width: _bannerAd!.size.width.toDouble(),
                height: _bannerAd!.size.height.toDouble(),
                child: AdWidget(ad: _bannerAd!),
              ),
            ),
        ],
      ),
    );
  }
}