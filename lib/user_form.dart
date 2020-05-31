import 'package:flutter/material.dart';
import 'package:multiple_form_scaffold/user_model.dart';

class UserForm extends StatefulWidget {
  final User user;
  final state = _UserFormState();
  final Function onDelete;

  UserForm({Key key, this.user, this.onDelete}) : super(key: key);
  @override
  _UserFormState createState() => state;

  bool isValid() => state.validate();
}

class _UserFormState extends State<UserForm> {
  final form = GlobalKey<FormState>();
  TextEditingController _nameController = new TextEditingController();
  TextEditingController _emailController = new TextEditingController();

  String setEmail() {
    _emailController.text =
        _nameController.text.replaceAll(new RegExp(r"\s+\b|\b\s"), "");
    return "ok";
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Material(
        elevation: 1,
        clipBehavior: Clip.antiAlias,
        borderRadius: BorderRadius.circular(8),
        child: Form(
            key: form,
            child: Column(
              children: <Widget>[
                AppBar(
                  leading: Icon(Icons.verified_user),
                  title: Text('User Details'),
                  actions: <Widget>[
                    IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: widget.onDelete,
                    )
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(left: 16, right: 16, top: 16),
                  child: TextFormField(
                    controller: _nameController,
                    onChanged: (value) {
                      setEmail();
                    },
                    initialValue: widget.user.userName,
                    onSaved: (val) {
                      widget.user.userName = val;
                    },
                    validator: (val) =>
                        val.length > 3 ? null : 'Full name is invalid',
                    decoration: InputDecoration(
                      labelText: 'Full Name',
                      hintText: 'Enter your full name',
                      icon: Icon(Icons.person),
                      isDense: true,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 16, right: 16, bottom: 24),
                  child: TextFormField(
                    controller: _emailController,
                    initialValue: widget.user.email,
                    onSaved: (val) {
                      widget.user.email = val;
                    },
                    validator: (val) =>
                        val.contains('@') ? null : 'Email is invalid',
                    decoration: InputDecoration(
                      labelText: 'Email Address',
                      hintText: 'Enter your email',
                      icon: Icon(Icons.email),
                      isDense: true,
                    ),
                  ),
                )
              ],
            )),
      ),
    );
  }

  ///form validator
  bool validate() {
    var valid = form.currentState.validate();
    if (valid) form.currentState.save();
    return valid;
  }
}
