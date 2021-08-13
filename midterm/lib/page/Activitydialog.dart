import 'package:flutter/material.dart';
import 'package:midterm/model/activity.dart';

class ActivityDialog extends StatefulWidget {
  final Activity activity;
  final Function(String title, String groups, String lasttime) onClickedDone;

  const ActivityDialog({
    Key key,
    this.activity,
    this.onClickedDone,
  }) : super(key: key);

  @override
  _ActivityDialogState createState() => _ActivityDialogState();
}

class _ActivityDialogState extends State<ActivityDialog> {
  final formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final groupsController = TextEditingController();
  final timeController = TextEditingController();

  bool isWrong = true;

  @override
  void initState() {
    super.initState();

    if (widget.activity != null) {
      final activity = widget.activity;

      titleController.text = activity.title;
      groupsController.text = activity.groups;
      timeController.text = activity.lasttime;
    }
  }

  @override
  void dispose() {
    titleController.dispose();
    groupsController.dispose();
    timeController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.activity != null;
    final title = isEditing ? 'Edit activity' : 'Add activity';

    return AlertDialog(
      title: Text(title),
      content: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(height: 8),
              buildtitle(),
              SizedBox(height: 8),
              buildgroups(),
              SizedBox(height: 8),
              buildtimes(),
              SizedBox(height: 8),
            ],
          ),
        ),
      ),
      actions: <Widget>[
        buildCancelButton(context),
        buildAddButton(context, isEditing: isEditing),
      ],
    );
  }

  Widget buildtitle() => TextFormField(
        controller: titleController,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          hintText: 'Enter Activity name',
        ),
        validator: (title) =>
            title != null && title.isEmpty ? 'Enter an Activity' : null,
      );

  Widget buildgroups() => TextFormField(
        controller: groupsController,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          hintText: 'Enter Groups of activity',
        ),
        validator: (groups) => groups != null && groups.isEmpty
            ? 'Enter a group of Activity'
            : null,
      );

  Widget buildtimes() => TextFormField(
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          hintText: 'Enter time you did it',
        ),
        keyboardType: TextInputType.number,
        validator: (lasttime) =>
            lasttime != null && lasttime.isEmpty ? 'Important' : null,
        controller: timeController,
      );

  Widget buildCancelButton(BuildContext context) => TextButton(
        child: Text('Cancel'),
        onPressed: () => Navigator.of(context).pop(),
      );

  Widget buildAddButton(BuildContext context, {bool isEditing}) {
    final text = isEditing ? 'Save' : 'Add';

    return TextButton(
      child: Text(text),
      onPressed: () async {
        final isValid = formKey.currentState.validate();

        if (isValid) {
          final title = titleController.text;
          final groups = groupsController.text;
          final lasttime = timeController.text;

          widget.onClickedDone(title, groups, lasttime);

          Navigator.of(context).pop();
        }
      },
    );
  }
}
