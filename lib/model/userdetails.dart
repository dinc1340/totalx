

class UserData {
  final String image;
  
  final String name;
  final int age;

  UserData({
    required this.image,
  
    required this.name,
    required this.age,
  });
}


List<UserData> userslist = [
  UserData(
      image: "asset/images/martin.png", name: "Martin Dokidis", age: 34),
  UserData(
      image: "asset/images/marylin.png", name: "Marilyn Rosser", age: 34),
  UserData(
      image: "asset/images/cristofer.png", name: "Cristofer Lipshutz", age: 34),
  UserData(
      image: "asset/images/wilson botosh.png", name: "Wilson Botosh", age: 34),
  UserData(image: "asset/images/anika.png", name: "Anika Saris", age: 34),
  UserData(
      image: "asset/images/phillip.png", name: "Phillip Gouse", age: 34),
  UserData(
      image: "asset/images/wilson bergson.png",
      name: "Wilson Bergson",
      age: 34),
];
