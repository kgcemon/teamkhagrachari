import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:teamkhagrachari/data/model/news_model.dart';
import 'package:teamkhagrachari/presentation/utils/color.dart';

class NewsViewScreen extends StatelessWidget {
  int index;
  List<NewsModel> newsViewList;
   NewsViewScreen({super.key,required this.newsViewList,required this.index});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(backgroundColor: MyColors.primaryColor,),
      body:  Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10,),
              Text(newsViewList[index].title,style: const TextStyle(fontSize: 22,fontWeight: FontWeight.w500),),
              const SizedBox(height: 20,),
              Text(newsViewList[index].date),
              Image.network(newsViewList[index].thumbnail,height: 230,width: double.infinity,fit: BoxFit.fill,),
              const SizedBox(height: 20,),
              HtmlWidget(newsViewList[index].content,)
            ],
          ),
        ),
      ),
    );
  }
}

