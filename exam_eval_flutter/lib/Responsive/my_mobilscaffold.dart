
import 'package:exam_eval_flutter/Constants.dart';
import 'package:flutter/material.dart';

class MobileScaffold extends StatefulWidget{
  const MobileScaffold({super.key});

  @override
  State<MobileScaffold> createState() => _MobileScaffoldState();
}

class _MobileScaffoldState extends State<MobileScaffold> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DefaultBackground,
      appBar: DefaultAppbar,
      drawer: DefaultDrawer,
      body: SingleChildScrollView(
        child: Padding(padding: EdgeInsets.all(20),
      child:
      Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Hi, User",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),),
                  Text("welcome back to your dashboard",
                  style: TextStyle(
                    fontSize: 12,

                  ),)
                ],
              )
            ],
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: GridView.builder(
              shrinkWrap: true, // Important when using GridView inside a scroll view
              physics: NeverScrollableScrollPhysics(), // Prevents nested scroll conflicts
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                childAspectRatio: 2, // Wider than tall
              ),
              itemCount: 1, // Add this to avoid infinite loop
              itemBuilder: (context, index) {
                return Container(
                  height: 150, // This now works!
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 4,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child:Padding(padding: EdgeInsets.all(20),
                  child:
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Class Performance Overview",
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),),
                          Text("View all",
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: 12,
                          ),)
                        ],
                      ),
                      const SizedBox(height: 25,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            height: 100, // your small height
                            width: 180,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade300,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Padding(padding: EdgeInsets.all(15),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Average Score",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),),
                                Text("85",
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blueAccent,
                                ),)
                              ],
                            ),)
                          ),
                          Container(
                              height: 100, // your small height
                              width: 180,
                              decoration: BoxDecoration(
                                color: Colors.grey.shade300,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Padding(padding: EdgeInsets.all(15),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Class Participation",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                      ),),
                                    Text("70%",
                                      style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.blueAccent,
                                      ),)
                                  ],
                                ),)
                          ),
                        ],
                      ),


                    ],
                  )
                ));
              },
            ),
          ),
          const SizedBox(height: 25,),
          Container(
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(20),
            ),

            child: Padding(
            padding: const EdgeInsets.all(16.0),

            child:  Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              // 🔹 Title
              Text(
              "History",
              style: TextStyle(
                fontSize:  22,
                fontWeight: FontWeight.bold,
              ),
            ),
              const SizedBox(height: 20),

            Container(
            decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(20),
            ),
            child:

            Column(
              children:
              List.generate(3, (index) {
                return InkWell(
                  onTap: () {
                    // 👇 Do something here, like open a details page or show a dialog
                    print("Tapped on Unit ${index + 1}");
                  },
                  borderRadius: BorderRadius.circular(15),
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 4,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.person, color: Colors.blue),
                        SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Unit ${index + 1}", style: TextStyle(fontWeight: FontWeight.bold)),
                            Text("Artificial Intelligence", style: TextStyle(color: Colors.grey)),
                          ],
                        ),
                        Spacer(),
                        Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
                      ],
                    ),
                  ),
                );
              }),
            ),
          ),
            ]))),
        ],
      )
    )),
    );
  }
}