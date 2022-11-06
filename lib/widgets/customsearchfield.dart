import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/addpasswordprovider.dart';

class CustomSearchField extends StatelessWidget {
  const CustomSearchField({
    super.key,
    required this.searchController,
  });

  final TextEditingController searchController;

  @override
  Widget build(BuildContext context) {
    return Material(
      // color: const Color.fromRGBO(238, 238, 238, 1),
      borderRadius: BorderRadius.circular(
        5,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: [
            const Icon(
              Icons.search_outlined,
            ),
            Expanded(
              child: TextFormField(
                onChanged: (value) {
                  context.read<AddPasswordProvider>().controllertext = value;
                },
                controller: searchController,
                textCapitalization: TextCapitalization.sentences,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.done,
                decoration: const InputDecoration(
                  hintText: ' Search For Passwords',
                  enabledBorder:
                      OutlineInputBorder(borderSide: BorderSide.none),
                  border: OutlineInputBorder(borderSide: BorderSide.none),
                  focusedBorder:
                      OutlineInputBorder(borderSide: BorderSide.none),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
