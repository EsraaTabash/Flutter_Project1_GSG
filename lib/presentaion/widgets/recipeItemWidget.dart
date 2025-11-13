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
    const palette = [
      Color(0xFFFF8A65),
      Color(0xFFFFC107),
      Color(0xFF81C784),
      Color(0xFF64B5F6),
      Color(0xFFF06292),
      Color(0xFFFFB74D),
    ];

    final idx = (widget.recipe.recipeId ?? 0) % palette.length;
    final accent = palette[idx];

    final r = widget.recipe;

    return InkWell(
      onTap: () {},
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.black12)),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                r.recipeImage!,
                width: 80,
                height: 70,
                fit: BoxFit.cover,
              ),
            ),

            SizedBox(width: 12),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    r.recipeName ?? "",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontFamily: "Inter",
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),

                  SizedBox(height: 6),

                  Row(
                    children: [
                      Icon(Icons.timer, size: 15, color: Colors.grey),
                      SizedBox(width: 4),
                      Text(
                        "${r.recipeTime ?? 0} min",
                        style: TextStyle(fontSize: 12, color: Colors.black87),
                      ),

                      SizedBox(width: 10),

                      Icon(Icons.monitor_heart, size: 15, color: Colors.grey),
                      SizedBox(width: 4),
                      Text(
                        "${r.recipeHealthScore ?? 0} HS",
                        style: TextStyle(fontSize: 12, color: Colors.black87),
                      ),
                    ],
                  ),

                  SizedBox(height: 6),

                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: accent.withOpacity(.25),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      r.recipeCategory ?? "not specified",
                      style: TextStyle(
                        fontSize: 12,
                        color: accent,
                        fontFamily: "Inter",
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(width: 6),

            InkWell(
              onTap: _onHeartTap,
              child: Icon(
                isFav ? Icons.favorite : Icons.favorite_border,
                color: isFav ? Colors.redAccent : Colors.black54,
                size: 22,
              ),
            ),
          ],
        ),
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
