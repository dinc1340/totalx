class UsersListModel {
  final String image;
  final String name;
  final int age;

  UsersListModel({
    required this.image,
    required this.name,
    required this.age,
  });
}

List<UsersListModel> userslist = [
  UsersListModel(
      image: "asset/images/martin.png", name: "Martin Dokidis", age: 34),
  UsersListModel(
      image: "asset/images/marylin.png", name: "Marilyn Rosser", age: 34),
  UsersListModel(
      image: "asset/images/cristofer.png", name: "Cristofer Lipshutz", age: 34),
  UsersListModel(
      image: "asset/images/wilson botosh.png", name: "Wilson Botosh", age: 34),
  UsersListModel(image: "asset/images/anika.png", name: "Anika Saris", age: 34),
  UsersListModel(
      image: "asset/images/phillip.png", name: "Phillip Gouse", age: 34),
  UsersListModel(
      image: "asset/images/wilson bergson.png",
      name: "Wilson Bergson",
      age: 34),
];
