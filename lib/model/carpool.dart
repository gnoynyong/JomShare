
class CarpoolObject {
   String datetime,start,destination,vehicletype,plateNo,type,repeatedDay,pooldocid,hostid;
  // final List <String> pname,pimage;
   var price;
   int seatno;
   List<String> requestid=[];
   List<String> requeststatus=[];
   String poolstatus="";
   List <String> passengerFeedbackDocList=[];
   String hostFeedbackDoc="";
  CarpoolObject(
    {
      required this.hostid,
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
    required this.pooldocid,
    required this.seatno,

    }
  );
  void addRequestIDWithStatus (List <dynamic> id,List <dynamic>status)
  {
    for (int m=0;m<id.length;m++)
    {
      requestid.add(id[m].toString());
      requeststatus.add(status[m].toString());
    }

  }
  void setPoolStatus (String status)
  {
    this.poolstatus=status;
  }
  void setPassengerFeedbackIDList (List <dynamic> feedbackIDList)
  {
    for (int m=0;m<feedbackIDList.length;m++)
    {
      passengerFeedbackDocList.add(feedbackIDList[m].toString());
    }
  }
  void setHostFeedbackID (String id)
  {
    hostFeedbackDoc=id;
  }


}