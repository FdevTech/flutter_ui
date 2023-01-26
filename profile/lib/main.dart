import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:profile/bloc/theme_bloc/theme_cubit.dart';
import 'package:profile/theme.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'bloc/language_bloc/language_cubit.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ThemeCubit>(create: (context) => ThemeCubit()),
        BlocProvider<LanguageCubit>(create: (context) => LanguageCubit()),
      ],
  child: BlocBuilder<ThemeCubit, ThemeState>(
  builder: (context, state) {
    final myTheme = state as MyThemeState;
    return BlocBuilder<LanguageCubit, LanguageState>(
  builder: (context, state) {
    final myState = state as MyLocalState;
    return MaterialApp(
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: myTheme.dark?ThemeMode.dark:ThemeMode.light,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate
      ],
      supportedLocales: MySupportedLanguage.languages,
      locale: myState.currentLocal,
      home: const MyHome(),
    );
  },
);
  },
),
);
  }
}

class MyHome extends StatefulWidget {
  const MyHome({Key? key}) : super(key: key);

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> with TickerProviderStateMixin{
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _mainScreenTranslation;
  late Animation<double> _menuTranslation;
  var isCollapsed =false;
  
  @override
  void initState() {
    _animationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 500));
    _scaleAnimation = Tween(begin: 1.0, end: 0.8).animate(_animationController);
    _mainScreenTranslation = Tween(begin: 0.0, end: 200.0).animate(_animationController);
    _menuTranslation = Tween(begin: -200.0,end: 0.0).animate(_animationController);
    super.initState();
  }
  
  @override
  void dispose() {
    
    _animationController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [

          AnimatedBuilder(
            animation: _animationController,
            builder: (context,child){
              return Transform.translate(
                  offset: Offset(_menuTranslation.value, 0),
                  child: child,
              );
            },
            child: const MyMenu(),
          ),
          AnimatedBuilder(
            animation: _animationController,
            builder: (context,child){
              return  Transform.translate(
              offset: Offset(_mainScreenTranslation.value, 0.0),
              child: Transform.scale(
              scale: _scaleAnimation.value,
              child: child,
              ));
            },
            child:const MainScreen()),


          Positioned(
              top: 0,
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 50,
                child: AppBar(
                  leading: IconButton(
                    icon: Icon(Icons.menu,color: Theme.of(context).iconTheme.color,),
                    onPressed: (){
                      isCollapsed = !isCollapsed;
                      if(_animationController.isDismissed)
                        {
                          _animationController.forward();
                        }
                      else if(_animationController.isCompleted)
                        {
                          _animationController.reverse();
                        }
                    },
                  ),
                ),
              )),
        ],
      ),
    );
  }
}

class MyMenu extends StatelessWidget {
  const MyMenu({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width/2,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: DrawerHeader(
                padding: EdgeInsets.zero,
                    child: SvgPicture.asset('assets/svgs/openai.svg',
                      height: 200
                      ,color: Theme.of(context).iconTheme.color,),


            ),
          ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50.0),
              child: Text(
                "Open AI",
                 style: Theme.of(context).textTheme.headline3,
              ),
            ),
            ExpansionTile(

               title: Text(AppLocalizations.of(context)!.language),
                children:  [
                  InkWell(
                    onTap: (){
                      BlocProvider.of<LanguageCubit>(context).changeTheLanguage(MySupportedLanguage.english);
                    },
                    child: const ListTile(
                      title: Text("English"),
                    ),
                  ),
                   InkWell(
                     onTap: (){
                       BlocProvider.of<LanguageCubit>(context).changeTheLanguage(MySupportedLanguage.french);
                     },
                     child: const ListTile(
                      title: Text("French"),
                  ),
                   )
                ],
           ),
           SizedBox(

             child: ListTile(
               leading:  Text(AppLocalizations.of(context)!.dark),
               minLeadingWidth: 100,
               title: BlocBuilder<ThemeCubit, ThemeState>(
              builder: (context, state) {
                final myState = state as MyThemeState;
                  return Switch(value: myState.dark,
                   onChanged: (value){
                      BlocProvider.of<ThemeCubit>(context).setMyTheme(value);
                   },
             );
  },
)),
           )

        ],
      ),
    );
  }
}

class MainScreen extends StatelessWidget {
  const MainScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.only(topLeft: Radius.circular(20.0)),
                    child: Positioned(
                        top: 0,
                        left: 0,
                        right: 0,
                        child: Image.asset("assets/images/tesla.jpeg")),
                  ),
                  Positioned(
                      bottom: MediaQuery.of(context).size.height*(1/2/100),
                      left: MediaQuery.of(context).size.width/5 ,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children:  [
                            const CircleAvatar(
                              radius: 50,
                              backgroundImage: AssetImage("assets/images/elon_musk.jpg"),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text("Elon Musk",style: Theme.of(context).textTheme.headline4,),
                            const SizedBox(
                              height: 10,
                            ),
                             Text(AppLocalizations.of(context)!.me),
                            const SizedBox(
                              height: 10,
                            ),
                            InkWell(
                              onTap: (){},
                              child: Container(
                                width: 100,
                                color: Colors.blueAccent.shade200,
                                child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children:   [
                                      const Icon(FontAwesomeIcons.twitter,color:Colors.white),
                                      const SizedBox(width: 5,),
                                      Text("twitter",style: Theme.of(context).textTheme.bodyText1!.copyWith(color: Colors.white),)
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ]
                      ))
                ],
              )),
          Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(AppLocalizations.of(context)!.about_me,style: Theme.of(context).textTheme.headline3,),
                    const SizedBox(height: 10,),
                    Text(AppLocalizations.of(context)!.bio,
                      style: Theme.of(context).textTheme.bodyText1,
                    )
                  ],
                ),
              ))
        ],
      ),
    );
  }
}

