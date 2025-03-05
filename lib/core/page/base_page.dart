import 'package:flutter/material.dart';
import 'package:flutter_base_bloc/core/mixin/page_mixin.dart';

import '../bloc/base_bloc.dart';

export '../bloc/state_wrapper.dart';

abstract class BaseStatelessWidget<V, C extends BaseCubit<V>>
    extends StatelessWidget with PageMixin<V, C> {
  const BaseStatelessWidget({super.key});

  @override
  Widget build(BuildContext context) => buildRoot();
}

abstract class BaseStatefulWidget extends StatefulWidget {
  const BaseStatefulWidget({super.key});
}

abstract class BaseStatefulWidgetState<V, C extends BaseCubit<V>>
    extends State<BaseStatefulWidget> with PageMixin<V, C> {
  @override
  Widget build(BuildContext context) => buildRoot();
}
