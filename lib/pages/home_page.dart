import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:ngdemo13_bloc/bloc/home_bloc.dart';
import 'package:ngdemo13_bloc/bloc/home_event.dart';
import 'package:ngdemo13_bloc/bloc/home_state.dart';
import '../models/post_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late HomeBloc homeBloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    homeBloc = BlocProvider.of(context);
    homeBloc.add(LoadPostListEvent());

    homeBloc.stream.listen((state) {
      if (state is HomeDeletePostState) {
        homeBloc.add(LoadPostListEvent());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text("Bloc-Bloc"),
      ),
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state is HomeErrorState) {
            return viewOfError(state.errorMessage);
          }
          if (state is HomePostListState) {
            var posts = state.postList;
            return viewOfPostList(posts);
          }
          return viewOfLoading();
        },
      ),
      // Stack(
      //   children: [
      //     ListView.builder(
      //       itemCount: homeBloc.posts.length,
      //       itemBuilder: (ctx, index) {
      //         return _itemOfPost(homeBloc.posts[index]);
      //       },
      //     ),
      //     // isLoading
      //         // ? const Center(
      //         //     child: CircularProgressIndicator(),
      //         //   )
      //         // : SizedBox.shrink(),
      //   ],
      // ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: () {
          // homeBloc.callCreatePage(context);
        },
      ),
    );
  }
  Widget viewOfError(String err) {
    return Center(
      child: Text("Error occurred $err"),
    );
  }

  Widget viewOfLoading() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget viewOfPostList(List<Post> posts) {
    return Stack(
      children: [
        ListView.builder(
          itemCount: homeBloc.posts.length,
          itemBuilder: (ctx, index) {
            return itemOfPost(homeBloc.posts[index]);
          },
        ),
      ],
    );
  }

  Widget itemOfPost(Post post) {
    return Slidable(
        startActionPane: ActionPane(
          motion: const ScrollMotion(),
          children: [
            SlidableAction(
              onPressed: (BuildContext context) {
                homeBloc.callUpdatePage(context, post);
              },
              backgroundColor: Colors.orange,
              foregroundColor: Colors.white,
              icon: Icons.edit,
              label: 'Edit',
            ),
          ],
        ),
        endActionPane: ActionPane(
          motion: const ScrollMotion(),
          children: [
            SlidableAction(
              onPressed: (BuildContext context) {
                homeBloc.add(DeletePostEvent(post: post));
              },
              backgroundColor: Color(0xFFFE4A49),
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: 'Delete',
            ),
          ],
        ),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                post.title!,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Text(post.body!,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.normal)),
              const Divider(),
            ],
          ),
        ));
  }
}
