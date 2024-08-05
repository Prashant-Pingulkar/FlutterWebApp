class Breed {
  final String name;
  final String bredFor;
  final String breedGroup;
  final String lifeSpan;
  final String temperament;
  final String url;

  Breed({required this.name, required this.bredFor,required this.breedGroup,required this.lifeSpan,required this.temperament,required this.url});

  factory Breed.fromJson(Map<String, dynamic> json,url) {
    return Breed(
      name: json['name']??"",
      bredFor: json['bred_for'] ?? '',
      breedGroup: json['breed_group']??'',
      lifeSpan: json['life_span']??'',
      temperament: json['temperament']??'',
        url: url??''

    );
  }
}
