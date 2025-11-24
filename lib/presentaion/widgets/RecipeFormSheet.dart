import 'package:flutter/material.dart';
import 'package:recipe_book_application/data/models/recipeModel.dart';
import 'package:recipe_book_application/presentaion/widgets/customTextFieldWidget.dart';

class RecipeFormSheet extends StatefulWidget {
  final Recipemodel? recipe;

  const RecipeFormSheet({super.key, this.recipe});

  @override
  State<RecipeFormSheet> createState() => _RecipeFormSheetState();
}

class _RecipeFormSheetState extends State<RecipeFormSheet> {
  final formKey = GlobalKey<FormState>();

  final title = TextEditingController();
  final image = TextEditingController();
  final dishType = TextEditingController();
  final readyMinutes = TextEditingController();
  final summary = TextEditingController();

  @override
  void initState() {
    super.initState();
    final r = widget.recipe;
    title.text = r?.recipeName ?? "";
    image.text = r?.recipeImage ?? "";
    dishType.text = r?.recipeCategory ?? "";
    readyMinutes.text = r?.recipeTime?.toString() ?? "";
    summary.text = r?.recipeDescription ?? "";
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.recipe != null;

    return Container(
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
        top: 16,
        bottom: MediaQuery.of(context).viewInsets.bottom + 16,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: Offset(0, -4),
          ),
        ],
      ),
      child: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40,
                height: 4,
                margin: EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(20),
                ),
              ),

              Text(
                isEdit ? "Edit Recipe" : "Add Recipe",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  fontFamily: "Inter",
                ),
              ),
              SizedBox(height: 16),

              Container(
                padding: EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: const Color(0xFFF7F9FA),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.grey.shade200, width: 1),
                ),
                child: Column(
                  children: [
                    Customtextfield(
                      hintName: "Title",
                      controller: title,
                      isPassword: false,
                      validator: (v) =>
                          v == null || v.trim().isEmpty ? "Required" : null,
                    ),
                    SizedBox(height: 12),

                    Customtextfield(
                      hintName: "Image URL",
                      controller: image,
                      isPassword: false,
                      validator: (v) => null,
                    ),
                    SizedBox(height: 12),

                    Row(
                      children: [
                        Expanded(
                          child: Customtextfield(
                            hintName: "Dish Type",
                            controller: dishType,
                            isPassword: false,
                            validator: (v) => null,
                          ),
                        ),
                        SizedBox(width: 12),
                        Expanded(
                          child: Customtextfield(
                            hintName: "Ready in minutes",
                            controller: readyMinutes,
                            isPassword: false,
                            validator: (v) => null,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 12),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Notes",
                        style: TextStyle(
                          fontFamily: "Inter",
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                    SizedBox(height: 6),
                    Container(
                      height: 130,
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: Colors.grey.shade300,
                          width: 1,
                        ),
                      ),
                      child: TextFormField(
                        controller: summary,
                        maxLines: null,
                        expands: true,
                        keyboardType: TextInputType.multiline,
                        decoration: InputDecoration(
                          hintText: "Write your notes, ingredients or steps...",
                          hintStyle: TextStyle(
                            fontFamily: "Inter",
                            fontSize: 13,
                            color: Colors.grey,
                          ),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (!formKey.currentState!.validate()) return;
                    final model = Recipemodel(
                      recipeId: widget.recipe?.recipeId,
                      recipeName: title.text.trim(),
                      recipeImage: image.text.trim(),
                      recipeCategory: dishType.text.trim().isEmpty
                          ? "not specified"
                          : dishType.text.trim(),
                      recipeTime: int.tryParse(readyMinutes.text.trim()) ?? 0,
                      recipeDescription: summary.text.trim(),
                      recipeHealthScore: widget.recipe?.recipeHealthScore ?? 0,
                      recipeAggregateLikes:
                          widget.recipe?.recipeAggregateLikes ?? 0,
                    );
                    Navigator.pop(context, model);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF00B4BF),
                    padding: EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    isEdit ? "Save Changes" : "Add Recipe",
                    style: TextStyle(
                      fontFamily: "Inter",
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
