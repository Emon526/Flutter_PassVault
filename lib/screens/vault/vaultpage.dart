import 'package:flutter/material.dart';
import 'package:passvault/screens/vault/viewpassword.dart';
import 'package:passvault/services/databaseservice.dart';
import 'package:provider/provider.dart';

import '../../models/addpasswordmodel.dart';
import '../../provider/addpasswordprovider.dart';
import '../../widgets/customsearchfield.dart';
import 'addpassword.dart';

class VaultPage extends StatelessWidget {
  const VaultPage({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<AddPasswordProvider>().fatchdata;
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
              Expanded(
                child: Consumer<AddPasswordProvider>(
                  builder: (context, value, child) {
                    return ListView.separated(
                        separatorBuilder: (context, index) => SizedBox(
                              height: size.height * 0.01,
                            ),
                        itemCount: value.userPasswords.length,
                        itemBuilder: (context, index) {
                          final data = value.userPasswords[index];
                          return _buildCard(
                            context: context,
                            data: data,
                          );
                        });
                  },
                ),
              ),
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
    required AddPasswordModel data,
  }) {
    // var iconUrl = FaviconFinder.getBest('https://www.mashable.com');

    // var iconUrl = Favicon(data.url!);
    // print(iconUrl.url);
    // var iconUrls = FaviconFinder.getBest(data.url!);
    // print(iconUrls);
    return Material(
      elevation: 1,
      color: Theme.of(context).scaffoldBackgroundColor,
      borderRadius: BorderRadius.circular(5),
      child: InkWell(
        borderRadius: BorderRadius.circular(5),
        onTap: () {
          context
              .read<AddPasswordProvider>()
              .getPasswordData(id: int.parse(data.id));
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const ViewPassword(),
            ),
          );
        },
        child: ListTile(
          title: Text(data.title),
          subtitle: Text(data.username),
          // leading: CircleAvatar(
          //   backgroundImage: NetworkImage('https://${url}'),
          // ),
          // leading: CachedNetworkImage(
          //   color: Colors.red,
          //   fit: BoxFit.cover,
          //   imageUrl: 'https://${data.url}',
          //   errorWidget: (context, url, error) => Icon(Icons.language_outlined),
          // ),
          // leading: CircleAvatar(
          //   backgroundImage: NetworkImage(iconUrl.url),
          // ),
          trailing: Icon(Icons.arrow_forward_ios),
        ),
      ),
    );
  }
}
