import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GridDashboard extends StatelessWidget {
  final Function(String) onNavigate;

  GridDashboard({super.key, required this.onNavigate});

  Items item1 = Items(
    title: "Мои игры",
    subtitle: '5 организатор , 2 игрок',
    event: "7 Всего",
    route: '/user/games',
  );

  Items item2 = Items(
    title: "Groceries",
    subtitle: "Bocali, Apple",
    event: "4 Items",
  );
  Items item3 = Items(
    title: "Locations",
    subtitle: "Lucy Mao going to Office",
    event: "",
  );
  Items item4 = Items(
    title: "Activity",
    subtitle: "Rose favirited your Post",
    event: "",
  );
  Items item5 = Items(
    title: "To do",
    subtitle: "Homework, Design",
    event: "4 Items",
  );
  Items item6 = Items(
    title: "Settings",
    subtitle: "",
    event: "2 Items",
  );

  @override
  Widget build(BuildContext context) {
    List<Items> myList = [item1, item2, item3, item4, item5, item6];
    var color = 0xff453658;
    return Column(
      children: [
        Flexible(
          child: GridView.count(
              childAspectRatio: 2.0,
              padding: const EdgeInsets.only(left: 16, right: 16),
              crossAxisCount: 1,
              crossAxisSpacing: 18,
              mainAxisSpacing: 18,
              children: myList.map((data) {
                return GestureDetector(
                  onTap: () {
                    if (data.route != null) {
                      onNavigate(data.route!);
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: Color(color),
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const SizedBox(
                          height: 14,
                        ),
                        Text(
                          data.title,
                          style: GoogleFonts.openSans(
                              textStyle: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600)),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Text(
                          data.subtitle,
                          style: GoogleFonts.openSans(
                              textStyle: const TextStyle(
                                  color: Colors.white38,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600)),
                        ),
                        const SizedBox(
                          height: 14,
                        ),
                        Text(
                          data.event,
                          style: GoogleFonts.openSans(
                              textStyle: const TextStyle(
                                  color: Colors.white70,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600)),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList()),
        )
      ],
    );
  }
}

class Items {
  String title;
  String subtitle;
  String event;
  String? route;
  Items({
    required this.title,
    required this.subtitle,
    required this.event,
    this.route,
  });
}
