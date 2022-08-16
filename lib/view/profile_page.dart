import 'package:flutter/material.dart';

class Profilepage extends StatefulWidget {
  const Profilepage({Key? key}) : super(key: key);

  @override
  State<Profilepage> createState() => _ProfilepageState();
}

class _ProfilepageState extends State<Profilepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        toolbarHeight: 40.0,
        elevation: 0,
        // automaticallyImplyLeading: false,
        backgroundColor: Color(0xfffFFDC5C),
        title: const Text(
          "My Profile",
          style: TextStyle(color: Colors.black, fontSize: 20),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Icon(Icons.edit),
          )
        ],
      ),
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          Container(
            height: MediaQuery.of(context).size.height / 6,
            width: MediaQuery.of(context).size.width,
            color: Color(0xfffFFDC5C),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
                height: MediaQuery.of(context).size.height * 75 / 100,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 55,
                    ),
                    const Text(
                      "John Cena",
                      style: TextStyle(fontSize: 18),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * 50 / 100,
                      width: MediaQuery.of(context).size.width * 90 / 100,
                      decoration: BoxDecoration(
                        border: Border.all(),
                      ),
                      child: Column(
                        children: [
                          details(context, "Email", "john.cena@email.com"),
                          const Divider(),
                          details(context, "Mobile Number", "987 654 3210"),
                          const Divider(),
                          details(context, "D. O. B.", "15.08.1947"),
                          const Divider(),
                          details(context, "Gender", "Male"),
                        ],
                      ),
                    )
                  ],
                )),
          ),
          Positioned(
              top: 90,
              child: Container(
                height: 100,
                width: 100,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/images/profile.webp"),
                        fit: BoxFit.cover),
                    shape: BoxShape.circle),
              )),
        ],
      ),
    );
  }

  Container details(BuildContext context,String content, String contentName) {
    return Container(
      height: MediaQuery.of(context).size.height / 9.3,
      // color: Colors.blue,
      child: Align(
        alignment: Alignment.center,
        child: Column(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height/30,),
            Align(
              alignment: Alignment.center,
              child: Text(   
                content,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, fontWeight:FontWeight.w600 ),
              ),
            ),
            Text(
              contentName,
              style:TextStyle(fontSize: 14, fontWeight:FontWeight.w600 ),
            )
          ],
        ),
      ),
    );
  }
}
