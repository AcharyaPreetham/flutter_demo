import 'dart:convert';

import 'package:assignment_flutter_app/DetailsView.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

import 'AddProducts.dart';

class ProductListActivity extends StatefulWidget{
  _ProductListActivityState createState()=>_ProductListActivityState();
}

class _ProductListActivityState extends State<ProductListActivity>{
  List data=new List();
  bool _isLoading = false;
  RegExp reg = new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
  Function mathFunc = (Match match) => '${match[1]},';
  @override
  void initState() {
    // TODO: implement initState
    _fetch_value();
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        /*appBar: AppBar(
          title: Text("Product List",textAlign: TextAlign.center,),
        ),*/
        body: Stack(
          children: [
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
                      Image.asset("assets/images/ecommerce.png",width: 80.0,height: 80.0,),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text(
                          "PRODUCTS LIST",
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
            Container(
              margin: EdgeInsets.only(top: 175.0),
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
                child:Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical:10.0),
                  child : new Center(
                      child:!_isLoading ? new CircularProgressIndicator() : new GridView.count(
                        crossAxisCount: 2,
                        crossAxisSpacing: 2.0,
                        mainAxisSpacing: 4.0,
                        children: List.generate(data.length, (index){
                          final v=this.data[index];
                          return GestureDetector(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>DetailsView(id:v['id'])));
                              },
                              child:Card(
                                  child:Center(
                                      child:Column(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          SizedBox(height: 5.0,),
                                          Expanded(child: Image.network("URL"+v["imageName"],width: MediaQuery.of(context).size.width,height: 130.0,)),
                                          SizedBox(height: 8.0,),
                                          Center(child: Text("₹."+v["offerPrice"].replaceAllMapped(reg, mathFunc)+"/-",style: GoogleFonts.josefinSans(
                                            textStyle: Theme.of(context).textTheme.display1,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w700,
                                            color: Colors.black,),
                                            textAlign: TextAlign.center,),),
                                          SizedBox(height:8.0,),
                                          Center(
                                            child:Text(v["productName"],style: GoogleFonts.josefinSans(
                                              textStyle: Theme.of(context).textTheme.display1,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black,),
                                              textAlign: TextAlign.center,),
                                          ),
                                          SizedBox(height:8.0,),
                                        ],
                                      )
                                  )
                              )
                          );
                        }),
                      )

                  ),


                ),
              ),
            ),
          ],
        ),
          floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add,color: Colors.white),
            backgroundColor:Color(0xffe46b10) ,
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => AddProducts()));
            },
          )
      ),
    );

  }

  _fetch_value() async{
    final response=await http.post(
      "URL"+"list.php"
    );
    if(response.statusCode==200){
        final map=json.decode(response.body);
        final users=map["result"];
        setState(() {
          _isLoading=true;
          this.data=users;
          print(data);
        });
    }
  }

}