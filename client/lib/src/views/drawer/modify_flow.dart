import 'package:anydrawer/anydrawer.dart';
import 'package:client/src/blocs/session/state.dart';
import 'package:client/src/modules/extensions/build_ext.dart';
import 'package:client/src/views/landing/component/source_code.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logistics/logistics.dart';
import 'package:markdown_editable_textinput/format_markdown.dart';
import 'package:markdown_editable_textinput/markdown_text_input.dart';
import 'package:sizer/sizer.dart';

class ModifyFlowDrawerBase extends StatelessWidget {
  const ModifyFlowDrawerBase({super.key, required this.controller});

  final AnyDrawerController controller;

  @override
  Widget build(BuildContext context) {
    return _Body(controller);
  }
}

class _Body extends HookConsumerWidget {
  const _Body(this.controller);

  final AnyDrawerController controller;

  @override
  Widget build(BuildContext context, ref) {
    var session = ref.read(app);
    return Scaffold(
      backgroundColor: context.colorScheme.tertiary.darker(60),
      appBar: AppBar(
        backgroundColor: context.colorScheme.tertiary,
        toolbarHeight: 120,
        automaticallyImplyLeading: false,
        leading: RowLeadAndTrailPlacer(
          margin: padAll(pad: 10),
          leadIcon: Icons.exit_to_app,
          iconSize: getProportionateScreenHeight(28),
          text: 'Close',
          onPressed: () {
            controller.close();
          },
          hideTrailing: true,
          textStyle: appTextStyle(
            color: Colors.white,
            size: getProportionateScreenHeight(
              14.4,
            ),
          ),
        ),
        leadingWidth: 400,
      ),
      body: ListView(
        padding: padAsymmetric(
          vert: 2.8.h,
          horiz: 20,
        ),
        children: [
          _Content(
            controller: session.identificationPayload,
            header: context.localizedText!.drawer('identification'),
          ),
          LabGap(2.8.h),
          _Content(
            controller: session.signaturePayload,
            header: context.localizedText!.drawer('signature'),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        height: 100,
        color: context.colorScheme.tertiary,
        elevation: 4,
        child: Container(
          alignment: Alignment.center,
          child: ViewSourceCode(
            margin: padAll(pad: 10),
          ),
        ),
      ),
    );
  }
}

class _Content extends StatelessWidget {
  const _Content({super.key, required this.controller, required this.header});

  final TextEditingController controller;
  final String header;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      collapsedIconColor: Colors.white,
      title: header.textView(
        style: appTextStyle(
          size: getProportionateScreenHeight(16.2),
          color: Colors.white,
          variation: 680,
        ),
      ),
      children: [
        MarkdownTextInput(
          (String value) {},
          controller.text,
          maxLines: 10,
          actions: MarkdownType.values,
          controller: controller,
          textStyle: appTextStyle(
            size: getProportionateScreenHeight(14.4),
            color: Colors.black,
            variation: 520,
          ),
        ),
      ],
    );
  }
}
