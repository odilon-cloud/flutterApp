import 'package:fast_contacts/fast_contacts.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class ContactsPage extends StatefulWidget {
  final String? email;

  const ContactsPage({Key? key, this.email}) : super(key: key);

  @override
  _ContactsPageState createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {
  bool sortAlphabetically = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Contact List"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.sort_by_alpha),
            onPressed: () {
              setState(() {
                sortAlphabetically = !sortAlphabetically;
              });
            },
          ),
        ],
      ),
      body: Container(
        height: double.infinity,
        child: FutureBuilder<List<Contact>>(
          future: getContacts(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            }
            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(
                child: Text('No contacts available'),
              );
            }
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                Contact contact = snapshot.data![index];
                return Column(
                  children: [
                    ListTile(
                      leading: const CircleAvatar(
                        radius: 20,
                        child: Icon(Icons.person),
                      ),
                      title: Text(contact.displayName != null ? contact.displayName! : 'No name'),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(contact.phones.isNotEmpty ? contact.phones[0].number : 'No phone number'),
                          Text(contact.emails.isNotEmpty ? contact.emails[0].address : 'No email'),
                        ],
                      ),
                    ),
                    const Divider()
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }

  Future<List<Contact>> getContacts() async {
    bool isGranted = await Permission.contacts.status.isGranted;
    if (!isGranted) {
      isGranted = await Permission.contacts.request().isGranted;
    }
    if (isGranted) {
      List<Contact> contacts = await FastContacts.getAllContacts();
      if (sortAlphabetically) {
        contacts.sort((a, b) => a.displayName!.compareTo(b.displayName!));
      }
      return contacts;
    }
    return [];
  }
}