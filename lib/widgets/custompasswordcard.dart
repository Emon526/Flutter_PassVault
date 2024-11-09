import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/addpasswordmodel.dart';
import '../provider/addpasswordprovider.dart';
import '../screens/vault/viewpassword.dart';

class Custompasswordcard extends StatelessWidget {
  final AddPasswordModel data;
  const Custompasswordcard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    int calculateDifference(DateTime date) {
      DateTime now = DateTime.now();
      // var addeddate = DateTime.parse("2022-10-30 10:09:00");
      // var addeddate = DateTime.now();

      return now.difference(date).inDays;
    }

    return ListTile(
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
      title: Text(
        data.title,
        style: Theme.of(context)
            .textTheme
            .titleMedium!
            .copyWith(color: Colors.white),
      ),
      subtitle: Text(
        calculateDifference(data.addeddate) == 0
            ? 'Added Today'
            : calculateDifference(data.addeddate) == 1
                ? 'Added Yesterday'
                : 'Added ${calculateDifference(data.addeddate)} days ago',
        style: Theme.of(context)
            .textTheme
            .titleSmall!
            .copyWith(color: Colors.white),
      ),
      leading: FutureBuilder<String>(
        initialData: '',
        future:
            context.read<AddPasswordProvider>().getFavcicoUrl(url: data.url!),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }
          if (snapshot.hasData) {
            return CachedNetworkImage(
              placeholder: (context, url) => const SizedBox(
                child: CircularProgressIndicator(),
              ),
              imageUrl: snapshot.data!,
              errorWidget: (context, url, error) => const Icon(
                Icons.error_outline,
              ),
            );
          }

          return const Icon(
            Icons.language_outlined,
          );
        },
      ),
      trailing: const Icon(Icons.arrow_forward_ios),
    );
  }
}
