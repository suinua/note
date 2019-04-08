import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class EditingMemoGroupTitlePage extends StatefulWidget {
  final String defaultTitle;

  const EditingMemoGroupTitlePage({Key key, @required this.defaultTitle})
      : super(key: key);

  @override
  _EditingMemoGroupTitlePageState createState() =>
      _EditingMemoGroupTitlePageState();
}

class _EditingMemoGroupTitlePageState extends State<EditingMemoGroupTitlePage> {
  TextEditingController titleController;

  @override
  void initState() {
    titleController = TextEditingController(text: widget.defaultTitle);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Editing Title',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.close, color: Colors.black),
        ),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              Navigator.pop(context, titleController.text);
            },
            icon: const Icon(FontAwesomeIcons.solidSave),
            color: Colors.blue,
          )
        ],
      ),
      body: TextField(
        controller: titleController,
      ),
    );
  }
}

class EditingMemoGroupDescriptionPage extends StatefulWidget {
  final String defaultDescription;

  const EditingMemoGroupDescriptionPage(
      {Key key, @required this.defaultDescription})
      : super(key: key);

  @override
  _EditingMemoGroupDescriptionPageState createState() =>
      _EditingMemoGroupDescriptionPageState();
}

class _EditingMemoGroupDescriptionPageState
    extends State<EditingMemoGroupDescriptionPage> {
  TextEditingController descriptionController;

  @override
  void initState() {
    descriptionController =
        TextEditingController(text: widget.defaultDescription);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Editing Description',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.close, color: Colors.black),
        ),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              Navigator.pop(context, descriptionController.text);
            },
            icon: const Icon(FontAwesomeIcons.solidSave),
            color: Colors.blue,
          )
        ],
      ),
      body: TextField(
        controller: descriptionController,
      ),
    );
  }
}
