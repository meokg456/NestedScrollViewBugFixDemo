import 'package:demo/models/core/generation.dart';
import 'package:demo/services/pokemon_services.dart';
import 'package:demo/utils/scroll_absorber.dart';
import 'package:demo/widgets/pokemon_widget.dart';
import 'package:flutter/material.dart';

class JohtoTab extends StatefulWidget {
  const JohtoTab({Key? key}) : super(key: key);

  @override
  _JohtoTabState createState() => _JohtoTabState();
}

class _JohtoTabState extends State<JohtoTab>
    with AutomaticKeepAliveClientMixin<JohtoTab> {
  late Generation johto;
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
    johto = await PokemonServices.getGeneration(2);
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
                      ...johto.pokemonSpecies.map(
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
