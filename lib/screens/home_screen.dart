import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jhunt/models/configuration.dart';
import 'package:jhunt/models/job.dart';
import 'package:jhunt/screens/screen2.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:shared_preferences/shared_preferences.dart';
class HomeScreen extends StatefulWidget {
  static const homeScreen = 'home-screen';
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double xOffset = 0;
  double yOffset = 0;
  double scaleFactor = 1;
  var keys;
  var values;
  bool isDrawerOpen = false;
  List<Job> jobList=[];
  Query ref;
@override
  void initState() {
    // TODO: implement initState
    super.initState();

    ref= FirebaseDatabase.instance.reference().child("jobs").orderByChild("companyname");
    ref.once().then((DataSnapshot dataSnapshot) {
      jobList.clear();
   keys=dataSnapshot.value.keys;
      values=dataSnapshot.value;

   //   Map<String, String> todos = {"todoTitle": todoTitle};
      for(var key in keys){

        Job data= new Job(
          values[key]['companyname'],
          values[key]['location'],
          values[key]['jobvacancy'],
          values[key]['contacts'],
          values[key]['category'],
          values[key]['requirements'],
          values[key]['key'],
          //key['key'],
        );

       jobList.add(data);
      }


      setState(() {
        //

      });
    });

  }
  @override
  Widget build(BuildContext context) {


    return AnimatedContainer(
        transform: Matrix4.translationValues(xOffset, yOffset, 0)
          ..scale(scaleFactor)..rotateY(isDrawerOpen? -0.5:0),
        duration: Duration(milliseconds: 250),

        decoration: BoxDecoration(
            color: Colors.grey[200],

            borderRadius: BorderRadius.circular(isDrawerOpen?40:0.0)

        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 50,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                   isDrawerOpen?IconButton(
                     icon: Icon(Icons.arrow_back_ios),
                     onPressed: (){
                       setState(() {
                         xOffset=0;
                         yOffset=0;
                         scaleFactor=1;
                         isDrawerOpen=false;

                       });
                     },

                   ): IconButton(
                        icon: Icon(Icons.menu),
                        onPressed: () {
                          setState(() {
                            xOffset = 230;
                            yOffset = 150;
                            scaleFactor = 0.6;
                            isDrawerOpen=true;
                          });
                        }),
                    Column(
                      children: [
                        Text('Location'),
                        Row(
                          children: [
                            Icon(
                              Icons.location_on,
                              color: primaryGreen,
                            ),
                            Text('Botswana'),
                          ],
                        ),
                      ],
                    ),
                    CircleAvatar()
                  ],
                ),
              ),
//resume header
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20,vertical: 15),
                margin: EdgeInsets.symmetric(vertical: 30,horizontal: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20)
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(Icons.search),
                    Text('Search for a job'),
                    Icon(Icons.settings)

                  ],
                ),
              ),
              GestureDetector(
                onTap: (){
                  //Navigator.push(context, MaterialPageRoute(builder: (context)=>Screen2()));

                },
                child: Container(
                  height: 240,
                  margin: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
                  child: Row(
                    children: [

                      Expanded(
                        child: Stack(
                          children: [
                            ClipRRect(
                              child: Container(
                                decoration: BoxDecoration(color: Colors.blueGrey[300],
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: shadowList,
                                ),
                                child: Image.asset('assets/working.jpg',fit: BoxFit.cover,
                                 ),
                               // margin: EdgeInsets.only(top: 50),
                              ),
                            ),
                            Align(
                              child: Hero(
                                  tag:1,child: Image.asset('assets/j2.png')),
                            )

                          ],
                        ),
                      ),
                      ClipRect(
                        child: Container(
                          //margin: EdgeInsets.only(top: 60,bottom: 20),
                          decoration: BoxDecoration(color: Colors.white,

                              boxShadow: shadowList,
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(20),
                                  bottomRight: Radius.circular(20)


                              )
                          ),
                          child:Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Column(
                              children:<Widget> [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text("Pako Keokilwe"),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text("pako.pk@gmail.com"),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                    Text("Bsc in Software Eng.", maxLines: 2,
                                      overflow: TextOverflow.ellipsis,),
                                    Text("Prev. Asante tech"),
                                  ],),
                                ),
                              ],
                            ),
                          )

                        ),
                      )

                    ],
                  ),

                ),
              ),
              Container(height: 240,
                   child: Column ( children: <Widget>[
                   new Flexible(child: new FirebaseAnimatedList(
                       scrollDirection: Axis.horizontal,
                     shrinkWrap: true,
                       query: ref,
                     itemBuilder: ( BuildContext context,DataSnapshot snapshot,Animation<double> animation,int index){
                   //   String id= snapshot.key;

                       Map contact = snapshot.value;
                       contact['key'] = snapshot.key;
                       return CardUI(
                         context,
                       contact: contact,

                       );

                     })),
                   ]) ),
              Container(
                height: 240,
                  child: jobList.length==0? Center(child: Text("No data available", style: TextStyle(fontSize:30),)) :
                  ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: jobList.length,
                    itemBuilder: (context,index){

                  //  String id=ref.key[index];
                      return ListUI(
                        jobList[index].companyname,
                        jobList[index].location,
                        jobList[index].jobvacancy,
                        jobList[index].contacts,
                        jobList[index].category,
                        jobList[index].requirements,
                        jobList[index].key,
                      );
                    },

                  ),
                margin: EdgeInsets.symmetric(horizontal: 20),


              ),
              SizedBox(height: 50,)






            ],
          ),
        ),
    );
  }
}

