import 'package:flutter/material.dart';
import 'package:social_media_freelance/models/comment_model.dart';
import 'package:social_media_freelance/models/profile_model.dart';
import 'package:social_media_freelance/models/story_model.dart';

class PostDummyData {
  PostDummyData._();

  static Image profileImage = Image.network(
      "https://www.all.com.tr/wp-content/uploads/2022/01/RanaTurkyilmaz_2-scaled.jpg");
  static DateTime dateTime =
      DateTime.now().subtract(Duration(hours: 4, minutes: 29));
  static String username = "ツ ~_RanaY_~";
  static String postTitle = "Herkese selam arkadaşlar";
  static int initialCommentCount = 44483;
  static int initialLikeCount = 278;
  static int initialPresentCount = 26375;

  static List<Image> images = [
    Image.network(
        "https://media.macphun.com/img/uploads/customer/how-to/593/15353560665b83aca2a112e0.05630799.jpg?q=85&w=1340"),
    Image.network(
        "https://image.winudf.com/v2/image1/Y29tLnRodW5rYWJsZS5hbmRyb2lkLmNhaW9fY2FybG9zcm95YWxlMS5zcXFxX3NjcmVlbl8wXzE1NjcxNjU1ODhfMDUy/screen-0.jpg?fakeurl=1&type=.webp"),
    Image.network(
        "https://i0.wp.com/luamaralstudio.com/wp-content/uploads/2019/10/efb6dacb9721eab6b593421298899a08.jpg?resize=563%2C803"),
    Image.network(
        "https://64.media.tumblr.com/669f8a6ef1744b9a6968453bec5ab454/d9d5bff60aeabf81-d9/s1280x1920/ddac5e33cb75ca27847e9d20e2435b3775b7afe3.png"),
    Image.network(
        "https://archermagazine.com.au/wp-content/uploads/2018/10/john-baker-349282-unsplash-1024x640.jpg"),
    Image.network(
        "https://www.dicasdemulher.com.br/wp-content/uploads/2019/11/legendas-para-fotos-tumblr-1.jpg"),
    Image.network(
        "https://tr.web.img4.acsta.net/pictures/14/01/22/10/53/352587.jpg"),
    Image.network(
        "https://rockistasyonu.com/wp-content/uploads/2022/01/nnnnn.jpg"),
    Image.network(
        "https://64.media.tumblr.com/38afe4cbce89ea60396b01c8b9a8ae40/58f3acc7885daa6e-bd/s540x810/2e93e7ad30106ebb6bd084477fdefc9d532a3d40.jpg")
  ];
}

class TagBarDummyData {
  TagBarDummyData._();

  static const List<String> tags = [
    "Yeniler",
    "Popüler",
    "#müzik",
    "#tarih",
    "#sanat",
  ];
}

class StoryDummyData {
  StoryDummyData._();

  static final List<Story> stories = [
    Story(
        isSeen: false,
        isOwned: true,
        image: Image.network(
            "https://www.all.com.tr/wp-content/uploads/2022/01/RanaTurkyilmaz_2-scaled.jpg"),
        username: "Rana"),
    ...List.generate(
        3,
        (index) => Story(
            isSeen: false,
            isOwned: false,
            image: Image.network(
                "https://images.bursadabugun.com/editor/haber/01122022/3-2219-638835235b2d7.jpg"),
            username: "Farah")).toList(),
    ...List.generate(
        5,
        (index) => Story(
            isSeen: true,
            isOwned: false,
            image: Image.network(
                "https://i3.posta.com.tr/i/posta/75/0x410/6171c65245d2a0b2540ab4dd.jpg"),
            username: "Fatma")).toList()
  ];
}

class ProfileDummyData {
  ProfileDummyData._();

  static final Image profileImage = Image.network(
      "https://www.all.com.tr/wp-content/uploads/2022/01/RanaTurkyilmaz_2-scaled.jpg");
  static final String name = "Rana",
      description = "Yeni bir şeyler denemekten hoşlanıyorum",
      location = "İstanbul";
  static final Gender gender = Gender.famale;

  static final int followerCount = 100,
      followingCount = 124,
      visitorCount = 118;

