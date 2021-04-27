class Post{
  int userId;
      int id;
  String title;
  String body;
  Post({this.body,this.title,this.id,this.userId});
factory Post.fromJson(Map<String,dynamic>comingJson){
  return Post(
    id: comingJson['id'],
    userId: comingJson['userId'],
    title: comingJson['title'],
    body: comingJson['body'],
  );
}
}