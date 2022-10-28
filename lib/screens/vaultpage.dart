import 'package:flutter/material.dart';

import '../widgets/customsearchfield.dart';

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
              ),
              _buildCard(
                context: context,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(
          Icons.add,
        ),
      ),
    );
  }

  Widget _buildCard({required BuildContext context}) {
    return Material(
      color: Theme.of(context).scaffoldBackgroundColor,
      borderRadius: BorderRadius.circular(5),
      child: InkWell(
        borderRadius: BorderRadius.circular(5),
        onTap: () {},
        child: const ListTile(
          title: Text('Yahoo'),
          subtitle: Text('Added today'),
          leading: CircleAvatar(
            backgroundImage: NetworkImage('https://www.google.com/favicon.ico'),
          ),
          trailing: Icon(Icons.arrow_forward_ios),
        ),
      ),
    );
  }
}
