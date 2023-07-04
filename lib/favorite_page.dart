import 'package:demo/app_state.dart';
import 'package:demo/my_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoritePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

    if (appState.favorites.isEmpty) {
      return Center(
        child: Text('Favorite empty!'),
      );
    }

    return ListView(
      children: [
        Padding(
            padding: const EdgeInsets.all(20),
            child: RichText(
                text: TextSpan(
                    text: 'Total ',
                    style: DefaultTextStyle.of(context).style,
                    children: <TextSpan>[
                  TextSpan(
                      text: '${appState.favorites.length}',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.red)),
                  TextSpan(text: ' favorites'),
                ]))),
        for (var pair in appState.favorites)
          ListTile(
            title: Text(pair.asLowerCase),
            leading: Icon(Icons.favorite),
            trailing: GestureDetector(
              onTap: () => showDialog(
                  context: context,
                  builder: (BuildContext context) =>
                      DialogDestroy('Warning', 'Delete ${pair.asLowerCase}',
                          onPressed: (value) {
                        print('value $value');
                        appState.removeList(pair);
                      })),
              child: Icon(Icons.cancel),
            ),
          )
      ],
    );
  }
}
