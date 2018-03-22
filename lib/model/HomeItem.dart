class HomeItem {
  final int id;
  final String title;
  final String img;

  const HomeItem({this.id, this.title, this.img});
}

class HomeItemDao {

  static HomeItem getItemById(id) {
    return items
        .where((i) => i.id == id)
        .first;
  }

  static final List<HomeItem> items = [
    const HomeItem(id:0, title: 'Data', img: 'assets/img/gas-station.jpeg'),
    const HomeItem(id:1, title: 'Vehicles', img: 'assets/img/car.jpeg'),
    const HomeItem(id:2, title: 'Profile', img: 'assets/img/speed.jpeg')
  ];
}