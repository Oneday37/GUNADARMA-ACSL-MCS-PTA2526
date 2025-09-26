import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mcs_bab_3/model/cat_model.dart';

class DetailPage extends StatefulWidget {
  CatModel catModel;
  DetailPage({super.key, required this.catModel});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.catModel.name,
          style: GoogleFonts.oswald(fontSize: 20, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          Image.network(widget.catModel.urlImage),

          const SizedBox(height: 18),

          Container(
            margin: const EdgeInsets.symmetric(horizontal: 18),
            child: Text(
              widget.catModel.desc,
              style: GoogleFonts.oswald(fontSize: 16),
              textAlign: TextAlign.justify,
            ),
          ),
        ],
      ),
    );
  }
}
