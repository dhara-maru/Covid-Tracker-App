import 'package:covid_tracker_app/model/world_states.dart';
import 'package:covid_tracker_app/services/states_services.dart';
import 'package:covid_tracker_app/view/countries_list.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class worldstates extends StatefulWidget {
  const worldstates({super.key});

  @override
  State<worldstates> createState() => _worldstatesState();
}

class _worldstatesState extends State<worldstates>
    with TickerProviderStateMixin {
  late final AnimationController _controller =
      AnimationController(vsync: this, duration: const Duration(seconds: 3))
        ..repeat();
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  final colorlist = <Color>[
const Color(0xff8B008B),  // Dark violet
const Color(0xffD81B60), // Dark Pink
const Color(0xff0288D1), // Dark Blue (for the third color, since the original color was already light)



  ];

  @override
  Widget build(BuildContext context) {
    StatesServices statesServices = StatesServices();
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * .01,
              ),
            
            FutureBuilder(
              future: statesServices.fetchWorldStatesRecords(),
              builder: (context,AsyncSnapshot<WorldStatesModel> snapshot) {
              
              if(snapshot.hasData){
                return Expanded(
                  flex: 1,
                  child: SpinKitFadingCircle(
                    color: Colors.white,
                    size: 50,
                    controller: _controller,) );
              }
              else{
                return Column(
                  children: [
                     Container(
                width: MediaQuery.of(context).size.width > 1200
                    ? 600
                    : double
                        .infinity, // Keep width as double.infinity for smaller screens
                alignment: MediaQuery.of(context).size.width > 1200
                    ? Alignment.centerLeft
                    : Alignment.topCenter,
                child: PieChart(
                  dataMap: {
                     "Total": 30,
                            "Recovered": 20,
                            "Deaths": 10,
                  },
                  chartValuesOptions: const ChartValuesOptions(
                            showChartValueBackground: true,
                            showChartValues: true,
                            showChartValuesInPercentage: true,
                            showChartValuesOutside: true,
                            decimalPlaces: 1,
                          ),

                  legendOptions: LegendOptions(
                    legendPosition: LegendPosition.left,
                  ),
                  animationDuration: Duration(milliseconds: 2400),
                  chartType: ChartType.ring,
                  colorList: colorlist,
                ),
              ),

              //card
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Card(
                  child: Column(
                    children: [
                      reusableRow(title: 'Total Cases', value: snapshot.data!.cases.toString()),
                                reusableRow(title: 'Deaths', value: snapshot.data!.deaths.toString()),
                                reusableRow(title: 'Recovered', value: snapshot.data!.recovered.toString()),
                                reusableRow(title: 'Active', value: snapshot.data!.active.toString()),
                                reusableRow(title: 'Critical', value: snapshot.data!.critical.toString()),
                                reusableRow(title: 'Today Deaths', value: snapshot.data!.todayDeaths.toString()),
                                reusableRow(title: 'Today Recovered', value: snapshot.data!.todayRecovered.toString()),
                    ],
                  ),
                ),
              ),

              GestureDetector(
                onTap: (){
                   Navigator.push(context, MaterialPageRoute(builder: (context) => const CountriesListScreen()));
                },
                child: Container(
                  height: 50,
                  
                  decoration: BoxDecoration(
                    color: Colors.blue[500],
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                    child: Text("Track Countries", 
                    style: TextStyle(
                      fontSize: 16,
                      
                    ),),
                  ),
                ),
              ),
                  ],
                );
              }
            }),
             
            ],
          ),
        ),
      ),
    );
  }
}


class reusableRow extends StatelessWidget {

  String title, value;
   reusableRow({Key? key, required this.title, required this.value }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, bottom: 5, top: 10, right: 15),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
      
            children: [
              Text(title),
              Text(value),
            ],
          ),
          SizedBox(height: 5,),
          Divider(),
        ],
      ),
    );
  }
}