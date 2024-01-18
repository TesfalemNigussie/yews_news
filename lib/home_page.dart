import 'package:flutter/material.dart';
import 'package:yews_news/data.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = -1;
  String expandStatus = 'NONE';
  bool? isExpandedAll;

  final ExpansionTileController controller = ExpansionTileController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: () async {
          if (selectedIndex == -1) return true;
          tempNEWS[selectedIndex].isSelected = false;
          selectedIndex = -1;
          setState(() {});
          return false;
        },
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Text(
                      '12 13 23',
                      style: TextStyle(
                        fontSize: 16,
                        color: Color(0xFF1b1212),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    if (tempNEWS
                        .any((element) => element.isSelected == true)) ...[
                      Text(
                        tempNEWS
                            .firstWhere(
                              (element) => element.isSelected == true,
                            )
                            .time,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF1b1212),
                        ),
                      ),
                    ] else
                      ...List.generate(
                        tempNEWS.length,
                        (index) => Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: GestureDetector(
                            onTap: () {
                              selectedIndex = index;
                              tempNEWS[index].isSelected = true;
                              setState(() {});
                            },
                            child: Text(
                              tempNEWS[index].time,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF1b1212),
                              ),
                            ),
                          ),
                        ),
                      )
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                if (selectedIndex != -1) ...[
                  Expanded(
                    child: ListView.builder(
                      itemCount: tempNEWS[selectedIndex].news.length,
                      itemBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 0, horizontal: 0),
                        child: ExpansionTile(
                          initiallyExpanded: isExpandedAll ?? false,
                          shape: const RoundedRectangleBorder(
                            side: BorderSide.none,
                          ),
                          trailing: const SizedBox.shrink(),
                          tilePadding: EdgeInsets.zero,
                          expandedCrossAxisAlignment: CrossAxisAlignment.start,
                          title: Text(
                            tempNEWS[selectedIndex].news[index].headline ?? '',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF1b1212),
                            ),
                          ),
                          children: <Widget>[
                            Container(
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Image.network(
                                tempNEWS[selectedIndex]
                                        .news[index]
                                        .imageSource ??
                                    '',
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            Text(
                              tempNEWS[selectedIndex].news[index].imageName ??
                                  '',
                              style: TextStyle(
                                color: Colors.grey.shade500,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            Text(
                              tempNEWS[selectedIndex].news[index].description ??
                                  '',
                              style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            InkWell(
                              onTap: () async {
                                await launchUrl(Uri.parse(
                                  tempNEWS[selectedIndex].news[index].source ??
                                      '',
                                ));
                              },
                              child: const Text(
                                'Source',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  InkWell(
                    onTap: () {
                      if (expandStatus == "NONE") {
                        isExpandedAll = true;
                        expandStatus = "EXPANDED";
                      } else {
                        isExpandedAll = false;
                        expandStatus = "NONE";
                      }
                      setState(() {});
                    },
                    child: Text(
                      expandStatus == "NONE" ? 'Expand' : 'Simplify',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF1b1212),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  InkWell(
                    onTap: () {
                      tempNEWS[selectedIndex].isSelected = false;
                      selectedIndex = -1;
                      setState(() {});
                    },
                    child: const Text(
                      'Home',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF1b1212),
                      ),
                    ),
                  ),
                ]
              ],
            ),
          ),
        ),
      ),
    );
  }
}
