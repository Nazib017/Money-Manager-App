import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';


class Graph extends StatelessWidget {
  const Graph({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(

        appBar: AppBar(
          backgroundColor: Colors.blueGrey,
          title: Text('Graphs',style: TextStyle(color:Colors.white,fontWeight: FontWeight.bold),),
          centerTitle: true,
          bottom: TabBar(
            labelStyle:TextStyle(fontSize: 17,color: Colors.white) ,

            indicatorColor: Colors.white,
            tabs: [
              Tab(text: 'Expense Graph',),
              Tab(text: 'Add Money Graph'),
            ],
          ),
        ),
        body: TabBarView(
          children: [

            Center(
              child: AspectRatio(
                  aspectRatio: 3/2,
                  child: LineChart(
                      LineChartData(
                          minX: 0,
                          maxX: 1000,
                          minY: 0,
                          maxY: 1000,
                          lineBarsData: [
                            LineChartBarData(
                                color: Colors.red,
                                spots:[
                                  FlSpot(30, 50),
                                  FlSpot(240, 208),
                                  FlSpot(420, 80),
                                  FlSpot(800, 720),
                                ]
                            ),
                          ]

                      )
                  )
              ),
            ),

            Center(
              child: AspectRatio(
                  aspectRatio: 3/2,
                  child: LineChart(
                      LineChartData(

                          minX: 0,
                          maxX: 1000,
                          minY: 0,
                          maxY: 1000,
                          lineBarsData: [
                            LineChartBarData(
                                isCurved: true,
                                color: Colors.green,
                                spots:[
                                  FlSpot(30, 50),
                                  FlSpot(240, 208),
                                  FlSpot(420, 80),
                                  FlSpot(800, 720),
                                ]
                            ),
                          ]

                      )
                  )
              ),
            ),
          ],
        ),
      ),
    );
  }
}

