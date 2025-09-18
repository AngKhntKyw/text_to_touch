// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:test_app/core/network/bloc/connectivity_bloc.dart';
// import 'package:test_app/core/route/router.dart';
// import 'package:test_app/core/theme/bloc/theme_bloc.dart';
// import 'package:test_app/core/theme/bloc/theme_event.dart';
// import 'package:test_app/core/theme/bloc/theme_state.dart';
// import 'package:test_app/core/theme/theme.dart';
// import 'package:test_app/core/common/widget/global_connectivity_checker_snackbar.dart';
// import 'package:test_app/features/auth/presentation/bloc/auth_bloc.dart';
// import 'package:test_app/features/pin_code_page.dart';
// import 'package:test_app/firebase_options.dart';
// import 'package:test_app/init_dependencies.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
//   await initDependencies();

//   runApp(
//     MultiBlocProvider(
//       providers: [
//         BlocProvider(create: (_) => serviceLocator<ConnectivityBloc>()),
//         BlocProvider(
//           create: (_) => serviceLocator<ThemeBloc>()..add(LoadTheme()),
//         ),
//         BlocProvider(create: (_) => serviceLocator<AuthBloc>()),
//       ],
//       child: const MyApp(),
//     ),
//   );
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<ThemeBloc, ThemeState>(
//       builder: (context, state) {
//         return MaterialApp(
//           title: "T & T",
//           debugShowCheckedModeBanner: false,
//           theme: AppTheme.lightTheme,
//           darkTheme: AppTheme.darkTheme,
//           themeAnimationCurve: Curves.bounceInOut,
//           themeAnimationStyle: AnimationStyle(
//             curve: Curves.bounceInOut,
//             duration: const Duration(seconds: 0),
//             reverseCurve: Curves.bounceInOut,
//             reverseDuration: const Duration(seconds: 0),
//           ),
//           themeAnimationDuration: const Duration(seconds: 0),
//           themeMode: context.read<ThemeBloc>().toFlutterThemeMode(
//             state.themeMode,
//           ),
//           navigatorKey: navigatorKey,
//           onGenerateRoute: (settings) => generateRoute(settings),
//           home: const GlobalConnectivitySnackbarHandler(child: PinCodePage()),
//           // routerConfig: router,
//         );
//       },
//     );
//   }
// }

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:test_app/firebase_options.dart';
import 'package:test_app/signaling.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Signaling signaling = Signaling();
  RTCVideoRenderer _localRenderer = RTCVideoRenderer();
  RTCVideoRenderer _remoteRenderer = RTCVideoRenderer();
  String? roomId;
  TextEditingController textEditingController = TextEditingController(text: '');

  @override
  void initState() {
    _localRenderer.initialize();
    _remoteRenderer.initialize();

    signaling.onAddRemoteStream = ((stream) {
      _remoteRenderer.srcObject = stream;
      setState(() {});
    });

    super.initState();
  }

  @override
  void dispose() {
    _localRenderer.dispose();
    _remoteRenderer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Welcome to Flutter Explained - WebRTC")),
      body: Column(
        children: [
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  signaling.openUserMedia(_localRenderer, _remoteRenderer);
                },
                child: Text("Open camera & microphone"),
              ),
              SizedBox(width: 8),
              ElevatedButton(
                onPressed: () async {
                  roomId = await signaling.createRoom(_remoteRenderer);
                  textEditingController.text = roomId!;
                  setState(() {});
                },
                child: Text("Create room"),
              ),
              SizedBox(width: 8),
              ElevatedButton(
                onPressed: () {
                  // Add roomId
                  signaling.joinRoom(
                    textEditingController.text.trim(),
                    _remoteRenderer,
                  );
                },
                child: Text("Join room"),
              ),
              SizedBox(width: 8),
              ElevatedButton(
                onPressed: () {
                  signaling.hangUp(_localRenderer);
                },
                child: Text("Hangup"),
              ),
            ],
          ),
          SizedBox(height: 8),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(child: RTCVideoView(_localRenderer, mirror: true)),
                  Expanded(child: RTCVideoView(_remoteRenderer)),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Join the following Room: "),
                Flexible(
                  child: TextFormField(controller: textEditingController),
                ),
              ],
            ),
          ),
          SizedBox(height: 8),
        ],
      ),
    );
  }
}
