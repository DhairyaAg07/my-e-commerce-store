import 'package:flutter/material.dart';

class MyDrawer extends StatefulWidget {
  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
        backgroundColor: Colors.black54,
        child: ListView(
          children: [
            //   header
            Container(
              padding: const EdgeInsets.only(top: 26, bottom: 12),
              child: Column(
                children: [
                  //   user profile image
                  Container(
                    height: 130,
                    width: 130,
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(
                        "https://static.vecteezy.com/system/resources/previews/019/896/008/original/male-user-avatar-icon-in-flat-design-style-person-signs-illustration-png.png",
                      ),
                    ),
                  ),

                  // gap in between
                  
                  
                  
                  
                  const SizedBox(
                    height: 12,
                  ),

                  
                  
                  
                  //   user name
                  Text(
                    "user Name",
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),

                  SizedBox(
                    height: 12,
                  ),
                ],
              ),
            ),

            
            
            
            
            //   body
            Container(
              padding: const EdgeInsets.only(top: 1),
              child: Column(
                children: [
                  const Divider(
                    height: 10,
                    color: Colors.grey,
                    thickness: 2,
                  ),

                  
                  //   home button

                  ListTile(
                    leading: const Icon(Icons.home, color: Colors.grey,),
                    
                    
                    
                    title: const Text("Home",
                      style: TextStyle(color: Colors.grey,),
                    ),
                    
                    
                    
                    onTap: () {},
                  ),

                  
                  
                  const Divider(
                    height: 10,
                    color: Colors.grey,
                    thickness: 2,
                  ),

                  
                  // my orders
                  
                  
                  ListTile(
                    leading: const Icon(Icons.reorder, color: Colors.grey,),



                    title: const Text("My orders",
                      style: TextStyle(color: Colors.grey,),
                    ),



                    onTap: () {},
                  ),



                  const Divider(
                    height: 10,
                    color: Colors.grey,
                    thickness: 2,
                  ),
                  
                  
                
                  
                //   not yet recieved order

                  ListTile(
                    leading: const Icon(Icons.picture_in_picture_alt_rounded, color: Colors.grey,),



                    title: const Text("Not yet recieved order",
                      style: TextStyle(color: Colors.grey,),
                    ),



                    onTap: () {},
                  ),



                  const Divider(
                    height: 10,
                    color: Colors.grey,
                    thickness: 2,
                  ),
                
                
                
                
                //   history


                  ListTile(
                    leading: const Icon(Icons.access_time, color: Colors.grey,),



                    title: const Text("history",
                      style: TextStyle(color: Colors.grey,),
                    ),



                    onTap: () {},
                  ),



                  const Divider(
                    height: 10,
                    color: Colors.grey,
                    thickness: 2,
                  ),
                
                
                
                
                
                //   search


                  ListTile(
                    leading: const Icon(Icons.search, color: Colors.grey,),



                    title: const Text("Search",
                      style: TextStyle(color: Colors.grey,),
                    ),



                    onTap: () {},
                  ),



                  const Divider(
                    height: 10,
                    color: Colors.grey,
                    thickness: 2,
                  ),
                
                
                
                
                
                //   logout
                  ListTile(
                    leading: const Icon(Icons.exit_to_app, color: Colors.grey,),



                    title: const Text("Logout",
                      style: TextStyle(color: Colors.grey,),
                    ),



                    onTap: () {},
                  ),



                  const Divider(
                    height: 10,
                    color: Colors.grey,
                    thickness: 2,
                  ),
  




                ],
              ),
            ),
          ],
        ));
  }
}
