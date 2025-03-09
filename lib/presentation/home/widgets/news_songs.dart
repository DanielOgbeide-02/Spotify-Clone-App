import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_app/core/configs/constants/app_urls.dart';
import 'package:spotify_app/domain/entities/song/song.dart';
import 'package:spotify_app/presentation/home/bloc/news_songs_cubit.dart';
import 'package:spotify_app/presentation/home/bloc/news_songs_state.dart';

class NewsSongs extends StatelessWidget {
  const NewsSongs({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        // calls the getNewsSongs() method immediately after creating the NewsSongsCubit instance.
        create: (_)=>NewsSongsCubit()..getNewsSongs(),
      child: SizedBox(
        height: 200,
        child: BlocBuilder<NewsSongsCubit, NewsSongsState>(
            builder: (context, state){
              if(state is NewsSongsLoading){
                return Container(
                  alignment: Alignment.center,
                    child: const CircularProgressIndicator()
                );
              }
              if(state is NewsSongsloaded){
                return _songs(state.songs);
              }

              return Container();
            },
        )
      ),
    );
  }

  Widget _songs(List<SongEntity> songs){
    return ListView.separated(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index){
          return SizedBox(
            width: 160,
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(
                          AppUrls.firestorage + songs[index].artist + ' - ' + songs[index].title + '.jpg?' + AppUrls.mediaAlt
                        )
                    )
                  ),
                )
              ],
            ),
          );
        },
        separatorBuilder: (context, index)=>SizedBox(width: 14,),
        itemCount: songs.length
    );
  }
}
