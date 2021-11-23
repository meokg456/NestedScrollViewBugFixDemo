import 'package:demo/models/core/generation.dart';
import 'package:demo/services/pokemon_services.dart';
import 'package:demo/utils/scroll_absorber.dart';
import 'package:demo/widgets/pokemon_widget.dart';
import 'package:flutter/material.dart';
import 'package:demo/utils/string_utils.dart';

class KantoTab extends StatefulWidget {
  const KantoTab({Key? key}) : super(key: key);

  @override
  _KantoTabState createState() => _KantoTabState();
}

class _KantoTabState extends State<KantoTab>
    with AutomaticKeepAliveClientMixin<KantoTab> {
  late Generation kanto;
  bool _isLoading = false;
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    _loadData();
    super.initState();
  }

  Future<void> _loadData() async {
    setState(() {
      _isLoading = true;
    });
    kanto = await PokemonServices.getGeneration(1);
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return _isLoading
        ? Center(
            child: CircularProgressIndicator(),
          )
        : NotificationListener(
            onNotification: (Notification notification) {
              ScrollAbsorber.absorbScrollNotification(notification);
              return true;
            },
            child: CustomScrollView(
              cacheExtent: double.infinity,
              controller: _scrollController,
              slivers: [
                SliverOverlapInjector(
                  // This is the flip side of the SliverOverlapAbsorber
                  // above.
                  handle:
                      NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                ),
                SliverPadding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  sliver: SliverList(
                      delegate: SliverChildListDelegate([
                    ...kanto.pokemonSpecies
                        .map((pokemon) => PokemonWidget(pokemon))
                  ])),
                )
              ],
            ),
          );
  }

  @override
  bool get wantKeepAlive => true;
}
