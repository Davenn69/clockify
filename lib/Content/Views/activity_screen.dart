import 'package:clockify_miniproject/models/HistoryState.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';

final _selectedChoiceProvider = StateProvider<String?>((ref)=>"Latest Date");
final _historyProvider = StateNotifierProvider<HistoryStateNotifier, HistoryState>((ref){
  return HistoryStateNotifier();
});

Widget activityDateWidget(){
  return SizedBox(
      width: double.infinity,
      child: Container(
        color: Colors.white.withAlpha(50),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          child: Text(
            "12 Mar 2020",
            style: GoogleFonts.nunitoSans(
                fontWeight: FontWeight.bold,
                color: Color(0xFFF8D068)
            ),
          ),
        ),
      )
  );
}

Widget activityHistoryWidget(){
  return Slidable(
    endActionPane: ActionPane(motion: const DrawerMotion(),
        children: [
          SlidableAction(
            onPressed: (BuildContext context) { Navigator.pushReplacementNamed(context, '/');},
            backgroundColor: Colors.redAccent,
            icon: Icons.delete,

          ),
        ]
    ),
    child: SizedBox(
      width: double.infinity,
      child: Container(
        decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(
                  color: Colors.grey.withAlpha(100),
                  width: 1
              )
          ),
          color: Colors.transparent,
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "00 : 30 : 22",
                    style: GoogleFonts.nunitoSans(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(
                        Icons.lock_clock,
                        color: Colors.grey,
                        size: 20,
                      ),
                      Text(
                        "12:00:00 - 12:30:22",
                        style: GoogleFonts.nunitoSans(
                            fontSize: 12,
                            color: Colors.grey
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Text(
                    "Treadmill",
                    style: GoogleFonts.nunitoSans(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(
                        Icons.location_on_outlined,
                        color: Colors.grey,
                        size: 20,
                      ),
                      Text(
                        "12:00:00 - 12:30:22",
                        style: GoogleFonts.nunitoSans(
                            fontSize: 12,
                            color: Colors.grey
                        ),
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    ),
  );
}


class ActivityScreen extends ConsumerWidget{
  final TextEditingController _searchController = TextEditingController();


  Widget build(BuildContext context, WidgetRef ref){
    final historyState = ref.watch(_historyProvider);
    final historyNotifier = ref.read(_historyProvider.notifier);
    final _selectedChoice = ref.watch(_selectedChoiceProvider);

    return Scaffold(
      backgroundColor: Color(0xFF233971),
      body: SafeArea(
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: 40),
                  Hero(
                    tag: 'logo',
                    child: Image.asset(
                        "assets/images/clockify-medium.png",
                        width: 200,
                        fit: BoxFit.cover
                    ),
                  ),
                  SizedBox(height: 40),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      GestureDetector(
                        onTap: (){Navigator.pushReplacementNamed(context, "/content");},
                        child: Text(
                          "Timer",
                          style: GoogleFonts.nunitoSans(
                              color: Colors.grey.shade500,
                              fontWeight: FontWeight.bold,
                              fontSize: 18
                          ),
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap:(){},
                            child: Text(
                              "Activity",
                              style: GoogleFonts.nunitoSans(
                                  color: Color(0xFFF8D068),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18
                              ),
                            ),
                          ),
                          SizedBox(height: 5),
                          Hero(
                            tag: "timer-activity",
                            child: AnimatedContainer(
                              width: MediaQuery.of(context).size.width * 0.20,
                              height: 3,
                              color : Color(0xFFF8D068),
                              duration: Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 13),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          flex: 3,
                            child: TextFormField(
                              controller: _searchController,
                              decoration: InputDecoration(
                                hintText: "Search Activity...",
                                filled: true,
                                fillColor: Colors.white,
                                suffixIcon: Icon(
                                  Icons.search,
                                  size: 30,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20)
                                )
                              ),
                            )
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          flex: 2,
                            child: DropdownButtonFormField<String>(
                              isExpanded : true,
                              value: ref.read(_selectedChoiceProvider.notifier).state,
                              onChanged: (String? value){
                                ref.read(_selectedChoiceProvider.notifier).state = value;
                                if(value == "Latest Date"){
                                  historyNotifier.sortByDate(ascending: false);
                                  historyNotifier.getNewData();
                                }
                              },
                              items: <String>['Latest Date', "Nearby"].map<DropdownMenuItem<String>>((String value){
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(
                                      value,
                                    style: GoogleFonts.nunitoSans(
                                      color: Colors.black87
                                    ),
                                  ),
                                );
                              }).toList(),
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: BorderSide(color: Colors.white, width: 50)
                                )
                              ),
                              dropdownColor: Colors.white,
                              icon: Icon(
                                Icons.arrow_drop_down,
                                color: Colors.black87,
                              ),
                            ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Column(
                    children: historyNotifier.makeWidget(context),
                    // children: <Widget>[
                    //   activityDateWidget(),
                    // activityHistoryWidget(),
                    //   activityHistoryWidget(),
                    //   activityDateWidget(),
                    //   activityHistoryWidget(),
                    //   activityHistoryWidget(),
                    //   activityDateWidget(),
                    //   activityHistoryWidget(),
                    //   activityHistoryWidget(),
                    //   activityDateWidget(),
                    //   activityHistoryWidget(),
                    //   activityHistoryWidget()
                  )
                ],
              ),
            ),
          )
      ),
    );
  }
}