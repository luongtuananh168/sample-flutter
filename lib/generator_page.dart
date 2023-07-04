import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:demo/app_state.dart';

class GeneratorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    var pair = appState.current;

    IconData icon;
    if (appState.favorites.contains(pair)) {
      icon = Icons.favorite;
    } else {
      icon = Icons.favorite_border;
    }
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ListWord(),
            BigCard(pair: pair),
            SizedBox(height: 10),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    appState.toggleFavorite();
                  },
                  icon: Icon(icon),
                  label: Text('Like'),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    appState.getNext();
                  },
                  child: Text('Next'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class BigCard extends StatelessWidget {
  const BigCard({
    super.key,
    required this.pair,
  });

  final WordPair pair;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final style = theme.textTheme.displaySmall!.copyWith(
      color: theme.colorScheme.background,
    );
    return Card(
      color: theme.colorScheme.primary,
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: AnimatedSize(
          duration: Duration(microseconds: 200),
          child: MergeSemantics(
              child: Wrap(
            children: [
              Text(pair.first,
                  style: style.copyWith(fontWeight: FontWeight.w200)),
              Text(
                pair.second,
                style: style.copyWith(fontWeight: FontWeight.bold),
              )
            ],
          )),
        ),
      ),
    );
  }
}

class ListWord extends StatefulWidget {
  @override
  State<ListWord> createState() => _ListWordState();
}

class _ListWordState extends State<ListWord> {
  /// Used to "fade out" the history items at the top, to suggest continuation.
  static const Gradient _maskingGradient = LinearGradient(
    // This gradient goes from fully transparent to fully opaque black...
    colors: [Colors.transparent, Colors.redAccent],
    // ... from the top (transparent) to half (0.5) of the way to the bottom.
    stops: [0.0, 0.5],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

    return ShaderMask(
      shaderCallback: (bounds) => _maskingGradient.createShader(bounds),
      blendMode: BlendMode.dstIn,
      child: Container(
        // color: Colors.amberAccent,
        // padding: EdgeInsets.only(left: 2),
        child: ListView(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
          children: [
            for (var pair in appState.list)
              Center(
                child: ListTile(
                  onTap: () => appState.setCurrent(pair),
                  selected: appState.current == pair,
                  selectedColor: Colors.red,
                  title: Text(pair.asLowerCase),
                  leading: GestureDetector(
                    onTap: () {
                      if (appState.favorites.contains(pair)) {
                        appState.removeFavorite(pair);
                      } else {
                        appState.addFavorite(pair);
                      }
                    },
                    child: appState.favorites.contains(pair)
                        ? Icon(Icons.favorite)
                        : Icon(Icons.favorite_border),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
