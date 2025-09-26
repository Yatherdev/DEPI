import 'package:flutter/material.dart';
import 'package:task/presentation/profile_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<String> status = [
    "Assets/images/person1.jpg",
    "Assets/images/person2.jpg",
    "Assets/images/person4.jpg",
    "Assets/images/person3.jpg",
    "Assets/images/person6.jpg",
    "Assets/images/person5.jpg",
  ];
  final List<String> names = [
    "Ahmed Yather",
    "Mohamed Esmail",
    "Fatma Hessian",
    "Ali Ashraf",
    "Ahmed mousa",
    "Yousif",
  ];
  bool isReacted = false;
  void reactPosts (){
    setState(() {
      isReacted = !isReacted;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // MooTools
          SliverToBoxAdapter(
            child: Column(
              children: [
                const SizedBox(height: 35),
                // Row One
                Row(
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.message, size: 30),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.search, size: 30),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.add_box_outlined, size: 30),
                    ),
                    const SizedBox(width: 100),
                    const Text(
                      "Facebook",
                      style:
                      TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                // Row Two
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    InkWell(
                      onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (context)=>ProfilePage())),
                      child: ClipOval(
                        child: Image.asset(
                          status[1],
                          fit: BoxFit.cover,
                          width: 30,
                          height: 30,
                        ),
                      ),
                    ),
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.notification_important, size: 30)),
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.shopping_bag_outlined, size: 30)),
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.person_2, size: 30)),
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.video_collection, size: 30)),
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.home, size: 30)),
                  ],
                ),
                // Row Three
                SizedBox(
                  height: 100,
                  width: double.infinity,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: status.length,
                    itemBuilder: (BuildContext context, int index) {
                      return SizedBox(
                        width: 100,
                        height: 100,
                        child: Padding(
                          padding: const EdgeInsets.all(4),
                          child: ClipOval(
                            child: Image.asset(status[index], fit: BoxFit.cover),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                // Row Four
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.camera_alt)),
                      SizedBox(
                        width: 280,
                        child: TextFormField(
                          decoration: InputDecoration(
                            hintText: "Let World Know",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                          ),
                        ),
                      ),
                      ClipOval(
                        child: Image.asset(
                          status[1],
                          fit: BoxFit.cover,
                          height: 50,
                          width: 50,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20,)
              ],
            ),
          ),
          // Posts List view
          SliverList(
            delegate: SliverChildBuilderDelegate(
                  (context, index) {
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.close, size: 30),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.more_horiz, size: 30),
                          ),
                          const SizedBox(width: 80),
                          Text(
                            names[index],
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          ClipOval(
                            child: Image.asset(
                              status[index],
                              fit: BoxFit.cover,
                              height: 50,
                              width: 50,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Image.asset(
                      status[index],
                      fit: BoxFit.fill,
                      width: double.infinity,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4),
                      child: Container(
                        color: Colors.white,
                        height: 40,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              width: 135,
                              height: double.infinity,
                              color: Colors.black45.withOpacity(.1),
                              child: Icon(Icons.share, size: 30),
                            ),
                            Container(
                              height: double.infinity,
                              width: 130,
                              color: Colors.black45.withOpacity(.1),
                              child: const Icon(Icons.comment, size: 30),
                            ),
                            InkWell(
                              onTap: reactPosts,
                              child: Container(
                                width: 135,
                                height: double.infinity,
                                color: Colors.black45.withOpacity(.1),
                                child:  Icon(Icons.thumb_up, size: 30,color: isReacted? Colors.blue :Colors.black45,),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Divider(),
                  ],
                );
              },
              childCount: 6,
            ),
          ),
        ],
      ),
    );
  }
}