class Recipemodel {
  int? recipeId;
  String? recipeName;
  String? recipeImage;
  String? recipeCategory;
  //int? recipeIngredientsCount;
  double? recipeHealthScore;
  int? recipeTime;
  String? recipeDescription;

  Recipemodel({
    this.recipeId,
    this.recipeName,
    this.recipeImage,
    this.recipeCategory,
    //this.recipeIngredientsCount,
    this.recipeHealthScore,
    this.recipeTime,
    this.recipeDescription,
  });

  factory Recipemodel.fromJson(Map<String, dynamic> json) {
    final dishTypes = json['dishTypes'] as List? ?? [];
    //final ingredients = json['extendedIngredients'] as List? ?? [];

    return Recipemodel(
      recipeId: json['id'] ?? 0,
      recipeName: json['title'] ?? "",
      recipeImage: json['image'] ?? "",
      recipeCategory: dishTypes.isNotEmpty
          ? dishTypes.first.toString()
          : "not specified",
      //recipeIngredientsCount: ingredients.length,
      recipeHealthScore: json['healthScore'] ?? 0,
      recipeTime: json['readyInMinutes'] ?? 0,
      recipeDescription: json['summary'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': recipeId ?? 0,
      'title': recipeName ?? "",
      'image': recipeImage ?? "",
      'dishTypes': [recipeCategory ?? "not specified"],
      //'extendedIngredients': List.filled(recipeIngredientsCount ?? 0, {}),
      'healthScore': recipeHealthScore ?? 0,
      'readyInMinutes': recipeTime ?? 0,
      'summary': recipeDescription ?? "",
    };
  }
}