  static const List<String> _storyImages = [
    "https://guitar.com/wp-content/uploads/2016/03/les-paul-tips@1400x1050.jpg",
    "https://img.freepik.com/free-photo/beautiful-scenery-phragmites-plants-by-sea-with-swimming-pelican-sunset_181624-37787.jpg?w=2000",
    "https://thumbs.dreamstime.com/b/picturesque-autumn-scenery-santa-maddalena-village-church-road-colorful-trees-meadows-foreground-mountain-peaks-159426189.jpg",
    "https://wallpaperaccess.com/full/1376490.jpg",
    "https://images.unsplash.com/photo-1597655601841-214a4cfe8b2c?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8bW91bnRhaW4lMjBzY2VuZXJ5fGVufDB8fDB8fA%3D%3D&w=1000&q=80",
    "https://i.pinimg.com/originals/cc/18/8c/cc188c604e58cffd36e1d183c7198d21.jpg",
    "https://media.istockphoto.com/id/1297349747/photo/hot-air-balloons-flying-over-the-botan-canyon-in-turkey.jpg?s=612x612&w=0&k=20&c=kt8-RRzCDunpxgKFMBBjZ6jSteetNhhSxHZFvHQ0hNU="
  ];

  static const List<String> _storyTitles = [
    "Müzik",
    "Deniz",
    "Güz",
    "Taşra",
    "Doğa",
    "Kapadokya",
    "Botan Kanyonu"
  ];

  static final List<Story> stories = List.generate(
      _storyImages.length,
      (index) => Story(
          isSeen: false,
          isOwned: false,
          image: Image.network(_storyImages[index]),
          username: _storyTitles[index]));

  static final List<Image> posts = [
    Image.network(
        "https://media.macphun.com/img/uploads/customer/how-to/593/15353560665b83aca2a112e0.05630799.jpg?q=85&w=1340"),
    Image.network(
        "https://image.winudf.com/v2/image1/Y29tLnRodW5rYWJsZS5hbmRyb2lkLmNhaW9fY2FybG9zcm95YWxlMS5zcXFxX3NjcmVlbl8wXzE1NjcxNjU1ODhfMDUy/screen-0.jpg?fakeurl=1&type=.webp"),
    Image.network(
        "https://i0.wp.com/luamaralstudio.com/wp-content/uploads/2019/10/efb6dacb9721eab6b593421298899a08.jpg?resize=563%2C803"),
    Image.network(
        "https://64.media.tumblr.com/669f8a6ef1744b9a6968453bec5ab454/d9d5bff60aeabf81-d9/s1280x1920/ddac5e33cb75ca27847e9d20e2435b3775b7afe3.png"),
    Image.network(
        "https://archermagazine.com.au/wp-content/uploads/2018/10/john-baker-349282-unsplash-1024x640.jpg"),
    Image.network(
        "https://www.dicasdemulher.com.br/wp-content/uploads/2019/11/legendas-para-fotos-tumblr-1.jpg"),
    Image.network(
        "https://tr.web.img4.acsta.net/pictures/14/01/22/10/53/352587.jpg"),
    Image.network(
        "https://rockistasyonu.com/wp-content/uploads/2022/01/nnnnn.jpg"),
    Image.network(
        "https://64.media.tumblr.com/38afe4cbce89ea60396b01c8b9a8ae40/58f3acc7885daa6e-bd/s540x810/2e93e7ad30106ebb6bd084477fdefc9d532a3d40.jpg")
  ];
}

class CommentDummyData {
  CommentDummyData._();

  static final Comment title = Comment(
    username: "ranatrkylmz",
    comment:
        "Nasıl etmeli de ağlayabilmeli farkına bile varmadan?  Nasıl etmeli de ağlayabilmeli ayıpsız, aşikare, yağmur misali?",
    likes: 6,
    isOwned: true,
    image: Image.network(
        "https://www.all.com.tr/wp-content/uploads/2022/01/RanaTurkyilmaz_2-scaled.jpg"),
  );

  static final List<Comment> comments = [
    Comment(
      username: "farahzeynep",
      comment: "Güzel bir fotoğraf",
      likes: 17,
      image: Image.network(
          "https://i.pinimg.com/originals/8e/80/93/8e8093b06b28938b609d238ff1052c29.jpg"),
    ),
    Comment(
      username: "frhFzeynep",
      comment: "AAAAA çok güzelllllllllllllllll",
      likes: 24,
      image: Image.network(
          "https://i1.wp.com/turkischefilme.de/wp-content/uploads/2017/03/farah-zeynep-abdullah.jpg?fit=1457%2C1850&ssl=1"),
    )
  ];
}
