import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:hexcolor/hexcolor.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

enum Collection { songs, albums, podcasts }

bool isRadio = false;
final Duration duration = Duration(seconds: 1);
final Curve curve = Curves.fastOutSlowIn;
final GlobalKey<AnimatedListState> keyList = GlobalKey<AnimatedListState>();


class _MyAppState extends State<MyApp> {
  bool isDark = false;

  void _toggleThem(){
    setState(() {
      isDark=!isDark;
    });
  }
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        brightness: Brightness.light,
        bottomSheetTheme: BottomSheetThemeData(
          backgroundColor: Colors.deepPurple[50],
        ),
        textTheme: TextTheme(titleMedium: TextStyle(color: Colors.black87)),
        cardTheme: CardThemeData(
            color: Colors.deepPurple[200],
            elevation: 20.0,
          shadowColor: Colors.black26,

        ),
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: HexColor('#1b1a1d'),
        appBarTheme: AppBarTheme(
          backgroundColor: HexColor('#1b1a1d'),
          titleTextStyle: TextStyle(color: Colors.deepPurple[50], fontSize: 20),
          actionsIconTheme: IconThemeData(color: Colors.deepPurple[50]),
          iconTheme: IconThemeData(color: Colors.deepPurple[50]),
        ),
        cardTheme: CardThemeData(
          color: Colors.purple[900],
          elevation: 1.0
        ),
        drawerTheme: DrawerThemeData(
          backgroundColor: HexColor('#1b1a1d'),
          // scrimColor: Colors.deepPurple[50]
        ),
        bottomSheetTheme: BottomSheetThemeData(
          backgroundColor: HexColor('#2c2a2f'),
        ),
        textTheme: TextTheme(titleMedium: TextStyle(color: Colors.white60)),
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.dark,
        ),
      ),
      themeMode: isDark ? ThemeMode.dark : ThemeMode.light,

      home:  MyHomePage(
        title: 'Flutter Widget',
          isDark:isDark,
        onThemeChanged:_toggleThem,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title,required this.isDark,required this.onThemeChanged});

  final String title;
  final bool isDark;
  final VoidCallback onThemeChanged;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

