// this controller is used to check if user clicked on category or not


class DataController{
  static final DataController _data = DataController._internal();

  bool? clicked = false;


  factory DataController(){
    return _data;
  }

  DataController._internal(){

  }
}