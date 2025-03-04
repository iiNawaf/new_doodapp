import 'package:doodapp/providers/dood_area_provider.dart';
import 'package:doodapp/widgets/loading/general_loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FlagDooder extends StatefulWidget {
  final String id;
  FlagDooder({required this.id});

  @override
  _FlagDooderState createState() => _FlagDooderState();
}

class _FlagDooderState extends State<FlagDooder> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    final doodProvider = Provider.of<DoodAreaProvider>(context);
    return isLoading
        ? GeneralLoading()
        : GestureDetector(
            onTap: () async {
              setState(() {
                isLoading = true;
              });
              await doodProvider.sendReport(widget.id);
              setState(() {
                isLoading = false;
              });
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text("Report sent!")));
            },
            child: Icon(
              Icons.flag,
              color: Color(0xff707070),
            ),
          );
  }
}
