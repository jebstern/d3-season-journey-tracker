import 'package:d3_season_journey/controller/controller.dart';
import 'package:d3_season_journey/widgets/nav_drawer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/percent_indicator.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Controller c = Get.find<Controller>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("D3 Journey Tracker"),
      ),
      body: GetBuilder<Controller>(
        builder: (controller) => Padding(
          padding: const EdgeInsets.all(24.0),
          child: _getContent(controller),
        ),
      ),
      drawer: const NavDrawerWidget(),
    );
  }

  Widget _getContent(Controller controller) {
    if (controller.initialised == false) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Padding(
              padding: EdgeInsets.only(bottom: 12),
              child: Text("Loading Season Journey data..."),
            ),
            CircularProgressIndicator(value: null),
          ],
        ),
      );
    } else {
      return SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: double.infinity,
              child: FittedBox(
                fit: BoxFit.fitWidth,
                child: Text(
                  controller.seasonJourneyModel.title,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 24),
              child: CircularPercentIndicator(
                radius: 120.0,
                lineWidth: 13.0,
                animation: true,
                animationDuration: 1000,
                percent: c.stats.amountCheckedPercentage,
                center: Text(
                  c.stats.amountCheckedLabel,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                  ),
                ),
                circularStrokeCap: CircularStrokeCap.round,
                progressColor: Colors.grey[800],
                header: Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Text(
                    "Total completion: ${controller.stats.progress}",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }
  }
}
