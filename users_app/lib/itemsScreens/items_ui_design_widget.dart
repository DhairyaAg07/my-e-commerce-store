import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/items.dart';

class ItemsUiDesignWidget extends StatefulWidget {
  final Items? model;
  final BuildContext? context;

  ItemsUiDesignWidget({this.model, this.context});

  @override
  State<ItemsUiDesignWidget> createState() => _ItemsUiDesignWidgetState();
}

class _ItemsUiDesignWidgetState extends State<ItemsUiDesignWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigator.push(context, MaterialPageRoute(builder: (c)=> ItemsDetailsScreen(
        //   model: widget.model,
        // )));
      },
      child: Card(
        elevation: 10,
        shadowColor: Colors.black,
        child: Padding(
          padding: const EdgeInsets.all(4),
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: SingleChildScrollView(
              child: Column(
                children: [

                  ClipRRect(
                    borderRadius: BorderRadius.circular(40),
                    child: Image.network(
                      widget.model!.thumbnailUrl.toString(),
                      height: 220,
                      width: MediaQuery.of(context).size.width,
                      fit: BoxFit.cover,
                    ),
                  ),
                  
                  SizedBox(height: 1,),
                  Text(
                    widget.model!.itemTitle.toString(),
                    style: const TextStyle(
                      color: Colors.deepPurple,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      letterSpacing: 3,
                    ),
                  ),
                  const SizedBox(height: 1),
                  
                  const SizedBox(height: 2),
                  Text(
                    widget.model!.itemInfo.toString(),
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
