import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../data/models/session.dart';
import '../../helpers/constants.dart';

class SessionListItem extends StatefulWidget {
  final Session data;

  const SessionListItem({
    super.key,
    required this.data,
  });

  @override
  State<SessionListItem> createState() => _SessionListItemState();
}

class _SessionListItemState extends State<SessionListItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: pad8),
      child: Card.outlined(
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(pad8),
              child: Column(
                children: [
                  Text(
                    '${widget.data.sessionName}',
                    style: const TextStyle(
                        fontSize: 21, fontWeight: FontWeight.bold),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Card.outlined(
                          child: Padding(
                            padding: const EdgeInsets.all(pad4),
                            child: Text(
                              DateFormat.MMMEd().format(widget.data.dateStart!),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Card.outlined(
                          child: Padding(
                            padding: const EdgeInsets.all(pad4),
                            child: Text(
                              '${DateFormat.Hm().format(widget.data.dateStart!)} - ${DateFormat.Hm().format(widget.data.dateEnd!)}',
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Divider(height: 0),
            InkWell(
              onTap: () {
                dynamic queryParams = {
                  'session_key': '${widget.data.sessionKey}',
                };

                context.goNamed('result', queryParameters: queryParams);
              },
              child: Ink(
                color: Theme.of(context).secondaryHeaderColor,
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: pad8),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'View results',
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
