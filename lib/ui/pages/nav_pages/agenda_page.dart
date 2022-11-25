// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';

class AgendaPage extends StatefulWidget {
  const AgendaPage({super.key});

  @override
  State<AgendaPage> createState() => _AgendaPageState();
}

class _AgendaPageState extends State<AgendaPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: 32,
              color: const Color.fromARGB(250, 6, 68, 108),
            ),
            Container(
              padding: const EdgeInsets.all(16.0),
              color: const Color.fromARGB(250, 6, 68, 108),
              child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
                const topRow(),
                Padding(
                  padding: const EdgeInsets.only(top: 26.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(
                        6,
                        (index) => dateWidget(
                              index: index,
                            )),
                  ),
                ),
              ]),
            ),
            const cardWidget(),
          ],
        ),
      ),
    );
  }
}

class cardWidget extends StatelessWidget {
  const cardWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var agenda = {
      'Ofirebase inita': "2:15 PM",
      'Hector Casaño': '3:15 PM',
      'Ada Mendoza': '4:15 PM',
      'Moises Quiroz': '5:15 PM'
    };
    List hora = ["14:00", "15:00", "16:00", "17:00"];
    return SizedBox(
      height: 550,
      width: double.maxFinite,
      child: ListView.builder(
          itemCount: 4,
          itemBuilder: (BuildContext context, int index) {
            return Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: <Widget>[
                      Text(
                        hora.elementAt(index),
                      ),
                      const line_widget(
                        lines: [20.0, 30.0, 40.0, 10.0],
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  width: 8.0,
                ),
                Expanded(
                  child: Container(
                    height: 100.0,
                    decoration: const BoxDecoration(
                        color: Color.fromARGB(250, 6, 68, 108),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(8.0),
                            bottomLeft: Radius.circular(8.0))),
                    child: Container(
                      margin: const EdgeInsets.only(left: 4.0),
                      color: Colors.white,
                      padding: const EdgeInsets.only(left: 15.0, top: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 21.0,
                          ),
                          Row(
                            children: <Widget>[
                              Text(
                                agenda.values.elementAt(index),
                                style: const TextStyle(fontSize: 20),
                              ),
                              const VerticalDivider(),
                              Text(
                                agenda.keys.elementAt(index),
                                style: const TextStyle(fontSize: 20),
                              ),
                            ],
                          ),
                          const Text(
                            'Primera Consulta',
                            style: TextStyle(
                                fontSize: 21, fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          }),
    );
  }
}

class line_widget extends StatelessWidget {
  final lines;
  const line_widget({
    Key? key,
    this.lines,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(
            4,
            (index) => Container(
                  height: 2.0,
                  width: lines[index],
                  color: const Color.fromARGB(250, 6, 68, 108),
                  margin: const EdgeInsets.symmetric(vertical: 14.0),
                )));
  }
}

class dateWidget extends StatefulWidget {
  final index;

  const dateWidget({super.key, required this.index});
  @override
  State<dateWidget> createState() => _dateWidgetState();
}

class _dateWidgetState extends State<dateWidget> {
  var list = ['Lu', 'Ma', 'Mi', 'Ju', 'Vi', 'Sa'];
  bool _selectDate = true;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          _selectDate = !_selectDate;
        });
      },
      child: Container(
        decoration: _selectDate
            ? null
            : BoxDecoration(
                color: Colors.grey, borderRadius: BorderRadius.circular(10)),
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text(
              list[widget.index],
              style: TextStyle(
                  fontSize: 10,
                  fontWeight: _selectDate ? FontWeight.normal : FontWeight.bold,
                  color: _selectDate ? Colors.grey : Colors.white),
            ),
            Text(
              '${10 + widget.index}',
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: _selectDate ? FontWeight.normal : FontWeight.bold,
                  color: _selectDate ? Colors.grey : Colors.white),
            ),
            Container(
              width: 4.0,
              height: 4.0,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _selectDate ? Colors.grey : Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}

class topRow extends StatelessWidget {
  const topRow({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Row(
          children: const [
            Text(
              'Sesiones',
              style: TextStyle(fontSize: 24, color: Colors.white),
            ),
          ],
        ),
        const Spacer(),
        const Text('Nov', style: TextStyle(fontSize: 18, color: Colors.white))
      ],
    );
  }
}
