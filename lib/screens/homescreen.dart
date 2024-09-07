import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_manager/controllers/amount_controller.dart';
import 'package:money_manager/controllers/expanse_controller.dart';
import 'package:money_manager/models/amount_model.dart';
import 'package:money_manager/models/expanse_model.dart';
import "package:intl/intl.dart";
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive_flutter/adapters.dart';




class HomeScreen extends StatelessWidget{

  TextEditingController amnclt=TextEditingController();
  TextEditingController exclt=TextEditingController();
  TextEditingController addAmount=TextEditingController();
  TextEditingController Description=TextEditingController();
  ExController exController=Get.put(ExController());
  AmountController amountController=Get.put(AmountController());
  Box ExpenseBox=Hive.box("Expense");
  Box amountBox=Hive.box("CurrentM");
  Box AddMoneyBox=Hive.box("AddMoney");

  HomeScreen({super.key});

  MySnackBar(message,context){
    return ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message))
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        
        title: const Text("Dashboard",style: TextStyle(color: Colors.white,fontSize: 24,fontStyle: FontStyle.italic,fontWeight: FontWeight.bold),),
        backgroundColor: Colors.blueGrey[400],
        centerTitle: true,
      
      ),
      backgroundColor: Colors.white,
      body: Column(

        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: SizedBox(
                width: 400,
                height: 200,
                child: Card(

                  shadowColor: Colors.black87,
                  elevation: 20,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(23)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GetBuilder<AmountController>(
                        builder: (controller) {
                          return ValueListenableBuilder(
                              valueListenable: amountBox.listenable(),
                              builder: (context,amountBox, child) {
                                return Text(
                                  "Balance: ${controller.current}",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold, fontSize: 20),
                                );
                              }
                          );
                        },
                      ),
                      const SizedBox(height: 60,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(onPressed: (){
                            _showAddDialogue(context);
                          }, child: const Text("Add Money"),
                            style: ElevatedButton.styleFrom(
                                shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(20),bottomRight: Radius.circular(20))),
                                backgroundColor: Colors.blueGrey,
                                foregroundColor: Colors.white
                            ),
                          ),
                          ElevatedButton(onPressed: (){
                            _showDialogue(context);
                          }, child: const Text("Expense"),
                            style: ElevatedButton.styleFrom(
                                shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(20),bottomRight: Radius.circular(20))),
                                backgroundColor: Colors.blueGrey,
                                foregroundColor: Colors.white
                            ),
                          ),
                        ],
                      )

                    ],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 10,),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text("All History",style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold,),),

          ),
          Expanded(
            child: DefaultTabController(
              length: 3,
              child: Column(

                children: [
                  const TabBar(
                     isScrollable: true,
                    tabs: [
                      Tab(text: 'Expense History'),
                      Tab(text: "Add Money History",),
                      Tab(text: "Summary",)
                    ],
                  ),
                  Expanded(

                    child: TabBarView(
                      children: [

                        GetBuilder<ExController>(builder: (context) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListView.separated(


                              //shrinkWrap: true,
                              itemCount: ExpenseBox.keys.length,
                              itemBuilder: (context, index) {
                                ExModel ex=ExpenseBox.getAt(index);
                                // ExModel ex = exController.historys[index];
                                String formattedDate =
                                DateFormat('yyyy-MM-dd').format(ex.dateTime);
                                return
                                  ListTile(
                                    leading: Text(
                                      formattedDate,
                                      style: const TextStyle(fontSize: 14),
                                    ),
                                    title: Text(
                                      ex.expanse,
                                      style: const TextStyle(
                                          fontSize: 18, fontWeight: FontWeight.w400),
                                    ),
                                    trailing: Text(
                                      "-${ex.amount}",
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                          color: Colors.red),
                                    ),
                                  );

                              },
                              separatorBuilder: (context,index){
                                return const Divider(
                                  color: Colors.grey,
                                  // indent: 2,
                                  // endIndent: 2,
                                  thickness: 2,
                                  height: 0,


                                );
                              },
                            ),
                          );
                        }),

                        GetBuilder<AmountController>(builder: (context) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListView.separated(

                              itemCount: AddMoneyBox.keys.length,
                              itemBuilder: (context, index) {
                                AmountModel Amnt =AddMoneyBox.getAt(index);
                                String Date =
                                DateFormat('yyyy-MM-dd').format(Amnt.dateTimeAdd);
                                return
                                  ListTile(
                                    leading: Text(
                                      Date,
                                      style: const TextStyle(fontSize: 14),
                                    ),
                                    title: Text(
                                      Amnt.DescriptionToAdd,
                                      style: const TextStyle(
                                          fontSize: 18, fontWeight: FontWeight.w400),
                                    ),
                                    trailing: Text(
                                      "+${Amnt.amountToAdd}",
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                          color: Colors.green),
                                    ),
                                  );

                              },
                              separatorBuilder: (context,index){
                                return const Divider(
                                  color: Colors.grey,
                                  // indent: 2,
                                  // endIndent: 2,
                                  thickness: 2,
                                  height: 0,

                                );
                              },
                            ),
                          );
                        }),

                        GetBuilder<AmountController>(builder: (controller){
                          return Column(

                            children: [

                              ListTile(
                                leading: const Text("Total Amount Added :",style: TextStyle(fontSize: 20,),),
                                trailing: Text("${AmountController.TotalAddMoney}",style: const TextStyle(fontSize: 20,color: Colors.green),),
                              ),
                              const Divider(height: 15,color: Colors.black,),
                              ListTile(
                                leading: const Text("Total Expense :",style: TextStyle(fontSize: 20,),),
                                trailing: Text("${AmountController.TotalExpense}",style: const TextStyle(fontSize: 20,color: Colors.red),),
                              ),
                              const Divider(height: 15,color: Colors.grey,)
                            ],
                          );
                        }
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),





        ],
      ),

    );
  }

  _showDialogue(BuildContext context){
    return showDialog(context: context,
        barrierDismissible: false,
        builder: (context){
          return Center(
            child: SingleChildScrollView(
              child: AlertDialog(
                content: Column(
                  children: [
                    TextField(
                      keyboardType: TextInputType.number,
                      controller: amnclt,
                      decoration: const InputDecoration(
                        hintText: "Enter Expense",
                      ),
                    ),
                    const SizedBox(height: 10,),
                    TextField(
                      controller: exclt,
                      decoration: const InputDecoration(
                        hintText: "Expense Description",
                      ),
                    ),


                  ],
                ) ,
                actions: [
                  ElevatedButton(onPressed: (){
                    Navigator.pop(context);
                       amnclt.clear();
                       exclt.clear();

                  },
                    child: const Text('Cancel',style: TextStyle(color: Colors.white),),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueGrey,
                    ),
                  ),
                  ElevatedButton(onPressed: (){
                    double Amount=double.parse(amnclt.text);
                    if(Amount>amountController.current ){
                      MySnackBar("You have not enough money", context);
                      Navigator.pop(context);
                      amnclt.clear();

                    }
                    else if(Amount<=0){
                      MySnackBar("Invalid Amount", context);
                      Navigator.pop(context);
                      amnclt.clear();

                    }
                    else if(exclt.text==""){
                      MySnackBar("Write Description", context);

                    }
                    else{
                      exController.createHistory(ExModel(Amount, exclt.text,DateTime.now()));
                      amountController.spendMoney(Amount);
                      Navigator.pop(context);
                      amnclt.clear();
                      exclt.clear();

                    }
                  },
                    child: const Text('Add',style: TextStyle(color: Colors.white),),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueGrey,
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  _showAddDialogue(BuildContext context){
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context){
          return Center(
            child: SingleChildScrollView(
              child: AlertDialog(
                content: Column(
                  children: [
                    TextField(
                      keyboardType: TextInputType.number,
                      controller: addAmount,
                      decoration: const InputDecoration(
                        hintText: "Add Amount",
                      ),
                    ),
                    const SizedBox(height: 10,),
                    TextField(
                      controller: Description,
                      decoration: const InputDecoration(

                        hintText: "Source",
                      ),
                    ),


                  ],
                ) ,
                actions: [
                  ElevatedButton(onPressed: (){
                    Navigator.pop(context);
                    addAmount.clear();
                    Description.clear();
                  },
                    child: const Text('Cancel',style: TextStyle(color: Colors.white),),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueGrey,
                    ),
                  ),
                  ElevatedButton(onPressed: (){

                    double currentMoney =double.parse(addAmount.text);
                    if(currentMoney<=0){
                      MySnackBar("Invalid Amount", context);
                      addAmount.clear();


                    }
                    else if(Description.text==""){
                      MySnackBar("Write Source", context);

                    }
                    else{
                      amountController.Addmoney(currentMoney);
                      amountController.historyAddMoney(AmountModel(currentMoney, Description.text, DateTime.now(),));
                      Navigator.pop(context);
                      addAmount.clear();
                      Description.clear();
                    }

                  },
                    child: const Text('Add',style: TextStyle(color: Colors.white),),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueGrey,
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }


}