// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subscription_state.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$SubscriptionState on _SubscriptionStateBase, Store {
  late final _$isSubscribedAtom =
      Atom(name: '_SubscriptionStateBase.isSubscribed', context: context);

  @override
  bool get isSubscribed {
    _$isSubscribedAtom.reportRead();
    return super.isSubscribed;
  }

  @override
  set isSubscribed(bool value) {
    _$isSubscribedAtom.reportWrite(value, super.isSubscribed, () {
      super.isSubscribed = value;
    });
  }

  @override
  String toString() {
    return '''
isSubscribed: ${isSubscribed}
    ''';
  }
}
