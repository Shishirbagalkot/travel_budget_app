//models the data
class Trip {
  String title;
  DateTime startDate;
  DateTime endDate;
  double budget;
  String travelType;

  Trip(this.title, this.startDate, this.endDate, this.budget, this.travelType);

  //function to convert Trip class into JSON
  Map<String, dynamic> toJson() =>{
    'title': title,
    'startDate': startDate,
    'endDate': endDate,
    'budget': budget,
    'traveltype': travelType,
  };
}