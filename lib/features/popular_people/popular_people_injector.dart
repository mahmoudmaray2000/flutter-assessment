import 'package:flutter_assessment/features/popular_people/data/data_source/data_source_impl.dart';
import 'package:flutter_assessment/features/popular_people/data/repository/popular_repository_impl.dart';
import 'package:flutter_assessment/features/popular_people/domain/use_case/fetch_popular_details_use_cae.dart';
import 'package:flutter_assessment/features/popular_people/domain/use_case/fetch_popular_use_case.dart';
import 'package:flutter_assessment/features/popular_people/presentation/popular_people/popular_people_bloc.dart';
import 'package:flutter_assessment/features/popular_people/presentation/popular_people_details/popular_people_details_bloc.dart';
import 'package:flutter_assessment/injection.dart';

class PopularModuleFilter {
  static final Set<Type> _allowedTypes = {
    PopularDataSourceImpl,
    PopularRepositoryImpl,
    FetchPopularUseCase,
    FetchPopularDetailsUseCase,
  };

  static bool canInject<T>() => _allowedTypes.contains(T);

  static T inject<T>(T Function() factory) {
    if (!canInject<T>()) {
      throw Exception('Type $T is not allowed in PopularPeople module');
    }
    return factory();
  }
}

class PopularPeopleModule {
  static late final PopularDataSourceImpl _dataSource;
  static late final PopularRepositoryImpl _repository;
  static late final FetchPopularUseCase _fetchPopularUseCase;
  static late final FetchPopularDetailsUseCase _fetchPopularDetailsUseCase;

  static bool _initialized = false;

  static void init() {
    if (_initialized) return;

    _dataSource = PopularModuleFilter.inject(() {
      return PopularDataSourceImpl(networkHandler: Injector.networkHandler);
    });

    _repository = PopularModuleFilter.inject(() {
      return PopularRepositoryImpl(popularDataSourceImpl: _dataSource);
    });

    _fetchPopularUseCase = PopularModuleFilter.inject(() {
      return FetchPopularUseCase(popularRepository: _repository);
    });

    _fetchPopularDetailsUseCase = PopularModuleFilter.inject(() {
      return FetchPopularDetailsUseCase(popularRepository: _repository);
    });

    _initialized = true;
  }

  static PopularDataSourceImpl get dataSource {
    _ensureInitialized();
    return _dataSource;
  }

  static PopularRepositoryImpl get repository {
    _ensureInitialized();
    return _repository;
  }

  static FetchPopularUseCase get fetchPopularUseCase {
    _ensureInitialized();
    return _fetchPopularUseCase;
  }

  static FetchPopularDetailsUseCase get fetchPopularDetailsUseCase {
    _ensureInitialized();
    return _fetchPopularDetailsUseCase;
  }

  static PopularPeopleBloc createPopularPeopleBloc() {
    return PopularPeopleBloc(fetchPopularUseCase);
  }

  static PopularPeopleDetailsBloc createPopularPeopleDetailsBloc() {
    return PopularPeopleDetailsBloc(fetchPopularDetailsUseCase);
  }

  static void _ensureInitialized() {
    assert(_initialized, 'PopularPeopleModule.init() must be called before accessing dependencies.');
  }
}

