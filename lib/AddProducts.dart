import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import 'ProductListActivity.dart';
class AddProducts extends StatefulWidget{
  _AddProductsState createState()=>_AddProductsState();
}

class _AddProductsState extends State<AddProducts>{
  TextEditingController etName = new TextEditingController();
  TextEditingController etOfferprice = new TextEditingController();
  TextEditingController etPrice = new TextEditingController();
  TextEditingController etSpecification1 = new TextEditingController();
  TextEditingController etSpecification2 = new TextEditingController();
  TextEditingController etdescription = new TextEditingController();
  final RoundedLoadingButtonController _btnController = new RoundedLoadingButtonController();
  File uploadimage;
  bool visible = true ;
  bool _validate = false;
  String image_name="",file_extension="",product_name="",p_off_price="",p_price="",p_spec1="",p_spec2="",p_desc="";
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Stack(
            children:<Widget>[
              Container(
                margin: EdgeInsets.only(left: 0.0,right: 0.0,top: 0.0,bottom: 0.0),
                width: double.infinity,

                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(0.0),
                      bottomRight: Radius.circular(0.0),),
                    gradient: LinearGradient(
                      //colors: [Colors.pink[800],Colors.black54],
                        colors: [
                          Colors.white,
                          Colors.orange],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight
                    ),
                    boxShadow: [
                      BoxShadow(
                        color:Colors.grey[800],
                        blurRadius: 1,
                        offset:Offset(0,1),
                      )
                    ]
                ),
                child: Container(
                  margin: EdgeInsets.only(left: 0.0,right: 0.0,top: 50.0,bottom: 10.0),
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Image.asset("assets/images/ecommerce.png",width: 100.0,height: 100.0,),
                        SizedBox(
                          height: 10.0,
                        ),

                        Text(
                            "Add Products",
                            style: GoogleFonts.josefinSans(
                              textStyle: Theme.of(context).textTheme.display1,
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: Colors.black54,)
                        ),


                        SizedBox(
                          height: 10.0,
                        ),


                      ],
                    ),
                  ),

                ),
              ),
              SingleChildScrollView(
                child:Container(
                  margin: EdgeInsets.only(top: 200.0),
                  child:Container(
                    margin: EdgeInsets.only(left: 0.0,right: 0.0,top: 0.0,bottom: 0.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30.0),
                          topRight: Radius.circular(30.0),),
                        gradient: LinearGradient(
                          //colors: [Colors.pink[800],Colors.black54],
                            colors: [
                              Colors.white,
                              Colors.white],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight
                        ),
                        boxShadow: [
                          BoxShadow(
                            color:Colors.grey[800],
                            blurRadius: 1,
                            offset:Offset(0,1),
                          )
                        ]
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical:10.0),
                      child: Column(
                        children: [

                          Container(
                            height: 2.0,
                            width: 50.0,
                            color: Colors.blueGrey,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [

                              SizedBox(height: 25.0,),
                              new TextFormField(
                                decoration: new InputDecoration(
                                  labelText: "Product Name",
                                  fillColor: Colors.white,
                                  border: new OutlineInputBorder(
                                    borderRadius: new BorderRadius.circular(10.0),
                                    borderSide: new BorderSide(
                                    ),
                                  ),
                                  //fillColor: Colors.green
                                ),
                                controller: etName,
                                keyboardType: TextInputType.name,
                                maxLength: 30,
                                style: new TextStyle(
                                    fontFamily: "Poppins",
                                    color: Colors.black54
                                ),
                              ),
                              SizedBox(height: 10.0,),
                              new TextFormField(
                                decoration: new InputDecoration(
                                  labelText: "Offer Price",
                                  fillColor: Colors.white,
                                  border: new OutlineInputBorder(
                                    borderRadius: new BorderRadius.circular(10.0),
                                    borderSide: new BorderSide(
                                    ),
                                  ),
                                  //fillColor: Colors.green
                                ),
                                controller: etOfferprice,
                                keyboardType: TextInputType.number,
                                maxLength: 10,
                                style: new TextStyle(
                                    fontFamily: "Poppins",
                                    color: Colors.black54
                                ),
                              ),
                              SizedBox(height: 10.0,),
                              new TextFormField(
                                decoration: new InputDecoration(
                                  labelText: "Price",
                                  fillColor: Colors.white,
                                  border: new OutlineInputBorder(
                                    borderRadius: new BorderRadius.circular(10.0),
                                    borderSide: new BorderSide(
                                    ),
                                  ),
                                  //fillColor: Colors.green
                                ),
                                controller: etPrice,
                                keyboardType: TextInputType.number,
                                maxLength: 10,
                                style: new TextStyle(
                                    fontFamily: "Poppins",
                                    color: Colors.black54
                                ),
                              ),
                              SizedBox(height: 10.0,),
                              new TextFormField(
                                decoration: new InputDecoration(
                                  labelText: "Specification 1",
                                  fillColor: Colors.white,
                                  border: new OutlineInputBorder(
                                    borderRadius: new BorderRadius.circular(10.0),
                                    borderSide: new BorderSide(
                                    ),
                                  ),
                                  //fillColor: Colors.green
                                ),
                                controller: etSpecification1,
                                keyboardType: TextInputType.emailAddress,
                                maxLength: 40,
                                style: new TextStyle(
                                    fontFamily: "Poppins",
                                    color: Colors.black54
                                ),
                              ),
                              SizedBox(height: 10.0,),
                              new TextFormField(
                                decoration: new InputDecoration(
                                  labelText: "Specification 2",
                                  fillColor: Colors.white,
                                  border: new OutlineInputBorder(
                                    borderRadius: new BorderRadius.circular(10.0),
                                    borderSide: new BorderSide(
                                    ),
                                  ),
                                  //fillColor: Colors.green
                                ),
                                controller: etSpecification2,
                                keyboardType: TextInputType.text,
                                maxLength: 40,
                                style: new TextStyle(
                                    fontFamily: "Poppins",
                                    color: Colors.black54
                                ),
                              ),
                              SizedBox(height: 10.0,),
                              new TextFormField(
                                decoration: new InputDecoration(
                                  labelText: "Description",
                                  fillColor: Colors.white,
                                  border: new OutlineInputBorder(
                                    borderRadius: new BorderRadius.circular(10.0),
                                    borderSide: new BorderSide(
                                    ),
                                  ),
                                  //fillColor: Colors.green
                                ),
                                controller: etdescription,
                                keyboardType: TextInputType.text,
                                maxLength: 200,
                                maxLines: 3,
                                style: new TextStyle(
                                    fontFamily: "Poppins",
                                    color: Colors.black54
                                ),
                              ),
                              SizedBox(height: 20.0,),
                              Container(  //show image here after choosing image
                                  child:uploadimage == null?
                                  Container(): //if uploadimage is null then show empty container
                                  Container(   //elese show image here
                                      child: SizedBox(
                                          width: 150,
                                          height:150,
                                          child:Image.file(uploadimage) //load image from file
                                      )
                                  )
                              ),
                              Container(
                                child: RaisedButton.icon(
                                  onPressed: (){
                                    chooseImage(); // call choose image function
                                  },
                                  icon:Icon(Icons.folder_open),
                                  label: Text("Choose Image"),
                                  color: Colors.deepOrangeAccent,
                                  colorBrightness: Brightness.dark,
                                ),
                              ),
                              SizedBox(height: 22,),
                              Container(
                                margin: EdgeInsets.only(right: 25.0),
                                width: MediaQuery.of(context).size.width,
                                alignment: Alignment.bottomRight,
                                child:FloatingActionButton(
                                  child: Icon(Icons.navigate_next),
                                  backgroundColor: Colors.green,
                                  foregroundColor: Colors.white,
                                  onPressed: (){
                                    _doSomething();
                                  },
                                ),
                              ),
                              SizedBox(height: 50.0,),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  // ),
                ),
              ),
            ]
        ),
      ),
    );
  }
  Future<void> chooseImage() async {
    //File choosedimage = (await ImagePicker().getImage(source: ImageSource.gallery)) as File;
    final pickedFile = await ImagePicker().getImage(source: ImageSource.gallery);
    final File file = File(pickedFile.path);
    //set source: ImageSource.camera to get image from camera
    var completePath =pickedFile.path;
    var fileName = (completePath.split('/').last);
    var extension="."+(fileName.split(".").last);
    var filePath = completePath.replaceAll("/$fileName", '');
    print("file_name    "+fileName);
    print("file_path   "+filePath);
    print("extension  "+extension);
    setState(() {
      file_extension=extension;
      uploadimage = file;
    });
  }
  Future<void> uploadImage() async {
    //show your own loading or progressing code here
    String uploadurl = "URL"+"upload_img.php";

    try{
      print(uploadimage);
      List<int> imageBytes = uploadimage.readAsBytesSync();
      print(imageBytes);/*uploadimage.readAsBytesSync();*/
      String baseimage = base64Encode(imageBytes);
      print("image_sroew"+product_name);
      DateTime now = DateTime.now();
      String formattedDate = DateFormat('yyyyMMdd_kkmmss').format(now);
      print("IMG_"+formattedDate);

      var response = await http.post(
          uploadurl,
          body: {
            'image': baseimage,
            'product_name':product_name,
            'offer':p_off_price,
            'price':p_price,
            'spec':p_spec1,
            'specfi':p_spec2,
            'desc':p_desc,
            'image_name':"IMG_"+formattedDate+file_extension,
          }
      );
      print(response.statusCode);
      if(response.statusCode == 200){
        var jsondata = json.decode(response.body); //decode json data
        if(jsondata["error"]){ //check error sent from server
          print(jsondata["msg"]);
          //if error return from server, show message from server
        }else{
          Navigator.of(context).pop();
          foo();
          print("Upload successful");
        }
      }else{
        print("Error during connection to server");
        //there is error during connecting to server,
        //status code might be 404 = url not found
      }
    }catch(e){
      print(e);
      print("Error during converting to Base64");
      //there is error during converting file image to base64 encoding.
    }
  }

  void _doSomething() async {

    setState(() {
      visible=true;
      etName.text.isEmpty ? _validate = true : _validate = false;
    });
    Timer(Duration(seconds: 3), () {
        product_name = etName.text;
        p_off_price=etOfferprice.text;
        p_price= etPrice.text;
        p_spec1= etSpecification1.text;
        p_spec2= etSpecification2.text;
        p_desc=etdescription.text;
        print("I'm here!!!  " + etName.text);
        uploadImage();
    });
  }

  foo() async {
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Successful"),
        content: Text("Image Uploaded Successfully"),
        actions: [
          new FlatButton(
              child: new Text("OK"),
              onPressed: () => {
                //Navigator.pop(context),
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (BuildContext ctx) => ProductListActivity())),
              }
          ),
        ],
      ),
    );
    Navigator.pop(context);
  }

  loadProgress(){
    if(visible == true){
      setState(() {
        visible = false;
      });
    }
    else{
      setState(() {
        visible = true;
      });
    }

  }
}