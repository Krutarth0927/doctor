import 'package:d2/other/color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(doctorca());
}

class doctorca extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          leading: GestureDetector(
              onTap: () {
                Get.back();
              },
              child: const Icon(
                Icons.arrow_back,
                color: AppColors.text,
              )),
          backgroundColor: AppColors.primary,
          elevation: 0,
          title: const Text(
            'Health App',
            style: TextStyle(
              color: AppColors.text,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: const doctype(),
      ),
    );
  }
}

class doctype extends StatefulWidget {
  const doctype({super.key});

  @override
  State<doctype> createState() => _doctypeState();
}

class _doctypeState extends State<doctype> {
  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SectionTitle(title: "Top Doctors"),
            SizedBox(height: 8),
            HorizontalCardList(
              items: [
                CardItem(
                  title: "Dr. Drew Feig",
                  subtitle: "⭐ 4.5",
                  imageUrl: "assets/hospital/1.jpg",
                ),
                CardItem(
                  title: "Dr.Avery Davis",
                  subtitle: "⭐ 4.5",
                  imageUrl: "assets/hospital/1.jpg",
                ),
                CardItem(
                  title: "Dr. Mark Lee",
                  subtitle: "⭐ 4.5",
                  imageUrl: "assets/hospital/1.jpg",
                ),
              ],
            ),
            SizedBox(height: 16),
            SectionTitle(title: "Best Health Plans"),
            SizedBox(height: 8),
            SizedBox(
              height: 165,
              child: HorizontalImageCardList(
                images: [
                  "assets/hospital/3.jpg",
                  "assets/hospital/3.jpg",
                  "assets/hospital/3.jpg",
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String title;

  const SectionTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        const Text(
          "Show All",
          style: TextStyle(
              color: AppColors.textPrimary,
              fontSize: 18,
              fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}

class HorizontalCardList extends StatelessWidget {
  final List<CardItem> items;

  const HorizontalCardList({required this.items});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: items.length,
        itemBuilder: (context, index) {
          return items[index];
        },
      ),
    );
  }
}

class CardItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final String imageUrl;

  const CardItem({
    required this.title,
    required this.subtitle,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
              child: Image.asset(
                imageUrl,
                height: 80,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            if (title.isNotEmpty) ...[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style:
                          const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: const TextStyle(color: AppColors.textPrimary, fontSize: 12),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class HorizontalImageCardList extends StatelessWidget {
  final List<String> images;

  const HorizontalImageCardList({required this.images});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: images.length,
        itemBuilder: (context, index) {
          return Container(
            width: 120,
            margin: const EdgeInsets.symmetric(horizontal: 8),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(
                  images[index],
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
