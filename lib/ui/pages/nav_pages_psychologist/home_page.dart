import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  var notas = [
    "Caso severo de ansiedad \nno maneja bien el estrés \nposible pasado traumático",
    "Cuadro de depresión \nprolongado posible familia \ndestructurada",
    "Primera sesión"
  ];

  var images = {
    'paciente.png': 'Luz Mendoza',
    'paciente_2.png': 'Angie Salazar',
    'psicologo.png': 'Moises Quiroz'
  };

  var horas = {
    'paciente.png': '3:15 PM',
    'paciente_2.png': '4:15 PM',
    'psicologo.png': '5:15 PM'
  };
  @override
  Widget build(BuildContext context) {
    TabController tabController = TabController(length: 2, vsync: this);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text(
          'Clinnic Planner',
          style: TextStyle(
              fontFamily: 'RobotoSlab', fontSize: 20, color: Colors.black),
        ),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const SizedBox(height: 10),
          Align(
            alignment: Alignment.center,
            child: TabBar(
                labelPadding: const EdgeInsets.only(left: 20, right: 20),
                labelColor: Colors.black,
                controller: tabController,
                unselectedLabelColor: Colors.grey,
                isScrollable: true,
                indicatorSize: TabBarIndicatorSize.label,
                indicator: CircleTabIndicator(
                    color: const Color.fromARGB(150, 6, 68, 108), radius: 4),
                tabs: const [
                  Tab(
                    text: 'Inicio',
                  ),
                  Tab(
                    text: 'Historial',
                  )
                ]),
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 560,
            width: double.maxFinite,
            child: TabBarView(
              controller: tabController,
              children: [
                ListView.builder(
                  itemCount: 3,
                  //scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      padding: const EdgeInsets.fromLTRB(20, 30, 10, 10),
                      height: 260,
                      width: 300,
                      child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          elevation: 5,
                          child: Stack(clipBehavior: Clip.none, children: [
                            Positioned(
                              top: -50,
                              left: -50,
                              child: Container(
                                margin:
                                    const EdgeInsets.only(left: 100, top: 10),
                                height: 100,
                                width: 100,
                                child: Card(
                                  clipBehavior: Clip.hardEdge,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(80)),
                                  elevation: 2,
                                  child: Image.asset(
                                      'assets/images/${images.keys.elementAt(index)}'),
                                ),
                              ),
                            ),
                            Positioned(
                              top: 20,
                              right: 35,
                              child: Column(
                                children: [
                                  Text(
                                    images.values.elementAt(index),
                                    style: const TextStyle(fontSize: 20),
                                  ),
                                  Text(
                                    horas.values.elementAt(index),
                                    style: const TextStyle(fontSize: 20),
                                  )
                                ],
                              ),
                            ),
                            Positioned(
                              top: 100,
                              left: 29,
                              child: Column(
                                children: [
                                  Text(
                                    notas.elementAt(index),
                                    style: const TextStyle(fontSize: 20),
                                  ),
                                ],
                              ),
                            ),
                          ])),
                    );
                  },
                ),
                ListView.builder(
                  itemCount: 3,
                  //scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      padding: const EdgeInsets.fromLTRB(20, 30, 10, 10),
                      height: 150,
                      width: 300,
                      child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          elevation: 5,
                          child: Stack(clipBehavior: Clip.none, children: [
                            Positioned(
                              top: -10,
                              left: -90,
                              child: Container(
                                margin:
                                    const EdgeInsets.only(left: 100, top: 10),
                                height: 100,
                                width: 100,
                                child: Card(
                                  clipBehavior: Clip.hardEdge,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(80)),
                                  elevation: 2,
                                  child: Image.asset(
                                      'assets/images/${images.keys.elementAt(index)}'),
                                ),
                              ),
                            ),
                            Positioned(
                              top: 30,
                              right: 35,
                              child: Column(
                                children: [
                                  const Text('FINALIZADA'),
                                  const SizedBox(height: 10),
                                  Text(
                                    images.values.elementAt(index),
                                    style: const TextStyle(fontSize: 20),
                                  ),
                                  Text(
                                    horas.values.elementAt(index),
                                    style: const TextStyle(fontSize: 20),
                                  )
                                ],
                              ),
                            ),
                          ])),
                    );
                  },
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}

// ignore: must_be_immutable
class CircleTabIndicator extends Decoration {
  final Color color;
  double radius;
  CircleTabIndicator({required this.color, required this.radius});
  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return _CirclePainter(color: color, radius: radius);
  }
}

class _CirclePainter extends BoxPainter {
  final Color color;
  double radius;
  _CirclePainter({required this.color, required this.radius});
  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    Paint paint = Paint();
    paint.color = color;
    paint.isAntiAlias = true;
    final Offset circleOffset = Offset(
        configuration.size!.width / 2 - radius / 2,
        configuration.size!.height - radius);
    canvas.drawCircle(offset + circleOffset, radius, paint);
  }
}
