import 'package:demo/models/core/generation.dart';
import 'package:demo/services/pokemon_services.dart';
import 'package:demo/utils/scroll_absorber.dart';
import 'package:demo/widgets/pokemon_widget.dart';
import 'package:flutter/material.dart';

class HoennTab extends StatefulWidget {
  const HoennTab({Key? key}) : super(key: key);

  @override
  _HoennTabState createState() => _HoennTabState();
}

class _HoennTabState extends State<HoennTab>
    with AutomaticKeepAliveClientMixin<HoennTab> {
  late Generation hoenn;
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
    hoenn = await PokemonServices.getGeneration(3);
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
                      ...hoenn.pokemonSpecies.map(
                        (pokemon) => PokemonWidget(pokemon),
                      ),
                    ]),
                  ),
                )
              ],
            ),
          );
  }

  @override
  bool get wantKeepAlive => true;
}
