import 'package:equatable/equatable.dart';

abstract class HomeEvent extends Equatable{}

class FetchData extends HomeEvent{}
class RefreshData extends HomeEvent{}
