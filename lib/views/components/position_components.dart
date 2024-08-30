import 'package:flutter/material.dart';

import '../../data/models/driver.dart';
import '../../data/models/position.dart';
import '../../helpers/constants.dart';

class ResultHeader extends StatelessWidget {
  const ResultHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: pad8),
        child: Row(
          children: [
            const Expanded(
              flex: 1,
              child: Text(
                'POS',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            const Expanded(
              flex: 1,
              child: Text(
                'NO',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            const Expanded(
              flex: 1,
              child: Text(
                'DRIVER',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(right: pad8),
              height: 15,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(pad4),
                border: Border(
                  left: Divider.createBorderSide(
                    context,
                    color: Colors.transparent,
                    width: pad8,
                  ),
                ),
              ),
            ),
            const Expanded(
              flex: 2,
              child: Text(
                'TEAM',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SessionResultItem extends StatelessWidget {
  const SessionResultItem({
    super.key,
    required this.position,
    required this.driver,
  });

  final Position position;
  final Driver driver;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: pad16, vertical: pad8),
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Text(
                '${position.position}',
              ),
            ),
            Expanded(
              flex: 1,
              child: Text(
                '${position.driverNumber}',
              ),
            ),
            Container(
              margin: const EdgeInsets.only(right: pad8),
              height: 15,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(pad4),
                border: Border(
                  left: Divider.createBorderSide(
                    context,
                    color:
                        Color(int.parse('FF${driver.teamColour}', radix: 16)),
                    width: pad8,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Text(
                '${driver.nameAcronym}',
              ),
            ),
            Expanded(
              flex: 2,
              child: Text(
                '${driver.teamName}',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
