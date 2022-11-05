import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:provider/provider.dart';

import '../provider/generatedpassswordprovideer.dart';

class GeneratorPage extends StatelessWidget {
  const GeneratorPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    // context.read<GeneratedPasswordProvider>().generatePassword;

    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: size.width * 0.07,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: size.height * 0.02,
                ),
                const Text(
                  'Generator',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  height: size.height * 0.02,
                ),
                Material(
                  color: Theme.of(context).highlightColor,
                  borderRadius: BorderRadius.circular(5),
                  child: Center(
                    heightFactor: 2.5,
                    child: Text(
                      context
                          .watch<GeneratedPasswordProvider>()
                          .generatedpassword,
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.black.withOpacity(0.5),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: size.height * 0.02,
                ),
                Material(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(5),
                  child: InkWell(
                    onTap: () {
                      context
                          .read<GeneratedPasswordProvider>()
                          .generatePassword;
                    },
                    borderRadius: BorderRadius.circular(5),
                    child: Center(
                      heightFactor: 3,
                      child: Text(
                          context
                                  .watch<GeneratedPasswordProvider>()
                                  .generatedpassword
                                  .isEmpty
                              ? 'Generate Password'
                              : 'Regenerate Password',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          )),
                    ),
                  ),
                ),
                SizedBox(
                  height: size.height * 0.01,
                ),
                InkWell(
                  onTap: () {
                    Clipboard.setData(
                      ClipboardData(
                        text: context
                            .read<GeneratedPasswordProvider>()
                            .generatedpassword,
                      ),
                    ).then(
                      (value) {
                        print(context
                            .read<GeneratedPasswordProvider>()
                            .generatedpassword);
                        return ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: Theme.of(context).primaryColor,
                            content: const Text('Password copied to clipboard'),
                          ),
                        );
                      },
                    );
                  },
                  borderRadius: BorderRadius.circular(5),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 1,
                        color: Colors.grey,
                      ),
                      borderRadius: BorderRadius.circular(5),
                      color: Theme.of(context).highlightColor,
                    ),
                    child: const Center(
                      heightFactor: 3,
                      child: Text('Copy Password',
                          style: TextStyle(
                            // color: Colors.white,
                            fontWeight: FontWeight.w500,
                          )),
                    ),
                  ),
                ),
                SizedBox(
                  height: size.height * 0.02,
                ),
                Text(
                  'Options',
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                _buildSiderOption(
                  titletext: 'Length',
                  hinttext: context
                      .watch<GeneratedPasswordProvider>()
                      .length
                      .floor()
                      .toString(),
                  onchanged: (value) {
                    context.read<GeneratedPasswordProvider>().length = value;
                  },
                  value: context.watch<GeneratedPasswordProvider>().length,
                ),
                _buildSwitchOption(
                  value:
                      context.watch<GeneratedPasswordProvider>().uppercaseatoz,
                  onchanged: (value) {
                    context.read<GeneratedPasswordProvider>().uppercaseatoz =
                        value;
                  },
                  hinttext: 'Uppercase ( A to Z )',
                  titletext: 'A-Z',
                ),
                _buildSwitchOption(
                  value:
                      context.watch<GeneratedPasswordProvider>().lowercaseatoz,
                  onchanged: (value) {
                    context.read<GeneratedPasswordProvider>().lowercaseatoz =
                        value;
                  },
                  hinttext: 'Lowercase ( a to z )',
                  titletext: 'a-z',
                ),
                _buildSwitchOption(
                  value: context.watch<GeneratedPasswordProvider>().number,
                  onchanged: (value) {
                    context.read<GeneratedPasswordProvider>().number = value;
                  },
                  hinttext: 'Numbers ( 0 to 9 )',
                  titletext: '0-9',
                ),
                _buildSwitchOption(
                  value: context.watch<GeneratedPasswordProvider>().specialchar,
                  onchanged: (value) {
                    context.read<GeneratedPasswordProvider>().specialchar =
                        value;
                  },
                  hinttext: 'Characters ( !@#\$^&* )',
                  titletext: '!@#\$^&*',
                ),
                _buildCounterOption(
                  enabled: context.watch<GeneratedPasswordProvider>().number,
                  color: Theme.of(context).primaryColor,
                  titletext: 'Mininum Numbers',
                  hinttext: context
                      .watch<GeneratedPasswordProvider>()
                      .minimumnumbers
                      .floor()
                      .toString(),
                  onincreament: () {
                    context
                        .read<GeneratedPasswordProvider>()
                        .minimumnumberincrement();
                  },
                  ondecrement: () {
                    context
                        .read<GeneratedPasswordProvider>()
                        .minimumnumberdecrement();
                  },
                ),
                _buildCounterOption(
                  enabled:
                      context.watch<GeneratedPasswordProvider>().specialchar,
                  color: Theme.of(context).primaryColor,
                  titletext: 'Mininum Special',
                  hinttext: context
                      .watch<GeneratedPasswordProvider>()
                      .minimumspecial
                      .floor()
                      .toString(),
                  onincreament: () {
                    context
                        .read<GeneratedPasswordProvider>()
                        .minimumnspecialincrement();
                  },
                  ondecrement: () {
                    context
                        .read<GeneratedPasswordProvider>()
                        .minimumspecialdecrement();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSiderOption({
    required String titletext,
    required String hinttext,
    required double value,
    required Function(double) onchanged,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(titletext),
        Row(
          children: [
            Text(hinttext),
            Slider(
              max: 20.0,
              min: 10,
              value: value,
              onChanged: onchanged,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSwitchOption({
    required String titletext,
    required String hinttext,
    required bool value,
    required Function(bool) onchanged,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(titletext),
        Row(
          children: [
            Text(hinttext),
            Switch(
              onChanged: onchanged,
              value: value,
            ),
          ],
        )
      ],
    );
  }

  Widget _buildCounterOption({
    required String titletext,
    required String hinttext,
    required VoidCallback onincreament,
    required VoidCallback ondecrement,
    required Color color,
    required bool enabled,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(titletext),
        Row(
          children: [
            Text(hinttext),
            const SizedBox(
              width: 10,
            ),
            ElevatedButton(
              onPressed: enabled ? ondecrement : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: color,
              ),
              child: const Icon(
                Icons.remove,
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: color,
              ),
              onPressed: enabled ? onincreament : null,
              child: const Icon(
                Icons.add,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
