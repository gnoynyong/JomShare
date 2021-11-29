class Passenger{
  final String name,image;
  final bool isAccepted;

  Passenger({
    required this.name,
    required this.image,
    required this.isAccepted,
  });
}

List<dynamic> PassengerData = [
  Passenger(
    name: "Kong Hao Yang",
    image: "assets/image/cat1.jpg",
    isAccepted: true,
  ),
  Passenger(
    name: "Desmond Chieng",
    image: "assets/image/desmond.jpg",
    isAccepted: false,
  )
];

