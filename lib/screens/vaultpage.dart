import 'package:flutter/material.dart';

import '../widgets/customsearchfield.dart';
import 'addpassword.dart';

class VaultPage extends StatelessWidget {
  const VaultPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final searchController = TextEditingController();
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: size.width * 0.07,
          ),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: size.height * 0.03,
              ),
              const Text(
                'Vault',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(
                height: size.height * 0.03,
              ),
              CustomSearchField(
                searchController: searchController,
              ),
              SizedBox(
                height: size.height * 0.03,
              ),
              _buildCard(
                  context: context,
                  title: 'Yahoo',
                  addeddate: 'Added today',
                  url: 'www.google.com/favicon.ico'),
              _buildCard(
                  context: context,
                  title: 'Google',
                  addeddate: 'Added yesterday',
                  url: 'www.google.com/favicon.ico'),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddPassword(),
            ),
          );
        },
        child: const Icon(
          Icons.add,
        ),
      ),
    );
  }

  Widget _buildCard({
    required BuildContext context,
    required String addeddate,
    required String title,
    required String url,
  }) {
    return Material(
      elevation: 1,
      color: Theme.of(context).scaffoldBackgroundColor,
      borderRadius: BorderRadius.circular(5),
      child: InkWell(
        borderRadius: BorderRadius.circular(5),
        onTap: () {},
        child: ListTile(
          title: Text(title),
          subtitle: Text(addeddate),
          leading: CircleAvatar(
            backgroundImage: NetworkImage('https://${url}'),
          ),
          trailing: Icon(Icons.arrow_forward_ios),
        ),
      ),
    );
  }
}
