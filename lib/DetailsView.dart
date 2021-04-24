import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
class DetailsView extends StatefulWidget{
  final String id;
  DetailsView({this.id});
  _DetailsViewState createState()=>_DetailsViewState();
}


class _DetailsViewState extends State<DetailsView>{
  String product_name,p_off_price,p_price,p_spec1,p_spec2,p_desc,img;
  var data;
  RegExp reg = new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
  Function mathFunc = (Match match) => '${match[1]},';
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
                            "Products Details",
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
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
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
                              Image.network("URL"+'$img',width: MediaQuery.of(context).size.width,height: 200.0,),
                              SizedBox(height: 25.0,),
                              Container(
                                child:new Text('$product_name',textAlign: TextAlign.center,
                                  style: new TextStyle(
                                      fontFamily: "Poppins",
                                      color: Colors.black54,
                                      fontSize: 24.0
                                  ),
                                ),
                              ),

                              SizedBox(height: 10.0,),
                              Row(
                                children: [
                                  new Text("Special Price\n ₹."+'$p_off_price'.replaceAllMapped(reg, mathFunc),
                                    style: new TextStyle(
                                        fontFamily: "Poppins",
                                        color: Colors.black54,
                                        fontSize: 24.0
                                    ),
                                  ),
                                  Spacer(),
                                  new Text('$p_price',
                                    style: new TextStyle(
                                        fontFamily: "Poppins",
                                        color: Colors.black54
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10.0,),
                              new Text("Basic Features:\n"+'$p_spec1',textAlign: TextAlign.start,
                                style: new TextStyle(
                                    fontFamily: "Poppins",
                                    color: Colors.black54,fontSize: 18.0
                                ),
                              ),
                              SizedBox(height: 20.0,),
                              new Text("Other Features: "+'$p_spec2',textAlign: TextAlign.start,
                                style: new TextStyle(
                                    fontFamily: "Poppins",
                                    color: Colors.black54,fontSize: 18.0
                                ),
                              ),
                              SizedBox(height: 10.0,),
                              new Text("Description : \n\n"+'$p_desc',textAlign: TextAlign.start,
                                maxLines: 3,
                                style: new TextStyle(
                                    fontFamily: "Poppins",
                                    color: Colors.black,fontSize: 20.0
                                ),
                              ),
                              SizedBox(height: 20.0,),
                             /* Container(
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
                              ),*/
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
  @override
  void initState() {
    // TODO: implement initState
    _fetch_value();
    super.initState();

  }

  _fetch_value() async{
    final response=await http.post(
        "URL"+"fetch_listview.php",
            body:{
          'id':widget.id,
    });
    if(response.statusCode==200){
      final map=json.decode(response.body);
      final users=map["result"];
      setState(() {
        this.data=users;
        data.forEach((element) {
          product_name = element["productName"];
          p_off_price = element["offerPrice"];
          p_price = element["price"];
          p_spec1 = element["specificationOne"];
          p_spec2 = element["specificationTwo"];
          p_desc = element["productDescription"];
          img = element["imageName"];
          print(product_name + " valueee");
        });
      });
    }
  }
}