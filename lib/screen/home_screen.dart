import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int defaultTabLength = 4;
  String dummyTweet =
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.';
  bool isHeaderClose = false;
  double lastOffset = 0;
  ScrollController scrollController;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
    scrollController.addListener(() {
      print(scrollController.offset);
      if (scrollController.offset <= 0) {
        isHeaderClose = false;
      } else if (scrollController.offset >=
          scrollController.position.maxScrollExtent) {
        isHeaderClose = true;
      } else {
        isHeaderClose = scrollController.offset > lastOffset ? true : false;
      }
      setState(() {
        lastOffset = scrollController.offset;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        floatingActionButton: _fabButton,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: _bottomAppBar,
        body: SafeArea(
          child: DefaultTabController(
            length: 4,
            child: Column(
              children: <Widget>[
                _containerAppbar,
                _expandedListView
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget get _bottomAppBar => BottomAppBar(
    shape: CircularNotchedRectangle(),
    child: _tabBarItems,
  );


  Widget get _fabButton => FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
      );

  Widget get _tabBarItems => TabBar(
        tabs: <Widget>[
          Tab(icon: Icon(Icons.home)),
          Tab(icon: Icon(Icons.notifications)),
          Tab(icon: Icon(Icons.chat_bubble)),
          Tab(icon: Icon(Icons.person)),
        ],
      );

  Widget get _expandedListView => Expanded(
      child: _listview);

  Widget get _listview => ListView.builder(
        itemCount: 10,
        controller: scrollController,
        itemBuilder: (context, index) {
          return _listViewCard;
        },
      );

  Widget get _listViewCard => Card(
        child: ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage('images/icon.png'),
            ),
            title: Wrap(
              direction: Axis.horizontal,
              runSpacing: 5,
              children: <Widget>[
                _listCardTitle('Hello'),
                Text(dummyTweet),
                _placeHolderField,
                _footerButtonRow,
              ],
            )),
      );

  Widget get _emptySpace => SizedBox(
        height: 10,
      );

  Widget _listCardTitle(String text) => Text(
        text,
        style: titleTextStyle,
      );

  Widget get _placeHolderField => Container(
        height: 100,
        child: Placeholder(),
      );

  Widget get _footerButtonRow => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          _iconLabelButton,
          _iconLabelButton,
          _iconLabelButton,
          _iconLabelButton,
        ],
      );

  Widget _iconLabel(String text) => Wrap(
        spacing: 5,
        children: <Widget>[
          Icon(
            Icons.comment,
            size: 30,
            color: CupertinoColors.inactiveGray,
          ),
          Text(text),
        ],
      );

  Widget get _iconLabelButton => InkWell(
        child: _iconLabel('1'),
        onTap: () {},
      );

  Widget get _containerAppbar => AnimatedContainer(
        duration: Duration(milliseconds: 500),
        height: isHeaderClose ? 0 : 100,
        child: _appBar,
      );

  Widget get _appBar => AppBar(
//        backgroundColor: Colors.greenAccent,
        elevation: 0,
        centerTitle: false,
        title: _appBarItems,
      );

  Widget get _appBarItems => Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        spacing: 10,
        children: <Widget>[
          CircleAvatar(
            backgroundImage: AssetImage('images/icon.png'),
          ),
          Text(
            'Twitterer', style: TextStyle(color: Colors.blue,),
          ),
        ],
      );
}

final titleTextStyle = TextStyle(
    letterSpacing: 1,
    fontSize: 20,
    fontWeight: FontWeight.w800,
    color: Colors.black);
