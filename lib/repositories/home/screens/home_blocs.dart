import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:mass_app/repositories/articles/bloc/articles_bloc.dart';
import 'package:mass_app/repositories/articles/service/article_service.dart';
import 'package:mass_app/repositories/articles/service/articles_repo.dart';
import 'package:mass_app/repositories/auth/auth_service/auth_repo.dart';
import 'package:mass_app/repositories/auth/auth_service/auth_service.dart';

import 'package:mass_app/repositories/auth/blocs%20&%20cubits/cubit/auth_cubits_cubit.dart';
import 'package:mass_app/repositories/events/bloc/event_bloc.dart';
import 'package:mass_app/repositories/events/service/event_repo.dart';
import 'package:mass_app/repositories/events/service/event_service.dart';
import 'package:mass_app/repositories/tv/videos%20utils/all_video/all_vids_barrel.dart';
import 'package:mass_app/repositories/tv/videos%20utils/live_video/live_video_barrel.dart';
import 'package:mass_app/repositories/tv/videos_repo/video_repo.dart';
import 'package:mass_app/repositories/tv/videos_repo/video_service.dart';

class HomeBlocs extends StatelessWidget {
  const HomeBlocs({Key? key, required this.body, required this.userId})
      : super(key: key);

  final Widget body;
  final String userId;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => VideosRepository(videoService: VideoService()),
        ),
        RepositoryProvider(
          create: (context) => AuthUserRepo(authService: AuthService()),
        ),
        RepositoryProvider(
          create: (context) => ArticleRepos(artService: ArticleService()),
        ),
        RepositoryProvider(
          create: (context) => MassEventRepository(service: EventService()),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AuthLoginCubit(
              authUserRepo: context.read<AuthUserRepo>(),
            )..getUser(userId),
          ),
          BlocProvider(
            create: (context) => AllVideosBloc(
              vidRepo: context.read<VideosRepository>(),
            )..add(GetVideos()),
          ),
          BlocProvider(
            create: (context) => ArticlesBloc(
              articleRepos: context.read<ArticleRepos>(),
            )..add(GetArticles()),
          ),
          BlocProvider(
            create: (context) =>
                LiveVideoBloc(vidRep: context.read<VideosRepository>())
                  ..add(GetLive()),
          ),
          BlocProvider(
            create: (context) =>
                EventBloc(eventRepo: context.read<MassEventRepository>())
                  ..add(GetUpcomingEvent()),
          ),
        ],
        child: body,
      ),
    );
  }
}
