import 'package:flutter/material.dart';

class TagsModel {
  final String tag;
  final String image;
  final Color color;
  TagsModel({
    required this.tag,
    required this.image,
    required this.color,
  });
  factory TagsModel.fromJson(Map<String, dynamic> json) => TagsModel(
        tag: json["tag"],
        image: json["coverImage"],
        color: Color(json['color']),
      );
}

final tags = [
  {
    "tag": "jazz",
    "coverImage":
        "https://images.unsplash.com/photo-1533038590840-1cde6e668a91?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwyNjQwNTF8MHwxfHNlYXJjaHw2N3x8bmF0dXJlfGVufDB8fHx8MTYzNDM4MDExMw&ixlib=rb-1.2.1&q=80&w=1080",
    "color": 3421515654
  },
  {
    "tag": "ambient",
    "coverImage":
        "https://images.unsplash.com/photo-1482192505345-5655af888cc4?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwyNjQwNTF8MHwxfHNlYXJjaHw2NXx8bmF0dXJlfGVufDB8fHx8MTYzNDM4MDExMw&ixlib=rb-1.2.1&q=80&w=1080",
    "color": 2873076295
  },
  {
    "tag": "meditative",
    "coverImage":
        "https://images.unsplash.com/photo-1549605751-158aa5912530?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwyNjQwNTF8MHwxfHNlYXJjaHwzM3x8Y29uY2VydHxlbnwwfHx8fDE2MzI5MTA0OTM&ixlib=rb-1.2.1&q=80&w=1080",
    "color": 2986204758
  },
  {
    "tag": "cinematic",
    "coverImage":
        "https://images.unsplash.com/photo-1481207727306-1a9f151fca7d?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwyNjQwNTF8MHwxfHNlYXJjaHw3MXx8YXVkaW98ZW58MHx8fHwxNjM0MzgwMTcz&ixlib=rb-1.2.1&q=80&w=1080",
    "color": 699745508
  },
  {
    "tag": "film",
    "coverImage":
        "https://images.unsplash.com/photo-1508528000085-57406ae6b7bd?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwyNjQwNTF8MHwxfHNlYXJjaHw3Mnx8c2FkfGVufDB8fHx8MTYzMjkxMDY5NQ&ixlib=rb-1.2.1&q=80&w=1080",
    "color": 2803116750
  },
  {
    "tag": "sad",
    "coverImage":
        "https://images.unsplash.com/photo-1546707012-c46675f12716?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwyNjQwNTF8MHwxfHNlYXJjaHwyNHx8Y29uY2VydHxlbnwwfHx8fDE2MzI5MTA0OTM&ixlib=rb-1.2.1&q=80&w=1080",
    "color": 1011540664
  },
  {
    "tag": "lonely",
    "coverImage":
        "https://images.unsplash.com/photo-1525469718471-0e5888a562e8?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwyNjQwNTF8MHwxfHNlYXJjaHw3NXx8c2FkfGVufDB8fHx8MTYzMjkxMDY5NQ&ixlib=rb-1.2.1&q=80&w=1080",
    "color": 2625387372
  },
  {
    "tag": "relaxing",
    "coverImage":
        "https://images.unsplash.com/photo-1565275373459-e543ba207e21?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwyNjQwNTF8MHwxfHNlYXJjaHw3NHx8bWluZGZ1bGxuZXNzfGVufDB8fHx8MTYzNDM4MDAzNw&ixlib=rb-1.2.1&q=80&w=1080",
    "color": 2384436955
  },
  {
    "tag": "peaceful",
    "coverImage":
        "https://images.unsplash.com/photo-1519677584237-752f8853252e?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwyNjQwNTF8MHwxfHNlYXJjaHw3OXx8YXVkaW98ZW58MHx8fHwxNjM0MzgwMTcz&ixlib=rb-1.2.1&q=80&w=1080",
    "color": 971811060
  },
  {
    "tag": "positive",
    "coverImage":
        "https://images.unsplash.com/photo-1594465919760-441fe5908ab0?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwyNjQwNTF8MHwxfHNlYXJjaHw2OXx8ZmFjZXxlbnwwfHx8fDE2MzQzODAyNDI&ixlib=rb-1.2.1&q=80&w=1080",
    "color": 2247820665
  },
  {
    "tag": "calm",
    "coverImage":
        "https://images.unsplash.com/photo-1620504155085-d7b152a58e77?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwyNjQwNTF8MHwxfHNlYXJjaHw2OHx8c2FkfGVufDB8fHx8MTYzMjkxMDY5NQ&ixlib=rb-1.2.1&q=80&w=1080",
    "color": 3666180583
  },
  {
    "tag": "romantic",
    "coverImage":
        "https://images.unsplash.com/photo-1625323198439-06db4cca391b?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwyNjQwNTF8MHwxfHNlYXJjaHw2OHx8bWluZGZ1bGxuZXNzfGVufDB8fHx8MTYzNDM4MDAzNw&ixlib=rb-1.2.1&q=80&w=1080",
    "color": 3704856191
  },
  {
    "tag": "chill",
    "coverImage":
        "https://images.unsplash.com/photo-1553531384-397c80973a0b?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwyNjQwNTF8MHwxfHNlYXJjaHw3Mnx8bmF0dXJlfGVufDB8fHx8MTYzNDM4MDExMw&ixlib=rb-1.2.1&q=80&w=1080",
    "color": 968268597
  },
  {
    "tag": "lo-fi",
    "coverImage":
        "https://images.unsplash.com/photo-1594465919760-441fe5908ab0?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwyNjQwNTF8MHwxfHNlYXJjaHw2OXx8ZmFjZXxlbnwwfHx8fDE2MzQzODAyNDI&ixlib=rb-1.2.1&q=80&w=1080",
    "color": 3764410612
  },
  {
    "tag": "remix",
    "coverImage":
        "https://images.unsplash.com/photo-1578596247451-9c73d1b23187?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwyNjQwNTF8MHwxfHNlYXJjaHw2MHx8Y29uY2VydHxlbnwwfHx8fDE2MzI5MTA1ODI&ixlib=rb-1.2.1&q=80&w=1080",
    "color": 3760760672
  },
  {
    "tag": "nostalgia",
    "coverImage":
        "https://images.unsplash.com/photo-1578596247451-9c73d1b23187?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwyNjQwNTF8MHwxfHNlYXJjaHw2MHx8Y29uY2VydHxlbnwwfHx8fDE2MzI5MTA1ODI&ixlib=rb-1.2.1&q=80&w=1080",
    "color": 3197838544
  },
  {
    "tag": "lofi",
    "coverImage":
        "https://images.unsplash.com/photo-1509824227185-9c5a01ceba0d?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwyNjQwNTF8MHwxfHNlYXJjaHwyfHxjb25jZXJ0fGVufDB8fHx8MTYzMjkxMDM4Nw&ixlib=rb-1.2.1&q=80&w=1080",
    "color": 1144405542
  },
  {
    "tag": "sad song",
    "coverImage":
        "https://images.unsplash.com/photo-1618488238312-876fd0a2b1a1?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwyNjQwNTF8MHwxfHNlYXJjaHw3M3x8YXVkaW98ZW58MHx8fHwxNjM0MzgwMTcz&ixlib=rb-1.2.1&q=80&w=1080",
    "color": 4193537910
  },
  {
    "tag": "sadboy",
    "coverImage":
        "https://images.unsplash.com/photo-1571935441005-07ac18f4bf23?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwyNjQwNTF8MHwxfHNlYXJjaHw2Mnx8bWluZGZ1bGxuZXNzfGVufDB8fHx8MTYzNDM4MDAzNw&ixlib=rb-1.2.1&q=80&w=1080",
    "color": 2247820665
  },
  {
    "tag": "nostalgic",
    "coverImage":
        "https://images.unsplash.com/photo-1550184658-ff6132a71714?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwyNjQwNTF8MHwxfHNlYXJjaHwyOHx8Y29uY2VydHxlbnwwfHx8fDE2MzI5MTA0OTM&ixlib=rb-1.2.1&q=80&w=1080",
    "color": 297990555
  },
  {
    "tag": "no sleep",
    "coverImage":
        "https://images.unsplash.com/photo-1617440168937-c6497eaa8db5?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwyNjQwNTF8MHwxfHNlYXJjaHw2Mnx8c2FkfGVufDB8fHx8MTYzMjkxMDY5NQ&ixlib=rb-1.2.1&q=80&w=1080",
    "color": 1881576557
  },
  {
    "tag": "abstract",
    "coverImage":
        "https://images.unsplash.com/photo-1506744038136-46273834b3fb?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwyNjQwNTF8MHwxfHNlYXJjaHw3NHx8bmF0dXJlfGVufDB8fHx8MTYzNDM4MDExMw&ixlib=rb-1.2.1&q=80&w=1080",
    "color": 598025116
  },
  {
    "tag": "advertising",
    "coverImage":
        "https://images.unsplash.com/photo-1629304459422-77b4947c7f09?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwyNjQwNTF8MHwxfHNlYXJjaHw3NXx8bWluZGZ1bGxuZXNzfGVufDB8fHx8MTYzNDM4MDAzNw&ixlib=rb-1.2.1&q=80&w=1080",
    "color": 3121218277
  },
  {
    "tag": "atmospheric",
    "coverImage":
        "https://images.unsplash.com/photo-1580436541340-36b8d0c60bae?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwyNjQwNTF8MHwxfHNlYXJjaHw3M3x8bmF0dXJlfGVufDB8fHx8MTYzNDM4MDExMw&ixlib=rb-1.2.1&q=80&w=1080",
    "color": 3529251680
  },
  {
    "tag": "background",
    "coverImage":
        "https://images.unsplash.com/photo-1573055418049-c8e0b7e3403b?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwyNjQwNTF8MHwxfHNlYXJjaHw0NHx8Y29uY2VydHxlbnwwfHx8fDE2MzI5MTA1ODI&ixlib=rb-1.2.1&q=80&w=1080",
    "color": 3649275586
  },
  {
    "tag": "dreamy",
    "coverImage":
        "https://images.unsplash.com/photo-1523766775147-152d0d6e2adb?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwyNjQwNTF8MHwxfHNlYXJjaHw3NXx8bmF0dXJlfGVufDB8fHx8MTYzNDM4MDExMw&ixlib=rb-1.2.1&q=80&w=1080",
    "color": 2355587595
  },
  {
    "tag": "easy",
    "coverImage":
        "https://images.unsplash.com/photo-1547148915-7527397648e4?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwyNjQwNTF8MHwxfHNlYXJjaHw3OXx8bmF0dXJlfGVufDB8fHx8MTYzMjkxMDYzOQ&ixlib=rb-1.2.1&q=80&w=1080",
    "color": 4018278441
  },
  {
    "tag": "easy-listening",
    "coverImage":
        "https://images.unsplash.com/photo-1547495827-fff7a5e8b26c?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwyNjQwNTF8MHwxfHNlYXJjaHw1Nnx8Y29uY2VydHxlbnwwfHx8fDE2MzI5MTA1ODI&ixlib=rb-1.2.1&q=80&w=1080",
    "color": 2724444428
  },
  {
    "tag": "electronic",
    "coverImage":
        "https://images.unsplash.com/photo-1525018923-1ebe8261a6a6?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwyNjQwNTF8MHwxfHNlYXJjaHw0MXx8Y29uY2VydHxlbnwwfHx8fDE2MzI5MTA1ODI&ixlib=rb-1.2.1&q=80&w=1080",
    "color": 3297592444
  },
  {
    "tag": "elegant",
    "coverImage":
        "https://images.unsplash.com/photo-1494368308039-ed3393a402a4?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwyNjQwNTF8MHwxfHNlYXJjaHw2M3x8c2FkfGVufDB8fHx8MTYzMjkxMDY5NQ&ixlib=rb-1.2.1&q=80&w=1080",
    "color": 1402799338
  },
  {
    "tag": "floating",
    "coverImage":
        "https://images.unsplash.com/photo-1621006276150-27039404abde?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwyNjQwNTF8MHwxfHNlYXJjaHw0Mnx8Y29uY2VydHxlbnwwfHx8fDE2MzI5MTA1ODI&ixlib=rb-1.2.1&q=80&w=1080",
    "color": 1502846079
  },
  {
    "tag": "groove",
    "coverImage":
        "https://images.unsplash.com/photo-1420593248178-d88870618ca0?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwyNjQwNTF8MHwxfHNlYXJjaHw3N3x8bmF0dXJlfGVufDB8fHx8MTYzNDM4MDExMw&ixlib=rb-1.2.1&q=80&w=1080",
    "color": 2689787282
  },
  {
    "tag": "hopeful",
    "coverImage":
        "https://images.unsplash.com/photo-1627808833324-a303d2877eca?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwyNjQwNTF8MHwxfHNlYXJjaHw3Mnx8bWluZGZ1bGxuZXNzfGVufDB8fHx8MTYzNDM4MDAzNw&ixlib=rb-1.2.1&q=80&w=1080",
    "color": 2395202864
  },
  {
    "tag": "beautiful",
    "coverImage":
        "https://images.unsplash.com/photo-1579503841516-e0bd7fca5faa?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwyNjQwNTF8MHwxfHNlYXJjaHw3N3x8ZmFjZXxlbnwwfHx8fDE2MzQzODAyNDI&ixlib=rb-1.2.1&q=80&w=1080",
    "color": 3649275586
  }
];
