import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/addpasswordprovider.dart';
import '../../widgets/customemptywidget.dart';
import '../../widgets/custompasswordcard.dart';
import '../../widgets/customsearchfield.dart';
import 'addpassword.dart';

class VaultPage extends StatefulWidget {
  const VaultPage({super.key});

  @override
  State<VaultPage> createState() => _VaultPageState();
}

class _VaultPageState extends State<VaultPage> {
  final ScrollController _controller = ScrollController();
  final searchController = TextEditingController();

  @override
  void initState() {
    context.read<AddPasswordProvider>().fatchdata;
    super.initState();
  }

  @override
  void dispose() {
    searchController.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Vault',
        ),
      ),
      body: RefreshIndicator(
        color: Theme.of(context).primaryColor,
        onRefresh: () => context.read<AddPasswordProvider>().fatchdata,
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: size.width * 0.04,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                context.watch<AddPasswordProvider>().isloading
                    ? Center(
                        heightFactor: size.height * 0.02,
                        child: const CircularProgressIndicator(),
                      )
                    : Consumer<AddPasswordProvider>(
                        builder: (context, value, child) {
                          //if not loading & userpassword not empty
                          if (!value.isloading &&
                              value.userPasswords.isNotEmpty) {
                            //if search field is empty
                            if (searchController.text.isEmpty) {
                              return Expanded(
                                child: Column(
                                  children: [
                                    CustomSearchField(
                                        searchController: searchController,
                                        onChanged: (value) {
                                          context
                                              .read<AddPasswordProvider>()
                                              .controllertext = value;
                                        }),
                                    SizedBox(
                                      height: size.height * 0.03,
                                    ),
                                    ListView.separated(
                                        controller: _controller,
                                        scrollDirection: Axis.vertical,
                                        physics:
                                            const AlwaysScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        separatorBuilder: (context, index) =>
                                            SizedBox(
                                              height: size.height * 0.01,
                                            ),
                                        itemCount: value.userPasswords.length,
                                        itemBuilder: (context, index) {
                                          final data =
                                              value.userPasswords[index];

                                          return Custompasswordcard(
                                            data: data,
                                          );
                                        }),
                                  ],
                                ),
                              );
                            } else {
                              //if search field is not empty
                              return Expanded(
                                child: Column(
                                  children: [
                                    CustomSearchField(
                                      searchController: searchController,
                                      onChanged: (value) {
                                        context
                                            .read<AddPasswordProvider>()
                                            .controllertext = value;
                                      },
                                    ),
                                    SizedBox(
                                      height: size.height * 0.03,
                                    ),
                                    value.searchresult.isEmpty
                                        ? Expanded(
                                            child: Customemptywidget(
                                                svgString: 'assets/empty.svg',
                                                emptyString:
                                                    'No Matched Password Found.'),
                                          )
                                        : Expanded(
                                            child: ListView.separated(
                                                separatorBuilder: (context,
                                                        index) =>
                                                    SizedBox(
                                                      height:
                                                          size.height * 0.01,
                                                    ),
                                                itemCount:
                                                    value.searchresult.length,
                                                itemBuilder: (context, index) {
                                                  // search result
                                                  final data =
                                                      value.searchresult[index];
                                                  return Custompasswordcard(
                                                    data: data,
                                                  );
                                                }),
                                          ),
                                  ],
                                ),
                              );
                            }
                          } else {
                            //if userpassword empty
                            return Center(
                              child: Customemptywidget(
                                svgString: 'assets/not_found.svg',
                                emptyString: 'No Saved Password Found.',
                              ),
                            );
                          }
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
}
