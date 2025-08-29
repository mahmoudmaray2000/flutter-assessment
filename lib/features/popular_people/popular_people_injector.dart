import 'package:flutter_assessment/core/storage/image_service/image_service_impl.dart';
import 'package:flutter_assessment/features/popular_people/data/data_source/data_source_impl.dart';
import 'package:flutter_assessment/features/popular_people/data/data_source/data_source_local_impl.dart';
import 'package:flutter_assessment/features/popular_people/data/repository/popular_repository_impl.dart';
import 'package:flutter_assessment/features/popular_people/domain/use_case/fetch_popular_details_use_cae.dart';
import 'package:flutter_assessment/features/popular_people/domain/use_case/fetch_popular_use_case.dart';
import 'package:flutter_assessment/features/popular_people/domain/use_case/local_popular_use_case.dart';
import 'package:flutter_assessment/features/popular_people/presentation/popular_people/popular_people_bloc.dart';
import 'package:flutter_assessment/features/popular_people/presentation/popular_people_details/popular_people_details_bloc.dart';
import 'package:flutter_assessment/injection.dart';

class PopularModuleFilter {
  static final Set<Type> _allowedTypes = {
    PopularDataSourceImpl,
    PopularRepositoryImpl,
    FetchPopularUseCase,
    FetchPopularDetailsUseCase,
    ImageSaverServiceImpl,
    DataSourceLocalImpl,
    LocalPopularUseCase,
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
  static late final ImageSaverServiceImpl _imageSaverService;
  static late final DataSourceLocalImpl _dataSourceLocalImpl;
  static late final LocalPopularUseCase _localPopularUseCase;

  static bool _initialized = false;

  static void init() {
    if (_initialized) return;

    _dataSource = PopularModuleFilter.inject(() {
      return PopularDataSourceImpl(networkHandler: Injector.networkHandler);
    });

    _dataSourceLocalImpl = PopularModuleFilter.inject(() {
      return DataSourceLocalImpl(dbService: Injector.dbService);
    });

    _repository = PopularModuleFilter.inject(() {
      return PopularRepositoryImpl(
        popularDataSourceImpl: _dataSource,
        dataSourceLocalImpl: _dataSourceLocalImpl,
      );
    });

    _fetchPopularUseCase = PopularModuleFilter.inject(() {
      return FetchPopularUseCase(popularRepository: _repository);
    });

    _fetchPopularDetailsUseCase = PopularModuleFilter.inject(() {
      return FetchPopularDetailsUseCase(popularRepository: _repository);
    });

    _imageSaverService = PopularModuleFilter.inject(() {
      return ImageSaverServiceImpl(Injector.dio);
    });
    _localPopularUseCase = PopularModuleFilter.inject(() {
      return LocalPopularUseCase(popularRepository: _repository);
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

  static DataSourceLocalImpl get dataSourceLocalImpl {
    _ensureInitialized();
    return _dataSourceLocalImpl;
  }

  static ImageSaverServiceImpl get imageSaverService {
    _ensureInitialized();
    return _imageSaverService;
  }

  static LocalPopularUseCase get localPopularUseCase {
    _ensureInitialized();
    return _localPopularUseCase;
  }

  static PopularPeopleBloc createPopularPeopleBloc() {
    return PopularPeopleBloc(
      fetchPopularUseCase,
      localPopularUseCase,
      Injector.connectionService,
    );
  }

  static PopularPeopleDetailsBloc createPopularPeopleDetailsBloc() {
    return PopularPeopleDetailsBloc(
      fetchPopularDetailsUseCase,
      imageSaverService,
    );
  }

  static void _ensureInitialized() {
    assert(
      _initialized,
      'PopularPeopleModule.init() must be called before accessing dependencies.',
    );
  }
}
