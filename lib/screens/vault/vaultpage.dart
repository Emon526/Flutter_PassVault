import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../models/addpasswordmodel.dart';
import '../../provider/addpasswordprovider.dart';
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
        centerTitle: true,
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
              crossAxisAlignment: CrossAxisAlignment.start,
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
                              ? searchController.text.isEmpty
                                  ? Expanded(
                                      child: Column(
                                        children: [
                                          CustomSearchField(
                                              searchController:
                                                  searchController,
                                              onChanged: (value) {
                                                context
                                                    .read<AddPasswordProvider>()
                                                    .controllertext = value;
                                              }),
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
                                                  child: SingleChildScrollView(
                                                    child: Column(
                                                      children: [
                                                        SizedBox(
                                                          height:
                                                              size.height * 0.1,
                                                        ),
                                                        SvgPicture.asset(
                                                          'assets/empty.svg',
                                                          height:
                                                              size.height * 0.4,
                                                        ),
                                                        SizedBox(
                                                          height: size.height *
                                                              0.01,
                                                        ),
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
                              : Expanded(
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: size.height * 0.1,
                                      ),
                                      SvgPicture.asset(
                                        'assets/not_found.svg',
                                        height: size.height * 0.4,
                                      ),
                                      SizedBox(
                                        height: size.height * 0.01,
                                      ),
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
    int calculateDifference(DateTime date) {
      DateTime now = DateTime.now();
      // var addeddate = DateTime.parse("2022-10-30 10:09:00");
      // var addeddate = DateTime.now();

      return now.difference(date).inDays;
    }

    return Material(
      elevation: 1,
      borderRadius: BorderRadius.circular(5),
      child: InkWell(
        borderRadius: BorderRadius.circular(5),
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
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
