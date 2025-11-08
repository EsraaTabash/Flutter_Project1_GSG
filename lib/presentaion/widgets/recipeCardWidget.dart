import 'package:flutter/material.dart';
import 'package:recipe_book_application/data/local/local_auth_service.dart';
import 'package:recipe_book_application/data/models/recipeModel.dart';

class Recipecardwidget extends StatefulWidget {
  final Recipemodel recipe;
  const Recipecardwidget({super.key, required this.recipe});

  @override
  State<Recipecardwidget> createState() => _RecipeitemwidgetState();
}

class _RecipeitemwidgetState extends State<Recipecardwidget> {
  bool isFav = false;

  @override
  void initState() {
    super.initState();
    isFav = LocalAuthService.isFavorite(widget.recipe.recipeId ?? 0);
  }

  @override
  Widget build(BuildContext context) {
    const recipePalette = [
      Color(0xFFFF8A65), // Coral Orange
      Color(0xFFFFC107), // Honey Yellow 🍯
      Color(0xFF81C784), // Mint Green
      Color(0xFF64B5F6), // Sky Blue
      Color(0xFFF06292), // Pink Berry
      Color(0xFFFFB74D), // Peachy
    ];
    final index = ((widget.recipe.recipeId ?? 0) % recipePalette.length)
        .toInt();
    return Container(
      margin: EdgeInsets.all(5),
      padding: EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 10),
      decoration: BoxDecoration(
        color: Color(0xffF6F6F6),
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Color(0xff000000),
            blurRadius: 4,
            offset: const Offset(2, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Stack(
            alignment: Alignment.topRight,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child:
                      (widget.recipe.recipeImage != null &&
                          widget.recipe.recipeImage!.isNotEmpty)
                      ? Image.network(
                          widget.recipe.recipeImage ?? "",
                          width: double.infinity,
                          height: 120,
                          fit: BoxFit.cover,
                        )
                      : Container(
                          width: double.infinity,
                          height: 120,
                          color: Colors.grey[300],
                          alignment: Alignment.center,
                          child: const Icon(Icons.image_not_supported),
                        ),
                ),
              ),
              Positioned(
                top: 5,
                right: 5,
                child: InkWell(
                  onTap: () => _onHeartTap(),
                  child: Container(
                    padding: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white,
                    ),
                    child: isFav
                        ? Icon(
                            Icons.favorite,
                            size: 18,
                            color: Colors.redAccent,
                          )
                        : Icon(Icons.favorite_border, size: 18),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          Expanded(
            child: Text(
              widget.recipe.recipeName ?? "",
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              style: TextStyle(
                color: Colors.black,
                fontSize: 13,
                fontFamily: "Inter",
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Icon(Icons.monitor_heart, size: 13, color: Color(0xff868686)),
              Text(
                //"${widget.recipe.recipeIngredientsCount} ing",
                "${widget.recipe.recipeHealthScore} HS",
                style: TextStyle(
                  color: Color(0xff868686),
                  fontSize: 9,
                  fontFamily: "Inter",
                  fontWeight: FontWeight.w500,
                ),
              ),
              Image.asset("assets/dot.png"),
              Image.asset("assets/time.png"),
              Text(
                "${widget.recipe.recipeTime} min",
                style: TextStyle(
                  color: Color(0xff868686),
                  fontSize: 9,
                  fontFamily: "Inter",
                  fontWeight: FontWeight.w500,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
            decoration: BoxDecoration(
              color: recipePalette.isNotEmpty
                  ? recipePalette[index]
                  : Colors.orangeAccent,

              borderRadius: BorderRadius.circular(15),
            ),
            child: Center(
              child: Text(
                widget.recipe.recipeCategory ?? "",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontFamily: "Inter",
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _onHeartTap() async {
    final id = widget.recipe.recipeId;
    if (id == null) return;

    await LocalAuthService.toggleFavorite(id);

    setState(() {
      isFav = !isFav;
    });
  }
}
