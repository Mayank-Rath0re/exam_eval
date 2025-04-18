
import 'package:flutter/cupertino.dart';

class ResponsiveLayout extends StatelessWidget{
  final Widget mobileScaffold;
  final Widget tabletScffold;
  final Widget desktopScaffold;

  ResponsiveLayout({
    required this.mobileScaffold,
    required this.tabletScffold,
    required this.desktopScaffold
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context,constraints)
    {
      if(constraints.maxWidth < 500){
        return mobileScaffold;
      }
      else if(constraints.maxWidth < 1100){
        return tabletScffold;
      }
      else {
        return desktopScaffold;
      }
    },
    );
  }
}