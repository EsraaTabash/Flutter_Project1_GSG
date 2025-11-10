import 'package:flutter/material.dart';
import 'package:recipe_book_application/data/local/local_auth_service.dart';
import 'package:recipe_book_application/data/models/recipeModel.dart';

class Recipeitemwidget extends StatefulWidget {
  final Recipemodel recipe;
  const Recipeitemwidget({super.key, required this.recipe});

  @override
  State<Recipeitemwidget> createState() => _RecipeitemwidgetState();
}

class _RecipeitemwidgetState extends State<Recipeitemwidget> {
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
      Color(0xFFFFC107), // Honey Yellow
      Color(0xFF81C784), // Mint Green
      Color(0xFF64B5F6), // Sky Blue
      Color(0xFFF06292), // Pink Berry
      Color(0xFFFFB74D), // Peachy
    ];
    final index = ((widget.recipe.recipeId ?? 0) % recipePalette.length)
        .toInt();

    return Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Color(0xffF6F6F6),
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Color(0xff000000),
            blurRadius: 4,
            offset: Offset(2, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Stack(
            alignment: Alignment.topRight,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: (widget.recipe.recipeImage ?? "").isNotEmpty
                    ? Image.network(
                        widget.recipe.recipeImage ?? "",
                        width: double.infinity,
                        height: 180,
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
              Positioned(
                top: 15,
                right: 15,
                child: InkWell(
                  onTap: _onHeartTap,
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white,
                    ),
                    child: Icon(
                      isFav ? Icons.favorite : Icons.favorite_border,
                      size: 18,
                      color: isFav ? Colors.redAccent : null,
                    ),
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 15),

          Text(
            widget.recipe.recipeName ?? "",
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 17,
              fontFamily: "Inter",
              fontWeight: FontWeight.w500,
            ),
          ),

          SizedBox(height: 15),

          Container(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            decoration: BoxDecoration(
              color: recipePalette[index].withOpacity(0.1),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Icon(Icons.monitor_heart, size: 20, color: Color(0xff868686)),
                Text(
                  "${widget.recipe.recipeHealthScore ?? 0} HS",
                  style: const TextStyle(
                    color: Color(0xff868686),
                    fontSize: 12,
                    fontFamily: "Inter",
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Image.asset("assets/dot.png", width: 20),
                Icon(Icons.timer, size: 20, color: Color(0xff868686)),
                Flexible(
                  child: Text(
                    "${widget.recipe.recipeTime ?? 0} min",
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Color(0xff868686),
                      fontSize: 12,
                      fontFamily: "Inter",
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 15),

          Container(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            decoration: BoxDecoration(
              color: recipePalette[index],
              borderRadius: BorderRadius.circular(15),
            ),
            child: Center(
              child: Text(
                widget.recipe.recipeCategory ?? "",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
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

  Future<void> _onHeartTap() async {
    final id = widget.recipe.recipeId;
    if (id == null) return;
    await LocalAuthService.toggleFavorite(id);
    setState(() => isFav = !isFav);
  }
}
