import 'package:flutter/material.dart';
import 'package:openViewF1/helpers/constants.dart';

typedef ViewTypeCallback = void Function(ViewType viewType);

class AppBarDesign extends StatefulWidget implements PreferredSizeWidget {
  const AppBarDesign({
    super.key,
    this.viewTypeCallback,
    this.appBarTitle,
  });

  final Widget? appBarTitle;
  final Function? viewTypeCallback;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  State<AppBarDesign> createState() => _AppBarDesignState();
}

class _AppBarDesignState extends State<AppBarDesign> {
  ViewType viewType = ViewType.list;
  late Widget? appBarTitle;

  @override
  void initState() {
    super.initState();
    appBarTitle = widget.appBarTitle;
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: appBarTitle ?? const Text('OpenViewF1'),
      actions: [
        MenuAnchor(
          menuChildren: <Widget>[
            // TODO: Use a local caching system to store state
            appBarTitle != null
                ? const SizedBox.shrink()
                : MenuItemButton(
                    onPressed: () {
                      widget.viewTypeCallback!(viewType);
                      viewType = changeViewType(viewType);
                    },
                    leadingIcon: viewType == ViewType.list
                        ? const Icon(Icons.grid_view_sharp)
                        : const Icon(Icons.view_list_sharp),
                    child: viewType == ViewType.list
                        ? const Text('Grid View')
                        : const Text('List View')),
            MenuItemButton(
                // TODO: Implement a callback filter
                onPressed: () {
                  showModalBottomSheet(
                    showDragHandle: true,
                    context: context,
                    builder: (context) => BottomSheet(
                      onClosing: () => Navigator.pop(context),
                      builder: (context) => const Column(
                        mainAxisSize: MainAxisSize.max,
                      ),
                    ),
                  );
                },
                leadingIcon: const Icon(Icons.filter_alt),
                child: const Text('Filter')),
            MenuItemButton(
                onPressed: () {},
                leadingIcon: const Icon(Icons.settings),
                child: const Text('Settings')),
          ],
          builder: (context, controller, child) {
            return IconButton(
              onPressed: () {
                controller.isOpen ? controller.close() : controller.open();
              },
              icon: const Icon(Icons.more_vert),
            );
          },
        )
      ],
    );
  }
}
