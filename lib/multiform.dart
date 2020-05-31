import 'package:flutter/material.dart';
import 'package:multiple_form_scaffold/user_form.dart';
import 'package:multiple_form_scaffold/user_model.dart';

class Multiform extends StatefulWidget {
  @override
  _MultiformState createState() => _MultiformState();
}

class _MultiformState extends State<Multiform> {
  List<UserForm> forms = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor.withOpacity(.3),
      appBar: AppBar(
        leading: Icon(Icons.wb_cloudy),
        title: Text("Multiple Form"),
        actions: <Widget>[
          FlatButton(
            child: Text('Save'),
            textColor: Colors.white,
            onPressed: onSaveFormList,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: onAddForm,
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(
          addAutomaticKeepAlives: true,
          itemCount: forms.length,
          itemBuilder: (context, index) {
            return forms[index];
          }),
    );
  }

  void onAddForm() {
    setState(() {
      var _user = User();

      forms.add(UserForm(
        onDelete: () => onDelete(_user),
        user: _user,
      ));
    });
  }

  void onDelete(User _user) {
    setState(() {
      var find = forms.firstWhere(
        (element) => element.user == _user,
        orElse: () => null,
      );

      if (find != null) {
        forms.removeAt(forms.indexOf(find));
      }
    });
  }

  void onSaveFormList() {
    if (forms.length > 0) {
      var isAllValid = true;
      forms.forEach((form) {
        if (!form.isValid()) {
          isAllValid = false;
        }

        if (isAllValid) {
          var data = forms.map((form) => form.user).toList();

          print(data);

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => Scaffold(
                appBar: AppBar(
                  title: Text('List of Users'),
                ),
                body: ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (_, i) => ListTile(
                    leading: CircleAvatar(
                      child: Text(data[i].userName.substring(0, 1)),
                    ),
                    title: Text(data[i].userName),
                    subtitle: Text(data[i].email),
                  ),
                ),
              ),
            ),
          );
        }
      });
    }
  }
}