List<String> me = ['Sonia', 'Alraini'];

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  late AnimationController controller;
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: Duration(seconds: 10),
  )..repeat();
  late AnimationController drawerController;
  late Animation<Color?> colorAnimation;
  bool _drawerOpen = false;
  bool isChecked = false;
  bool light = true;
  bool selected = false;

  late final animation = Tween(begin: 0.0, end: 2 * pi).animate(_controller);
  List<dynamic> items = [];

  Future<void> loadIsonData() async {
    final String response = await rootBundle.loadString('assets/data.json');
    final data = json.decode(response);
    setState(() {
      items = data;
    });
  }

  @override
  void initState() {
    super.initState();
    loadIsonData();
    controller =
        AnimationController(vsync: this, duration: Duration(seconds: 5))
          ..addListener(() {
            setState(() {});
          })
          ..repeat(reverse: true);
    drawerController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );
    colorAnimation = ColorTween(
      begin: Colors.transparent,
      end: Colors.black38,
    ).animate(drawerController);
  }

  void toggleDrawer() {
    setState(() {
      _drawerOpen = !_drawerOpen;
      if (_drawerOpen) {
        drawerController.forward();
      } else {
        drawerController.reverse();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
    _controller.dispose();
  }

  bool isContainerAnimated = true;
  final bool _first = false;
  bool _usePrimaryColor = true;

  @override
  Widget build(BuildContext context) {
    Collection col = Collection.songs;
    final TextStyle style1 = TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.bold,
      color: Colors.deepPurple[400],
    );
    final TextStyle style2 = TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.normal,
      color: Colors.deepPurple[200],
    );
    final TextStyle currentStyle = _usePrimaryColor ? style1 : style2;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(
            onPressed: widget.onThemeChanged,
            icon: widget.isDark
                ? Icon(Icons.dark_mode)
                : Icon(Icons.light_mode_rounded),
          ),
        ],
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Column(
                        // crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          AnimatedCrossFade(
                            firstChild: Container(
                              width: 15,
                              height: 15,
                              color: Colors.deepPurple[500],
                            ),
                            secondChild: FlutterLogo(
                              size: 40.0,
                              style: FlutterLogoStyle.stacked,
                            ),
                            crossFadeState: _first
                                ? CrossFadeState.showFirst
                                : CrossFadeState.showSecond,
                            duration: Duration(seconds: 10),
                          ),
                          Divider(height: 5.0),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                isContainerAnimated = !isContainerAnimated;
                              });
                            },
                            child: AnimatedContainer(
                              duration: Duration(seconds: 5),
                              width: isContainerAnimated ? 30.0 : 20.0,
                              height: isContainerAnimated ? 20.0 : 30.0,
                              color: isContainerAnimated
                                  ? Colors.deepPurple[100]
                                  : Colors.deepPurple[300],
                              alignment: isContainerAnimated
                                  ? Alignment.center
                                  : Alignment.topCenter,
                            ),
                          ),
                          Divider(),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                selected = !selected;
                              });
                            },
                            child: Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                color: Colors.deepPurple[100],
                                shape: BoxShape.circle,
                              ),
                              child: AnimatedAlign(
                                alignment: selected
                                    ? Alignment.topRight
                                    : Alignment.bottomLeft,
                                duration: duration,
                                curve: curve,
                                child: Container(
                                  width: 15,
                                  height: 15,
                                  decoration: BoxDecoration(
                                    color: Colors.deepPurple[300],
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Divider(),
                          AnimatedBuilder(
                            animation: animation,
                            child: Container(
                              height: 20,
                              width: 20,
                              color: Colors.deepPurple[300],
                            ),
                            builder: (context, child) {
                              return Transform.rotate(
                                angle: animation.value,
                                child: child,
                              );
                            },
                          ),
                          Divider(),
                          Switch(
                            value: light,
                            onChanged: (value) {
                              setState(() {
                                light = !light;
                              });
                            },
                          ),
                          IconButton.outlined(
                            onPressed: () {},
                            icon: Icon(Icons.account_tree_outlined),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: Badge(
                              label: Text('0'),
                              backgroundColor: Colors.deepPurple[200],
                              child: Icon(Icons.shopping_cart),
                            ),
                          ),
                          Checkbox(
                            value: isChecked,
                            onChanged: (value) {
                              setState(() {
                                isChecked = !isChecked;
                              });
                            },
                          ),
                          Radio(
                            value: true,
                            groupValue: isRadio,
                            onChanged: (bool? value) {
                              setState(() {
                                isRadio = value!;
                              });
                            },
                          ),
                        ],
                      ),
                      Container(
                        padding: EdgeInsetsDirectional.only(top: 20.0),
                        height: 670,
                        width: 1.0,
                        color: widget.isDark?Colors.white60:Colors.black26,
                        // color: isDark ? Colors.black38 : Colors.deepPurple[50],
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                            child: SingleChildScrollView(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  // Container(
                                  //   height: 100,
                                  //   width: 100,
                                  //   child: AnimatedList(
                                  //     key: keyList,
                                  //     itemBuilder: (context, index, animation) {
                                  //     return Text(me[index]);
                                  //
                                  //   },
                                  //   initialItemCount: me.length,
                                  //   ),
                                  // ),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _usePrimaryColor = !_usePrimaryColor;
                                      });
                                    },
                                    child: AnimatedDefaultTextStyle(
                                      style: currentStyle,
                                      duration: Duration(seconds: 5),
                                      curve: Curves.easeInOut,
                                      textAlign: TextAlign.center,
                                      child: Text('Sonia'),
                                    ),
                                  ),
                                  // Divider(),
                                  SizedBox(
                                    width: 300,
                                    child: LinearProgressIndicator(
                                      value: controller.value,
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  SegmentedButton(
                                    segments: [
                                      ButtonSegment(
                                        value: Collection.songs,
                                        label: Text('Songs'),
                                      ),
                                      ButtonSegment(
                                        value: Collection.albums,
                                        label: Text('Albums'),
                                      ),
                                      ButtonSegment(
                                        value: Collection.podcasts,
                                        label: Text('Podcasts'),
                                      ),
                                    ],
                                    selected: {col},
                                  ),
                                  Divider(height: 7, thickness: 1),
                                  OutlinedButton(
                                    onPressed: () {
                                      final size = MediaQuery.of(context).size;
                                      print(
                                        "Width: ${size.width}, Height: ${size.height}",
                                      );
                                    },
                                    child: Text('OutlinedButton'),
                                  ),
                                  FilledButton(
                                    onPressed: () {},
                                    child: Text('FilledButton'),
                                  ),
                                  FilledButton.tonal(
                                    onPressed: () {},
                                    child: Text('Never Give up'),
                                  ),
                                  Semantics(
                                    label: 'Fly me to the moon',
                                    child: ElevatedButton(
                                      style: ButtonStyle(
                                        backgroundColor:
                                            WidgetStateProperty.resolveWith<
                                              Color?
                                            >((Set<WidgetState> states) {
                                              if (states.contains(
                                                WidgetState.pressed,
                                              )) {
                                                return Theme.of(context)
                                                    .colorScheme
                                                    .primary
                                                    .withOpacity(0.8);
                                              }
                                              return null;
                                            }),
                                      ),
                                      onPressed: () {},
                                      child: Text('Fly me to the moon'),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 100,
                                    child: Chip(
                                      label: Text('Chip'),
                                      avatar: Icon(Icons.flip_camera_ios_sharp),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          DraggableScrollableSheet(
            minChildSize: 0.0,
            maxChildSize: 1.0,
            initialChildSize: 0.1,
            builder: (context, scrollController) {
              final ThemeData theme = Theme.of(context);
              final Color sheetBackgroundColor =
                  theme.bottomSheetTheme.backgroundColor ?? theme.cardColor;
              final Color PrimaryTextColor =
                  theme.textTheme.titleMedium?.color ??
                  theme.colorScheme.onSurface;
              final Color secondaryTextColor =
                  theme.textTheme.bodyMedium?.color ??
                  theme.colorScheme.onSurface.withOpacity(0.7);

              return Container(
                decoration: BoxDecoration(
                  color: sheetBackgroundColor,
                  // color: isDark ?Colors.deepPurple[50]:HexColor('#1b1a1d') ,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(18.0),
                    topRight: Radius.circular(18.0),
                  ),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 10.0,
                      color: theme.brightness == Brightness.dark
                          ? Colors.black54
                          : Colors.black26,
                    ),
                  ],
                ),
                child: ListView.separated(
                  separatorBuilder: (context, index) =>SizedBox(height: 2.0,),
                      // Divider(height: 1,color: theme.dividerColor,),
                  controller: scrollController,
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    final text = items[index]['text'];
                    final TextStyle style = index == 0
                        ? TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: PrimaryTextColor,
                          )
                        : TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 16,
                          color: secondaryTextColor,
                          );
                    return Card(child: ListTile(title: Text(text, style: style)));
                  },
                ),
              );
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.deepPurple[100]),
              child: Container(child: Text('Menu')),
              //   CircleAvatar(
              //     radius: 50,
              //     backgroundImage: AssetImage('assets/me.jpg'),
              //   ),
              // ),
            ),
            ListTile(
              leading: Icon(
                Icons.home_filled,
                color: widget.isDark ? Colors.deepPurple[50] : HexColor('#1b1a1d'),
              ),
              title: Text(
                'Home',
                style: TextStyle(
                  color: widget.isDark ? Colors.deepPurple[50] : HexColor('#1b1a1d'),
                ),
              ),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(
                Icons.settings,
                color:widget.isDark ? Colors.deepPurple[50] : HexColor('#1b1a1d'),
              ),
              title: Text(
                'Settings',
                style: TextStyle(
                  color:widget.isDark ? Colors.deepPurple[50] : HexColor('#1b1a1d'),
                ),
              ),
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
