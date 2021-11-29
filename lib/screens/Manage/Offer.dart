// ignore_for_file: file_names, non_constant_identifier_names

class Offer {
  final String name,time,date,start,destination,image,pname1,pname2,pimage1,pimage2;
  final List <String> pname,pimage;

  Offer({
    required this.name,
    required this.time,
    required this.date,
    required this.start,
    required this.destination,
    required this.image,
    required this.pname1,
    required this.pname2,
    required this.pimage1,
    required this.pimage2,
    required this.pname,
    required this.pimage,
  });
}

List <dynamic> offerdata = [
  Offer(
    name: "Desmond Chieng",
    time: "12:00 am",
    date: "25/11/2021",
    start: "Taman ABC",
    destination: "Taman DEF",
    image:"assets/image/desmond.jpg",
    pname1: "BLA BLA BLA",
    pname2: "BA BA BA",
    pimage1: "assets/image/cat1.jpg",
    pimage2: "assets/image/winson.jpg",
    pname: ["BLA BLA BLA","BA BA BA"],
    pimage: ["assets/image/cat1.jpg","assets/image/winson.jpg"],
  ),

  Offer(
    name: "Kong Hao Yang",
    time: "1:00 pm",
    date: "27/11/2021",
    start: "Taman ABC",
    destination: "Taman DEF",
    image:"assets/image/cat1.jpg",
    pname1: "BLAA BLAA BLAA",
    pname2: "BAA BAA BAA",
    pimage1: "assets/image/desmond.jpg",
    pimage2: "assets/image/winson.jpg",
    pname: ["BLA BLA BLA","BA BA BA"],
    pimage: ["assets/image/cat1.jpg","assets/image/winson.jpg"],
  ),

  Offer(
    name: "Winson",
    time: "2:00 pm",
    date: "29/11/2021",
    start: "Taman ABC",
    destination: "Taman DEF",
    image:"assets/image/winson.jpg",
    pname1: "BLAAA BLAAA BLAAA",
    pname2: "BAAA BAAA BAAA",
    pimage1: "assets/image/cat1.jpg",
    pimage2: "assets/image/desmond.jpg",
    pname: ["BLA BLA BLA","BA BA BA"],
    pimage: ["assets/image/cat1.jpg","assets/image/winson.jpg"],
  )

];
