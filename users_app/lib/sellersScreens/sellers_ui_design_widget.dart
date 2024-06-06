import 'package:flutter/material.dart';
import 'package:smooth_star_rating_nsafe/smooth_star_rating.dart';
import 'package:users_app/models/sellers.dart';

class SellersUIDesignWidget extends StatefulWidget {
  final Sellers? model;

  SellersUIDesignWidget({this.model});

  @override
  State<SellersUIDesignWidget> createState() => _SellersUIDesignWidgetState();
}

class _SellersUIDesignWidgetState extends State<SellersUIDesignWidget> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.black54,
      elevation: 20,
      shadowColor: Colors.grey,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SizedBox(
          height: 270,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(40),
                child: widget.model!.photoUrl != null && widget.model!.photoUrl!.isNotEmpty
                    ? Image.network(
                  widget.model!.photoUrl.toString(),
                  height: 220,
                  fit: BoxFit.fill,
                )
                    : Container(
                  height: 220,
                  color: Colors.grey, // Optional: A background color for the container
                  child: Center(
                    child: Text(
                      'No Image',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 1),
              Text(
                widget.model!.name ?? 'Unknown Seller',
                style: const TextStyle(
                  color: Colors.pinkAccent,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SmoothStarRating(
                rating: widget.model!.ratings == null ? 0.0 : double.parse(widget.model!.ratings.toString()),
                starCount: 5,
                color: Colors.pinkAccent,
                borderColor: Colors.pinkAccent,
                size: 16,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
