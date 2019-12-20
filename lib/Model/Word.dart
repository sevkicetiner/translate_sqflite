

class Word {
  String table;
  String id;
  String orginalText;
  String translateText;
//  int range = 0;
//  int statu = 1;
//  String image = "";

  Word(this.orginalText, this.translateText);

  Word.fromMap(Map<String, dynamic> map){
    this.id = map["id"].toString();
    this.orginalText = map["original"];
    this.translateText = map["translate"];
  }

  Map<String, dynamic> toMap()  {
    var map = <String, dynamic> {
      "original": orginalText,
      "translate": translateText
    };

    return map;
  }

}