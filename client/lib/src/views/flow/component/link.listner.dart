import 'dart:async';
import 'package:client/src/blocs/session/logic.dart';
import 'package:client/src/modules/enums/default.dart';
import 'package:client/src/modules/models/flow_check_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:logistics/logistics.dart';

class RequestListener extends ConsumerStatefulWidget {
  final ValueEffectChanged<FlowResponse, void> onCompleted;
  final ValueEffectChanged<ActionState, void> onReceived;
  final ActionCallback<void> onError;
  final String flowID;
  const RequestListener({super.key,
    required this.onReceived,
    required this.onError,
    required this.onCompleted, required this.flowID});

  @override
  ConsumerState<RequestListener> createState() => _RequestListenerState();
}

class _RequestListenerState extends ConsumerState<RequestListener> {
  late StreamSubscription _changes;
  bool onsession = false;

  @override
  void initState() {
    _changes = ref.read(logicRepositoryProvider)
        .
    changes(widget.flowID)
        .listen((event) async {
      if(event.data.sessionPicked){
        setState(() {
          onsession = true;
        });
        await widget.onReceived(ActionState.session);
      }else if(event.data.cancelled){
        await widget.onReceived(ActionState.canceled);
      }else if(event.data.signature != null){
        await widget.onCompleted(event);
      }
    }, onError: (err) async {
      Logging.log.e("Request listening error: $err");
      await widget.onError();
    });
    super.initState();
  }

  @override
  void dispose() {
    _changes.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        SpinKitCircle(
          size: 28,
          color: context.theme.primaryColor.withAlpha(42),
        ),
        const LabGap(6),
        'Listening to changes'
            .textView(
            size: 11.4,
            weight: FontWeight.w400,
            color: context.theme.primaryColor.withAlpha(80)),
      ],
    );
  }
}
