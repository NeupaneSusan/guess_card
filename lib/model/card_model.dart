class CardModel {
  String imagePath;
  int title;
  bool isClick;
  bool isMatch;
  CardModel(
      {required this.title,
      required this.isClick,
      required this.isMatch,
      required this.imagePath});

  @override
  String toString() {
    return 'Cardmodel(title: $title, isClick: $isClick, isMatch: $isMatch, imagePath: $imagePath)';
  }
}
