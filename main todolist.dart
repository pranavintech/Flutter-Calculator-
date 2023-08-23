import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Anime List',
      theme: ThemeData(primarySwatch: Colors.indigo),
      debugShowCheckedModeBanner: false, // Remove the debug banner
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<String> animeTitles = ['Death Note', 'Attack on Titan', 'Baki', 'Classroom of the Elite'];
  List<bool> animeChecked = List.generate(4, (index) => false);

  void addAnime(String animeTitle) {
    setState(() {
      animeTitles.add(animeTitle);
      animeChecked.add(false);
    });
  }

  void removeAnimes() {
    setState(() {
      animeTitles.removeWhere((anime) => animeChecked[animeTitles.indexOf(anime)]);
      animeChecked.removeWhere((checked) => checked);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('My Anime List')),
      body: Column(
        children: [
          SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AddAnimeDialog(addAnime: addAnime);
                },
              );
            },
            child: Text('Add Anime'),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: animeTitles.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                    animeTitles[index],
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text('Tap to mark as watched'),
                  trailing: Checkbox(
                    value: animeChecked[index],
                    onChanged: (value) {
                      setState(() {
                        animeChecked[index] = value!;
                      });
                    },
                  ),
                  onTap: () {
                    setState(() {
                      animeChecked[index] = !animeChecked[index];
                    });
                  },
                );
              },
            ),
          ),
          ElevatedButton(
            onPressed: removeAnimes,
            child: Text('Remove Watched Anime'),
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}

class AddAnimeDialog extends StatefulWidget {
  final void Function(String) addAnime;

  AddAnimeDialog({required this.addAnime});

  @override
  _AddAnimeDialogState createState() => _AddAnimeDialogState();
}

class _AddAnimeDialogState extends State<AddAnimeDialog> {
  TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Add Anime'),
      content: TextField(
        controller: _textEditingController,
        decoration: InputDecoration(
          hintText: 'Enter the anime title',
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            widget.addAnime(_textEditingController.text);
            Navigator.pop(context);
          },
          child: Text('Add'),
        ),
      ],
    );
  }
}
