import 'package:flutter/material.dart';
import 'domain/workout.dart';

void main() {
  runApp(MaxFitApp());
}

class MaxFitApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Max Fitness',
        theme: ThemeData(
            primaryColor: Color.fromRGBO(50, 65, 85, 1),
            textTheme: const TextTheme(
                titleLarge: TextStyle(color: Colors.white),
                titleMedium: TextStyle(color: Colors.white),
                titleSmall: TextStyle(color: Colors.white))),
        home: HomePage());
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          title: Text('MaxFit'),
          leading: Icon(Icons.fitness_center),
        ),
        body: WorkOutList(),
      ),
    );
  }
}

class WorkOutList extends StatelessWidget {
  final workout = <WorkOut>[
    WorkOut(
        title: 'test1',
        author: 'max',
        description: 'testdescription1',
        level: 'Начинающий'),
    WorkOut(
        title: 'test2',
        author: 'max',
        description: 'testdescription2',
        level: 'Средничок'),
    WorkOut(
        title: 'test3',
        author: 'max',
        description: 'testdescription3',
        level: 'Профи'),
    WorkOut(
        title: 'test4',
        author: 'max',
        description: 'testdescription4',
        level: 'Средничок'),
    WorkOut(
        title: 'test5',
        author: 'max',
        description: 'testdescription5',
        level: 'Профи'),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        child: ListView.builder(
            itemCount: workout.length,
            itemBuilder: (context, i) {
              return Card(
                elevation: 2.0,
                margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                child: Container(
                  decoration: const BoxDecoration(
                      color: Color.fromRGBO(50, 65, 85, 0.9)),
                  child: ListTile(
                    contentPadding: EdgeInsets.symmetric(horizontal: 10),
                    leading: Container(
                      child: const Icon(Icons.fitness_center),
                    ),
                    title: Text(
                      workout[i].title,
                      style: TextStyle(color: Colors.white),
                    ),
                    subtitle: subtitle(context, workout[i]),
                    trailing: const Icon(
                      Icons.keyboard_arrow_right,
                      color: Colors.white,
                    ),
                  ),
                ),
              );
            }),
      ),
    );
  }
}

Widget subtitle(BuildContext context, WorkOut workOut) {
  var color = Colors.grey;
  double indicatorLevel = 0;
  switch (workOut.level) {
    case 'Начинающий':
      color = Colors.green;
      indicatorLevel = 0.33;
      break;
    case 'Срединчок':
      color = Colors.yellow;
      indicatorLevel = 0.66;
      break;
    case 'Профи':
      color = Colors.red;
      indicatorLevel = 1;
      break;
  }
  return Row(
    children: <Widget>[
      Expanded(
          flex: 1,
          child: LinearProgressIndicator(
            backgroundColor: Colors.white,
            value: indicatorLevel,
            valueColor: AlwaysStoppedAnimation(color),
          )),SizedBox(width: 10,),
      Expanded(flex: 3, child: Text(workOut.level, style: TextStyle(color: Colors.white),))
    ],
  );
}
