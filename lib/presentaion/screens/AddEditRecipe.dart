import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:recipe_book_application/data/models/recipemodel.dart';

class AddEditRecipe extends StatefulWidget {
  final Recipemodel? recipe;
  AddEditRecipe({super.key, this.recipe});

  @override
  State<AddEditRecipe> createState() => AddEditRecipeState();
}

class AddEditRecipeState extends State<AddEditRecipe> {
  final formKey = GlobalKey<FormState>();

  final title = TextEditingController();
  final image = TextEditingController();
  final dishType = TextEditingController();
  final healthScore = TextEditingController();
  final readyMinutes = TextEditingController();
  final likes = TextEditingController();
  final summary = TextEditingController();

  bool showImage = false;

  @override
  void initState() {
    super.initState();
    final r = widget.recipe;

    title.text = r?.recipeName ?? '';
    image.text = r?.recipeImage ?? '';
    dishType.text = r?.recipeCategory ?? "";
    healthScore.text = (r?.recipeHealthScore ?? 0).toString();
    readyMinutes.text = (r?.recipeTime ?? 0).toString();
    likes.text = (r?.aggregateLikes ?? 0).toString();
    summary.text = r?.recipeDescription ?? "";

    showImage = image.text.trim().isNotEmpty;
  }

  void save() {
    if (!formKey.currentState!.validate()) return;

    final model = Recipemodel(
      recipeId: widget.recipe?.recipeId,
      recipeName: title.text.trim(),
      recipeImage: image.text.trim(),
      recipeCategory: dishType.text.trim().isEmpty
          ? "not specified"
          : dishType.text.trim(),
      recipeHealthScore: double.tryParse(healthScore.text.trim()) ?? 0,
      recipeTime: int.tryParse(readyMinutes.text.trim()) ?? 0,
      recipeDescription: summary.text.trim(),
      aggregateLikes: int.tryParse(likes.text.trim()) ?? 0,
    );

    Navigator.pop(context, model);
  }

  InputDecoration inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      labelStyle: TextStyle(fontFamily: "Inter"),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: Color(0xFF00B4BF), width: 2),
      ),
      contentPadding: EdgeInsets.symmetric(horizontal: 14, vertical: 12),
    );
  }

  @override
  Widget build(BuildContext context) {
    const titleText = "Add / Edit Recipe";

    return SafeArea(
      child: ListView(
        padding: EdgeInsets.fromLTRB(16, 16, 16, 24),
        children: [
          Padding(
            padding: EdgeInsets.only(top: 6, bottom: 10),
            child: Center(
              child: Text(
                titleText,
                style: TextStyle(
                  fontFamily: "Inter",
                  fontWeight: FontWeight.w700,
                  fontSize: 22,
                  color: Colors.black,
                ),
              ),
            ),
          ),

          SizedBox(height: 12),

          Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AnimatedCrossFade(
                  firstChild: SizedBox.shrink(),
                  secondChild: Container(
                    width: double.infinity,
                    height: 180,
                    decoration: BoxDecoration(
                      color: Color(0xFFF7F9FA),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: image.text.trim().isEmpty
                        ? Center(
                            child: Text(
                              "No image",
                              style: TextStyle(
                                fontFamily: "Inter",
                                color: Colors.grey,
                              ),
                            ),
                          )
                        : Image.network(
                            image.text.trim(),
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) => Center(
                              child: Text(
                                "Invalid image URL",
                                style: TextStyle(fontFamily: "Inter"),
                              ),
                            ),
                          ),
                  ),
                  crossFadeState: showImage
                      ? CrossFadeState.showSecond
                      : CrossFadeState.showFirst,
                  duration: Duration(milliseconds: 220),
                ),

                SizedBox(height: 12),

                TextFormField(
                  controller: title,
                  decoration: inputDecoration("Title"),
                  validator: (v) =>
                      v == null || v.trim().isEmpty ? "Required" : null,
                  textInputAction: TextInputAction.next,
                ),

                SizedBox(height: 12),

                TextFormField(
                  controller: image,
                  decoration: inputDecoration("Image URL"),
                  onChanged: (v) =>
                      setState(() => showImage = v.trim().isNotEmpty),
                  textInputAction: TextInputAction.next,
                ),

                SizedBox(height: 16),

                Text(
                  "Details",
                  style: TextStyle(
                    fontFamily: "Inter",
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 8),

                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: dishType,
                        decoration: inputDecoration("Dish Type"),
                        textInputAction: TextInputAction.next,
                      ),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: TextFormField(
                        controller: readyMinutes,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        decoration: inputDecoration("Ready (min)"),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 12),

                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: healthScore,
                        keyboardType: TextInputType.numberWithOptions(
                          decimal: true,
                        ),
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                            RegExp(r'^\d*\.?\d{0,2}'),
                          ),
                        ],
                        decoration: inputDecoration("Health Score"),
                      ),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: TextFormField(
                        controller: likes,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        decoration: inputDecoration("Likes"),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 16),

                Text(
                  "Summary",
                  style: TextStyle(
                    fontFamily: "Inter",
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 8),

                TextFormField(
                  controller: summary,
                  maxLines: 5,
                  decoration: inputDecoration("Write a short summary"),
                ),

                SizedBox(height: 20),

                ElevatedButton.icon(
                  onPressed: save,
                  icon: Icon(Icons.check_rounded),
                  label: Text(
                    widget.recipe != null ? "Save Changes" : "Add Recipe",
                    style: TextStyle(fontFamily: "Inter"),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 248, 242, 196),
                    foregroundColor: Colors.black,
                    minimumSize: Size.fromHeight(48),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 0,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
