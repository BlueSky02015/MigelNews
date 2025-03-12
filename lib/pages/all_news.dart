import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:newsapp/models/article_model.dart';
import 'package:newsapp/models/slider_model.dart';
import 'package:newsapp/pages/article_view.dart';
import 'package:newsapp/services/news.dart';
import 'package:newsapp/services/slider_data.dart';
import 'package:newsapp/services/slider_data_2.dart';

class AllNews extends StatefulWidget {
  String news;
  AllNews({super.key, required this.news});

  @override
  State<AllNews> createState() => _AllNewsState();
}

class _AllNewsState extends State<AllNews> {
  List<sliderModel> sliders = [];
  List<sliderModel> sliders2 = [];
  List<ArticleModel> articles = [];

  @override
  void initState() {
    getSlider();
    getSlider2();
    getNews();
    super.initState();
  }

  getNews() async {
    News newsclass = News();
    await newsclass.getNews();
    articles = newsclass.news;
    setState(() {});
  }

  getSlider() async {
    Sliders slider = Sliders();
    await slider.getSlider();
    sliders = slider.sliders;
    setState(() {});
  }

  getSlider2() async {
    Sliders2 slider2 = Sliders2();
    await slider2.getSlider2();
    sliders2 = slider2.sliders2;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "${widget.news} News",
          style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 10.0),
        child: ListView.builder(
            shrinkWrap: true,
            physics: ClampingScrollPhysics(),
            itemCount: widget.news == "Breaking"
                ? sliders.length
                : (widget.news == "Trending"
                    ? sliders2.length
                    : articles.length),
            itemBuilder: (context, index) {
              print(articles.length);
              print(sliders.length);
              return AllNewsSection(
                Image: widget.news == "Breaking"
                    ? sliders[index].urlToImage!
                    : (widget.news == "Trending"
                        ? sliders2[index].urlToImage!
                        : articles[index].urlToImage!),
                desc: widget.news == "Breaking"
                    ? sliders[index].description!
                    : (widget.news == "Trending"
                        ? sliders2[index].description!
                        : articles[index].description!),
                title: widget.news == "Breaking"
                    ? sliders[index].title!
                    : (widget.news == "Trending"
                        ? sliders2[index].title!
                        : articles[index].title!),
                url: widget.news == "Breaking"
                    ? sliders[index].url!
                    : (widget.news == "Trending"
                        ? sliders2[index].url!
                        : articles[index].url!),
              );
            }),
      ),
    );
  }
}

class AllNewsSection extends StatelessWidget {
  String Image, desc, title, url;
  AllNewsSection(
      {required this.Image,
      required this.desc,
      required this.title,
      required this.url});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => ArticleView(blogUrl: url)));
      },
      child: Container(
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: CachedNetworkImage(
                imageUrl: Image,
                width: MediaQuery.of(context).size.width,
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              height: 5.0,
            ),
            Text(
              title,
              maxLines: 2,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              desc,
              maxLines: 3,
              style: TextStyle(
                color: const Color.fromARGB(107, 255, 255, 255),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
          ],
        ),
      ),
    );
  }
}
