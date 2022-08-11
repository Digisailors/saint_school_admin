import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:school_app/constants/constant.dart';
import 'package:school_app/models/post.dart';
import 'package:school_app/screens/Form/post_form.dart';
import 'package:school_app/screens/list/source/postsource.dart';

class PostList extends StatefulWidget {
  const PostList({Key? key}) : super(key: key);

  @override
  State<PostList> createState() => _PostListState();
}

class _PostListState extends State<PostList> {
  int pageNumber = 0;

  Query<Map<String, dynamic>> get posts => firestore.collectionGroup('posts');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: posts.orderBy('date', descending: true).snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.active && snapshot.hasData) {
            List<Post> list = snapshot.data!.docs.map((e) => Post.fromJson(e.data(), e.id)).toList();
            var source = PostSource(list, context);
            return Table(
              children: [
                TableRow(
                  children: [
                    PaginatedDataTable(
                      dataRowHeight: kMinInteractiveDimension * 1.5,
                      header: const Text("Announcements"),
                      actions: [
                        ElevatedButton(
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return const Dialog(
                                      child: PostForm(),
                                    );
                                  });
                            },
                            child: const Text("Add"))
                      ],
                      columns: PostSource.getCoumns(),
                      source: source,
                    ),
                  ],
                ),
              ],
            );
          }
          if (snapshot.hasError) {
            return Center(child: SelectableText(snapshot.error.toString()));
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}

class PostTile extends StatelessWidget {
  const PostTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
