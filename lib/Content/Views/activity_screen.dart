import 'package:clockify_miniproject/models/HistoryState.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../models/HistoryHiveState.dart';
import 'content_screen.dart';

final _selectedChoiceProvider = StateProvider<String?>((ref)=>"Latest Date");
final _historyProvider = StateNotifierProvider<HistoryHiveStateNotifier, HistoryHiveState>((ref){
  return HistoryHiveStateNotifier();
});

Route _createRouteForContent(){
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondAnimation)=>ContentScreen(),
    transitionDuration: Duration(milliseconds: 400),
    reverseTransitionDuration: Duration(milliseconds: 400),
    transitionsBuilder: (context, animation, secondAnimation, child){
      var tween = Tween(begin: Offset(-1.0, 0), end: Offset.zero).chain(CurveTween(curve: Curves.easeInOut));
      var offsetAnimation = animation.drive(tween);

      return SlideTransition(position: offsetAnimation, child: child);
    }
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      GestureDetector(
                        onTap: (){Navigator.of(context).push(_createRouteForContent());},
                        child: Hero(
                          tag: 'Timer',
                          child: Text(
                            "Timer",
                            style: GoogleFonts.nunitoSans(
                                color: Colors.grey.shade500,
                                fontWeight: FontWeight.bold,
                                fontSize: 18
                            ),
                          ),
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap:(){},
                            child: Hero(
                              tag: 'Activity',
                              child: Text(
                                "Activity",
                                style: GoogleFonts.nunitoSans(
                                    color: Color(0xFFF8D068),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20
                                ),
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
                                  // historyNotifier.sortByDate(ascending: false);
                                  // historyNotifier.getNewData();
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
                  )
                ],
              ),
            ),
          )
      ),
    );
  }
}