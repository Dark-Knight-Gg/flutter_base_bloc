import 'package:flutter_base_bloc/core/page/base_page.dart';

import '../bloc/base_list_bloc.dart';

class BaseListStatelessWidget<V, C extends BaseListCubit<V>>
    extends BaseStatelessWidget<V, C> with BaseListPageMixin<V, C> {
  BaseListStatelessWidget({super.key});
}

abstract class BaseListStatefulWidget extends BaseStatefulWidget {
  const BaseListStatefulWidget({super.key});
}

class BaseListStatefulWidgetState<V, C extends BaseListCubit<V>>
    extends BaseStatefulWidgetState<V, C> with BaseListPageMixin<V, C> {}
