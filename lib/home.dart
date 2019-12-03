import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: new Text('Home'),
      ),
      body: Container(
        color: Colors.white,
        child: Center(
          child: Column(children: <Widget>[
            new Container(
              padding: EdgeInsets.all(15.0),
              child: new Text(
                'Books',
                style: TextStyle(
                  fontSize: 20.0,
                ),
              ),
            ),
            new Expanded(
              child: StreamBuilder(
                stream: Firestore.instance.collection('books').snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData)
                    return new Center(child: new CircularProgressIndicator());
                  return ListView.separated(
                    itemCount: snapshot.data.documents.length,
                    itemBuilder: (context, index) =>
                    _buildListItem(context, snapshot.data.documents[index]),
                    separatorBuilder: (context, index) {
                      return Divider();
                    },
                  );
                },
              ),
            ),
          ]),
        ),
      ),
    );
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot document){
    return ListTile(
      title: Text(document['title']),
      subtitle: Text(document['author']),
      trailing: Text("Rp "+document['price'].toString()),
      leading: Container(
        width: 50.0,
        child: Image.network(document['image']),
      ),
    );
  }
}
