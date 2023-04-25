
// This controller is used for e.g when database is empty then it will send message to category screen with imageleft = false

class ImageController{
  static final ImageController _data = ImageController._internal();

  bool? imageleft = true;

  factory ImageController(){
    return _data;
  }

  ImageController._internal(){

  }
}