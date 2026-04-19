import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';

abstract class LocaleState extends Equatable {
  final Locale locale;
  const LocaleState(this.locale);

  @override
  List<Object> get props => [locale];
}

class LocaleInitial extends LocaleState {
  const LocaleInitial(super.locale);
}

class LocaleChanged extends LocaleState {
  const LocaleChanged(super.locale);
}
