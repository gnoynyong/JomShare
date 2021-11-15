class Chat{
  final String name, lastMessage, image, time;
  final bool isActive;

  Chat({
   required this.name,
   required this.lastMessage,
   required this.image,
   required this.time,
   required this.isActive,
  });
}

//below is hard code data , later we will get all data from firebase and do it , hope it can done so
List <dynamic> chatsData = [
  Chat(
    name:"Kong Hao Yang",
    lastMessage: "Hi I am Hao Yang",
    image:"assets/image/cat1.jpg",
    time:"3m ago",
    isActive:true,
  ),
  Chat(
    name:"Desmond Chieng",
    lastMessage: "Am I cute?",
    image:"assets/image/desmond.jpg",
    time:"3m ago",
    isActive:false,
  ),
  Chat(
    name:"See Wen Xiang",
    lastMessage: "Hello World?",
    image:"assets/image/winson.jpg",
    time:"5m ago",
    isActive:false,
  ),
   Chat(
    name:"Kong Hao Yang",
    lastMessage: "Hi I am Hao Yang",
    image:"assets/image/cat1.jpg",
    time:"3m ago",
    isActive:true,
  ),
  Chat(
    name:"Desmond Chieng",
    lastMessage: "Am I cute?",
    image:"assets/image/desmond.jpg",
    time:"3m ago",
    isActive:false,
  ),
  Chat(
    name:"See Wen Xiang",
    lastMessage: "Hello World?",
    image:"assets/image/winson.jpg",
    time:"5m ago",
    isActive:false,
  ),
  Chat(
    name:"Kong Hao Yang",
    lastMessage: "Hi I am Hao Yang",
    image:"assets/image/cat1.jpg",
    time:"3m ago",
    isActive:true,
  ),
  Chat(
    name:"Desmond Chieng",
    lastMessage: "Am I cute?",
    image:"assets/image/desmond.jpg",
    time:"3m ago",
    isActive:false,
  ),
  Chat(
    name:"See Wen Xiang",
    lastMessage: "Hello World?",
    image:"assets/image/winson.jpg",
    time:"5m ago",
    isActive:false,
  ),
];