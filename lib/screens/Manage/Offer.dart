// ignore_for_file: file_names, non_constant_identifier_names

class Offer {
   String datetime,start,destination,vehicletype,plateNo,type,repeatedDay,offerpoolid;
  // final List <String> pname,pimage;
   var price;
   List<dynamic> requestid=[];

  Offer({
    // required this.time,
    // required this.date,
    required this.datetime,
    required this.start,
    required this.destination,
    // required this.pname,
    // required this.pimage,
    required this.vehicletype,
    required this.plateNo,
    required this.price,
    required this.type,
    required this.repeatedDay,
    required this.offerpoolid,

  });
  void addRequest (List <dynamic>requestid)
  {
    this.requestid=requestid;
    print("test\n");
    print(this.requestid);
  }
}


// List <dynamic> offerdata = [
//   Offer(
//     name: "Desmond Chieng",
//     time: "12:00 am",
//     date: "25/11/2021",
//     start: "Taman ABC",
//     destination: "Taman DEF",
//     image:"assets/image/desmond.jpg",
//     pname: ["L1P1","L1P2"],
//     pimage: ["assets/image/cat1.jpg","assets/image/winson.jpg"],
//     vehicletype: "BMW",
//     plateNo: "ABC 123",
//     price: 4.50,
//     type: "One-Time",
//     repeatedDay: "",
//     contact: "012-3456789",
//   ),

//   Offer(
//     name: "Kong Hao Yang",
//     time: "1:00 pm",
//     date: "27/11/2021",
//     start: "Taman ABC",
//     destination: "Taman DEF",
//     image:"assets/image/cat1.jpg",
//     pname: ["L2P1","L2P2"],
//     pimage: ["assets/image/cat1.jpg","assets/image/winson.jpg"],
//     vehicletype: "Honda",
//     plateNo: "DEF 456",
//     price: 2.00,
//     type: "Frequent",
//     repeatedDay: "1/2/3",
//     contact: "098-7654321",
//   ),

//   Offer(
//     name: "Winson",
//     time: "2:00 pm",
//     date: "29/11/2021",
//     start: "Taman ABC",
//     destination: "Taman DEF",
//     image:"assets/image/winson.jpg",
//     pname: ["L3P1","L3P2"],
//     pimage: ["assets/image/cat1.jpg","assets/image/winson.jpg"],
//     vehicletype: "11 bus",
//     plateNo: "GHI 789",
//     price: 0,
//     type: "Frequent",
//     repeatedDay: "0/2/4",
//     contact: "012-121212129",
//   )

// ];
