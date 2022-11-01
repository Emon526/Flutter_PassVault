import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../../models/addpasswordmodel.dart';
import '../../provider/addpasswordprovider.dart';
import '../../widgets/customsearchfield.dart';
import 'addpassword.dart';
import 'viewpassword.dart';

class VaultPage extends StatelessWidget {
  const VaultPage({super.key});

  @override
  Widget build(BuildContext context) {
    // context.read<AddPasswordProvider>().fatchdata;
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
              Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  context.watch<AddPasswordProvider>().isloading
                      ? Center(
                          heightFactor: size.height * 0.02,
                          child: const CircularProgressIndicator(),
                        )
                      : Consumer<AddPasswordProvider>(
                          builder: (context, value, child) {
                            return !value.isloading &&
                                    value.userPasswords.isNotEmpty
                                ? Column(
                                    children: [
                                      CustomSearchField(
                                        searchController: searchController,
                                      ),
                                      SizedBox(
                                        height: size.height * 0.03,
                                      ),
                                      ListView.separated(
                                          shrinkWrap: true,
                                          separatorBuilder: (context, index) =>
                                              SizedBox(
                                                height: size.height * 0.01,
                                              ),
                                          itemCount: value.userPasswords.length,
                                          itemBuilder: (context, index) {
                                            final data =
                                                value.userPasswords[index];
                                            return _buildCard(
                                              context: context,
                                              data: data,
                                            );
                                          }),
                                    ],
                                  )
                                : Center(
                                    child: Column(
                                      // mainAxisAlignment: MainAxisAlignment.center,
                                      // crossAxisAlignment:
                                      //     CrossAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          height: size.height * 0.1,
                                        ),
                                        Lottie.asset(
                                            'assets/no-data-found-json.json'),
                                        const Text(
                                          'No Saved Password Found.',
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        )
                                      ],
                                    ),
                                  );
                          },
                        ),
                ],
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
    /// Returns the difference (in full days) between the provided date and today.
    int calculateDifference(DateTime date) {
      DateTime now = DateTime.now();
      // var addeddate = DateTime.parse("2022-10-30 10:09:00");
      // var addeddate = DateTime.now();
      return now.difference(date).inDays;
    }

    return Material(
      elevation: 1,
      color: Theme.of(context).scaffoldBackgroundColor,
      // color: Colors.amber,
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
          title: Text(
            data.title,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
            ),
          ),
          subtitle: Text(
            calculateDifference(data.addeddate) == 0
                ? 'Added Today'
                : calculateDifference(data.addeddate) == 1
                    ? 'Added Yesterday'
                    : 'Added ${calculateDifference(data.addeddate)} days ago',
          ),
          leading: CachedNetworkImage(
            // color: Colors.red,
            imageBuilder: (context, imageProvider) =>
                Image(image: NetworkImage(data.url!)),
            placeholder: (context, url) => const Icon(Icons.language_outlined),
            imageUrl: data.url!,
            errorWidget: (context, url, error) => const Icon(
              Icons.language_outlined,
              size: 40,
            ),
          ),
          trailing: const Icon(Icons.arrow_forward_ios),
        ),
      ),
    );
  }
}
