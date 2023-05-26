import 'package:flutter/material.dart';

class ErrorComponent extends StatelessWidget {
  final String title;
  final String subtitle;
  final List<Widget>? buttons;
  const ErrorComponent(
      {super.key,
      required this.title,
      required this.subtitle,
      required this.buttons});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const Expanded(child: SizedBox()),
          Material(
            elevation: 20,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(8), topRight: Radius.circular(8)),
                border: Border.all(color: Colors.grey),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Flexible(
                        flex: 4,
                        child: Container(),
                      ),
                      const Flexible(
                          flex: 2,
                          child: Divider(
                            thickness: 2,
                            color: Colors.grey,
                          )),
                      Flexible(
                        flex: 4,
                        child: Container(),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          title,
                        ),
                        const SizedBox(height: 20),
                        ConstrainedBox(
                          constraints: const BoxConstraints(maxHeight: 250),
                          child: SingleChildScrollView(
                            child: Text(
                              subtitle,
                            ),
                          ),
                        ),
                        const SizedBox(height: 26),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [...buttons ?? []],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
