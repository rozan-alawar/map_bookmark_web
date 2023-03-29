import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Expanded(flex: 2, child: _TopPortion()),
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  const SizedBox(height: 16),
                  Text(
                    "Richie Lorie",
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 30),
                  const _ProfileInfoRow()
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ProfileInfoRow extends StatelessWidget {
  const _ProfileInfoRow({Key? key}) : super(key: key);

  final List<ProfileInfoItem> _items = const [
    ProfileInfoItem("Email", 'rLorie@gmail.com'),
    ProfileInfoItem("Phone", '05955353752'),
    ProfileInfoItem("Country", 'Palestine ,Gaza'),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      constraints: const BoxConstraints(maxWidth: 700),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: _items
            .map((item) => Expanded(
                    child: Row(
                  children: [
                    if (_items.indexOf(item) != 0) const VerticalDivider(),
                    Expanded(child: _singleItem(context, item)),
                  ],
                )))
            .toList(),
      ),
    );
  }

  Widget _singleItem(BuildContext context, ProfileInfoItem item) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              item.title.toString(),
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
          Text(
            item.value,
            style: Theme.of(context).textTheme.bodySmall,
          )
        ],
      );
}

class ProfileInfoItem {
  final String title;
  final String value;
  const ProfileInfoItem(this.title, this.value);
}

class _TopPortion extends StatelessWidget {
  const _TopPortion({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 50),
          decoration: const BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.fitWidth,
                  image: NetworkImage(
                      'data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAkGBxMTEhUSEhIVFRUXFRUXFxUVFRUXFRcVFRUXFhUVFRUYHSggGBolHRUVITEhJSkrLi4uFx8zODMtNygtLisBCgoKBQUFDgUFDisZExkrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrK//AABEIAJ4BPwMBIgACEQEDEQH/xAAZAAEBAQEBAQAAAAAAAAAAAAACAQADBAf/xAAhEAEBAQEBAAICAwEBAAAAAAAAAQIREgMhMWFBUYFx8P/EABQBAQAAAAAAAAAAAAAAAAAAAAD/xAAUEQEAAAAAAAAAAAAAAAAAAAAA/9oADAMBAAIRAxEAPwD4pC4igixFApV6CwFpZgQ+ApZc+H2ASdXiyAuDmQycBZSqcOQFxCmf8XOfr/3+OkyDn540jpYkkAblPLpNJn9g4bcuvTuOGsgKVcrQcx2doaoJ1NN0aCWNxm6CRqlQF4ydaUC6lFfQDwoPtOgbN1gXiSMUBOItrdBliyNIDRfJSL0FzDzExCsBuHxIWYBzK4jYjpKC5VpFnAXqWfZSNYDnakp1JkHP5I5aejccNg5yDSkGgA6OhsBo0hoNQ0fR0AqkrAvGiVJQWsUSwB4UjWpKDLELoNKotAarluFQWZbEaLKBSLPwPTBcx0gYpygp5gHmg6QpHOUsUHWFnjnIQF3+msGxcglrS/wuhgJqOW8u9rnuA8+g07bn8B5BxqU9fhP4BLAuWvyJaAyjutmJoAX0yA3VjZLILKur9JmxOgMS0q3QaNxovAbjMlgHClHN+hmgdZotVywfQXixuNwCy6xzzk4ByFlz9Lmg7SHA6voGtLNDhyA6dHNTVafoHRztK9HgNB06zLaoPN5o/Ttpy0DjY56d9OWoDjf+Jx08p5BxtaQ7E1kHOxHTynkB4sXy0gNVTyecQBsc667c/ILFQsgPC8lcrkGv4CZLpzUAZOFF8p5ArpJVsQDzspXGOuQMp+hhwFhpgpkGjpctjLrYDjJVdJlfIBPkKDqRL9A3v8pbaF1/ZWgGvtz1HTTj8ugG0a0TVBOB8lVz1fsEo1d0AWsjdBY3ElK6BowddAShw9Ofqg6JK3pAdZUuhhcBrUlLyIHNHK5w8AVHRWDJQZ0zAOaBeumaOY6YyDSFFq4naDr8MMOcS7A1ze/kfVXOoBaw56PWnPQOe599KT+0q+QFw+T9u3XL5Ac9OXp1289oLdud0yUFtSrmN5BrRL6bgJYMpWJcgJ/Fv+BXXOgXyOfD1RoNxYzWAs0soLKDraEIKB0455KgU0vakKAl0UC/8af4D0T9F6c8UuAfpca/YjKD035SzXDJTgOutfttVwn3Sn5+gdZ1tfhvQ73Aa/Jz8pfkc/cqX9AutOWqtrjvX0Cb05rW4AVFtXM+gKJUg0Gq9DVW0G6NqpwGlIYtv2C6+hmj1ewJAKNaUKyA5Kq/wDSjqmOgaVboWgOsXiYKg3V6FL2Drl0xr6ccaXWgdbobUmk6B+vpM3g+uBd/YO+a6Y0883XWXgH6ctylv5Amugmp9Dyug6oOfpztdKEyCpYf4EAsXi0dUGtGt1qAWMo0FlVMsDSLI0rQB42S1GBjgECcXrdjUGRm4CcLMRug6NipkwTTRKuaBZvD7A9NNAetJ74l059B0tShdFAdMuma5jnoLulgYcBdVy1T1pztAerKEizQOrnpfTlfkBbU6nppQVanBoNoSlSgjdbqdBYtosBWpVjaBlqQoDZaQpGAeNatg6oMnWy1App0zXF0xQLSemtCg6TS9gZLNBLUjWrgG665056yEoO/pJXK1pQejo1Pj10qCWhqlQ1ACIUn21yAVDG0EZep0HQbCzU2A8SlmtoA43FtGgdo5iLkFlWxk0D/2Q==')),
              gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [Color(0xff0043ba), Color(0xff006df1)]),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(50),
                bottomRight: Radius.circular(50),
              )),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: SizedBox(
            width: 150,
            height: 150,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.black,
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                            'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1470&q=80')),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: CircleAvatar(
                    radius: 20,
                    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                    child: Container(
                      margin: const EdgeInsets.all(8.0),
                      decoration: const BoxDecoration(
                          color: Colors.green, shape: BoxShape.circle),
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
