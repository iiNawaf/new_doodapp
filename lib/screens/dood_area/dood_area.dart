import 'package:doodapp/providers/dood_area_provider.dart';
import 'package:doodapp/shared/utilities.dart';
import 'package:doodapp/widgets/dood_area/dooder_content.dart';
import 'package:doodapp/widgets/dood_area/dooder_image.dart';
import 'package:doodapp/widgets/dood_area/dooder_name.dart';
import 'package:doodapp/widgets/dood_area/dooder_time.dart';
import 'package:doodapp/widgets/dood_area/flag_dooder.dart';
import 'package:doodapp/widgets/loading/general_loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DoodAreaScreen extends StatefulWidget {
  @override
  _DoodAreaScreenState createState() => _DoodAreaScreenState();
}

class _DoodAreaScreenState extends State<DoodAreaScreen> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    final doodProvider = Provider.of<DoodAreaProvider>(context);
    return RefreshIndicator(
      onRefresh: () async {
        setState(() {
          isLoading = true;
        });
        await doodProvider.fetchDoods();
        setState(() {
          isLoading = false;
        });
      },
      child: isLoading
          ? GeneralLoading()
          : Padding(
              padding: const EdgeInsets.all(15.0),
              child: doodProvider.doods.length == 0
                  ? Text(
                      "No doods yet.",
                      style: TextStyle(color: titleColor),
                    )
                  : ListView.builder(
                      itemCount: doodProvider.doods.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            Container(
                              padding: EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                  color: Color(0xff424242),
                                  borderRadius: BorderRadius.circular(15)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          DooderImage(),
                                          SizedBox(width: 10),
                                          DooderName()
                                        ],
                                      ),
                                      FlagDooder(
                                        id: doodProvider.doods[index].id,
                                      ),
                                    ],
                                  ),
                                  DooderContent(
                                    content:
                                        doodProvider.doods[index].content ?? '',
                                  ),
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: DooderTime(
                                      time: doodProvider.doods[index].sendTime,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            )
                          ],
                        );
                      },
                    ),
            ),
    );
  }
}
