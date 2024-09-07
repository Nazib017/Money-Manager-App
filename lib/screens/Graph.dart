import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:get/get.dart';
import 'package:money_manager/controllers/expanse_controller.dart';
import '../controllers/amount_controller.dart';



class Graph extends StatelessWidget {
  const Graph({super.key});

  @override
  Widget build(BuildContext context) {
    AmountController amountController = Get.put(AmountController());
    ExController exController = Get.put(ExController());
    List<FlSpot> spots = amountController.getFlSpotsFromHive();
    List<FlSpot> Exspots = exController.getExpenseFlSpotsFromHive();
    return DefaultTabController(
      length: 2,
      child: Scaffold(

        appBar: AppBar(
          backgroundColor: Colors.blueGrey,
          title: const Text('Graphs',style: TextStyle(color:Colors.white,fontWeight: FontWeight.bold),),
          centerTitle: true,
          bottom: const TabBar(
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
                          maxX: 30,
                          minY: 0,
                          maxY: 1000,
                          lineBarsData: [
                            LineChartBarData(
                                color: Colors.red,
                                spots:Exspots,
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
                          maxX: 30,
                          minY: 0,
                          maxY: 5000,
                          lineBarsData: [
                            LineChartBarData(
                                isCurved: true,
                                color: Colors.green,
                                spots:spots,
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

