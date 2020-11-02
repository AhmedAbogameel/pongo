class PetModel {
  int age;
  String description;
  bool isMale;
  String kind;
  String petName;
  String photoUrl;
  int publishAt;
  String userId;
  bool isCat;

  PetModel(
      {this.age,
        this.description,
        this.isMale,
        this.kind,
        this.petName,
        this.photoUrl,
        this.publishAt,
        this.userId,
        this.isCat,
      });

  PetModel.fromJson(Map<String, dynamic> json) {
    age = json['age'];
    description = json['description'];
    isMale = json['isMale'];
    kind = json['kind'];
    petName = json['petName'];
    photoUrl = json['photoUrl'];
    publishAt = json['publishAt'];
    userId = json['userId'];
    isCat = json['isCat'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['age'] = this.age;
    data['description'] = this.description;
    data['isMale'] = this.isMale;
    data['kind'] = this.kind;
    data['petName'] = this.petName;
    data['photoUrl'] = this.photoUrl;
    data['publishAt'] = this.publishAt;
    data['userId'] = this.userId;
    data['isCat'] = this.isCat;
    return data;
  }
}