Widget CardUI(BuildContext context,{Map contact}){
  return
    GestureDetector(onTap: (){
      Job data= new Job(

        contact['companyname'],
        contact['location'],
        contact['jobvacancy'],
        contact['contacts'],
        contact['category'],
        contact['requirements'],
        contact['key'],
        //key['key'],
      );
      Navigator.push(context, MaterialPageRoute(builder: (context)=>Screen2( job: data)));

    },child:Container(
    child: Column(
      children: [
        Container(
          padding: EdgeInsets.all(10),
          margin: EdgeInsets.only(left: 20),
          decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: shadowList,
              borderRadius: BorderRadius.circular(10)
          ),
          child: Column(children: [


            Image.asset('assets/working.jpg',       height: 50,
              width: 50,),

            Text(contact['companyname']),
            Text(contact['location']),
            Text(contact['jobvacancy']),
            Text(contact['contacts']),
            Text(contact['category']),
            Text(contact['requirements']),
            Text(contact['key']),
          ])


        ),


      ],
    ),
  ),
    );

}

Widget ListUI(companyname, location, jobvacancy, contacts, category, requirements,key, ){
  return Container(
    child: Column(
      children: [
        Container(

          padding: EdgeInsets.all(10),
          margin: EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: shadowList,
              borderRadius: BorderRadius.circular(10)
          ),

          child: Column(children: [

            Icon(
              Icons.favorite,
              color: Colors.pink,
              size: 24.0,
              semanticLabel: 'Text to announce in accessibility modes',
            ),
            Image.asset('assets/j2.png',       height: 50,
              width: 50,color: Colors.grey[700],),
            Text(companyname,   style: TextStyle(fontWeight: FontWeight.bold),),
            Row(children:[

              Text(category),
              Text(contacts),
            ]

            ),
            Text(location),
            Text(jobvacancy),


            Text(requirements),
          ],)

        ),


      ],
    ),
  );


}
Widget ListUIt(companyname, location, jobvacancy, contacts, category, requirements,key){
  return  Container(

  margin: EdgeInsets.symmetric(horizontal: 20),
  child: Row(
  children: [
  Expanded(
  child: Stack(
  children: [
  Container(
  decoration: BoxDecoration(color: Colors.blueGrey[300],
  borderRadius: BorderRadius.circular(20),
  boxShadow: shadowList,

  ),
  child: Text(companyname),
  margin: EdgeInsets.only(top: 50),
  ),
  Align(
  child: Hero(
  tag:1,child: Image.asset('images/pet-cat2.png')),

  )
   // child: Test("Toyota Engeneering jobs")

  ],
  ),
  ),
  Expanded(child: Container(
  margin: EdgeInsets.only(top: 60,bottom: 20),
  decoration: BoxDecoration(color: Colors.white,

  boxShadow: shadowList,
  borderRadius: BorderRadius.only(
  topRight: Radius.circular(20),
  bottomRight: Radius.circular(20)

  )
  ),

  ))

  ],
  ),

  );
}
getStringValuesSF() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  //Return String
  String stringValue = prefs.getString('key');
  return stringValue;
}


