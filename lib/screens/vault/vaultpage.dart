import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../../models/addpasswordmodel.dart';
import '../../provider/addpasswordprovider.dart';
import '../../widgets/custompageroute.dart';
import '../../widgets/customsearchfield.dart';
import 'addpassword.dart';
import 'viewpassword.dart';

class VaultPage extends StatefulWidget {
  const VaultPage({super.key});

  @override
  State<VaultPage> createState() => _VaultPageState();
}

class _VaultPageState extends State<VaultPage> {
  final ScrollController _controller = ScrollController();
  final searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // context.read<AddPasswordProvider>().fatchdata;
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () => context.read<AddPasswordProvider>().fatchdata,
        child: SafeArea(
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
                context.watch<AddPasswordProvider>().isloading
                    ? Center(
                        heightFactor: size.height * 0.02,
                        child: const CircularProgressIndicator(),
                      )
                    : Consumer<AddPasswordProvider>(
                        builder: (context, value, child) {
                          return !value.isloading &&
                                  value.userPasswords.isNotEmpty
                              ? searchController.text.isEmpty
                                  ? Expanded(
                                      child: Column(
                                        children: [
                                          CustomSearchField(
                                            searchController: searchController,
                                          ),
                                          SizedBox(
                                            height: size.height * 0.03,
                                          ),
                                          Expanded(
                                            child: ListView.separated(
                                                controller: _controller,
                                                scrollDirection: Axis.vertical,
                                                physics:
                                                    const AlwaysScrollableScrollPhysics(),
                                                shrinkWrap: true,
                                                separatorBuilder: (context,
                                                        index) =>
                                                    SizedBox(
                                                      height:
                                                          size.height * 0.01,
                                                    ),
                                                itemCount:
                                                    value.userPasswords.length,
                                                itemBuilder: (context, index) {
                                                  final data = value
                                                      .userPasswords[index];

                                                  return _buildCard(
                                                    context: context,
                                                    data: data,
                                                  );
                                                }),
                                          ),
                                        ],
                                      ),
                                    )
                                  : Expanded(
                                      child: Column(
                                        children: [
                                          CustomSearchField(
                                            searchController: searchController,
                                          ),
                                          value.searchresult.isEmpty
                                              ? Expanded(
                                                  child: SingleChildScrollView(
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Lottie.asset(
                                                            'assets/no-data-found-json.json'),
                                                        const Text(
                                                          'No Matched Password Found.',
                                                          style: TextStyle(
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                )
                                              : Expanded(
                                                  child: ListView.separated(
                                                      separatorBuilder:
                                                          (context, index) =>
                                                              SizedBox(
                                                                height:
                                                                    size.height *
                                                                        0.01,
                                                              ),
                                                      itemCount: value
                                                          .searchresult.length,
                                                      itemBuilder:
                                                          (context, index) {
                                                        // search result
                                                        final searchdata =
                                                            value.searchresult[
                                                                index];
                                                        return _buildCard(
                                                          context: context,
                                                          data: searchdata,
                                                        );
                                                      }),
                                                ),
                                        ],
                                      ),
                                    )
                              : Column(
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
                                );
                        },
                      ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            // MaterialPageRoute(
            //   builder: (context) => const AddPassword(),
            // ),
            CustomPageRoute(
              transitionduration: const Duration(
                milliseconds: 800,
              ),
              direction: AxisDirection.left,
              child: const AddPassword(),
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
    int calculateDifference(DateTime date) {
      // getfavicon(data.url!);
      DateTime now = DateTime.now();
      // var addeddate = DateTime.parse("2022-10-30 10:09:00");
      // var addeddate = DateTime.now();

      return now.difference(date).inDays;
    }

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
            // MaterialPageRoute(
            //   builder: (context) => const ViewPassword(),
            // ),
            CustomPageRoute(
              transitionduration: const Duration(
                milliseconds: 800,
              ),
              direction: AxisDirection.left,
              child: const ViewPassword(),
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
          leading: FutureBuilder<String>(
            initialData: '',
            future: context
                .read<AddPasswordProvider>()
                .getFavcicoUrl(url: data.url!),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              }
              if (snapshot.hasData) {
                return CachedNetworkImage(
                  placeholder: (context, url) => const SizedBox(
                    height: 32,
                    width: 32,
                    child: CircularProgressIndicator(),
                  ),
                  imageUrl: snapshot.data!,
                  errorWidget: (context, url, error) => const Icon(
                    Icons.error_outline,
                    size: 32,
                  ),
                );
              }

              return const Icon(
                Icons.language_outlined,
                size: 32,
              );
            },
          ),
          trailing: const Icon(Icons.arrow_forward_ios),
        ),
      ),
    );
  }
}
