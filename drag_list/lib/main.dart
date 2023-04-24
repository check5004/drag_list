import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // アプリのエントリポイント
  @override
  Widget build(BuildContext context) {
    // MaterialAppウィジェットでアプリの基本スタイルを設定
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Reorderable Card List')),
        body: ReorderableCardList(),
      ),
    );
  }
}

class ReorderableCardList extends StatefulWidget {
  // StatefulWidgetを継承して、リストの並べ替えを状態管理できるようにする
  @override
  _ReorderableCardListState createState() => _ReorderableCardListState();
}

class _ReorderableCardListState extends State<ReorderableCardList> {
  // リストアイテムを文字列のリストで表現
  List<String> _items = ['Item 1', 'Item 2', 'Item 3', 'Item 4', 'Item 5'];

  @override
  Widget build(BuildContext context) {
    // ReorderableListViewを使って並べ替え可能なリストを作成
    return ReorderableListView(
      onReorder: _onReorder, // 並べ替えが完了したときのコールバック関数
      children: _items.map((String item) {
        // カードを作成し、ReorderableListViewのchildrenに追加
        return Card(
          key: ValueKey(item), // カードに一意のキーを設定
          child: ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            title: Text(item), // カードのテキストを表示
            onTap: () {}, // カード全体がタップ可能になるように空の関数を設定
          ),
        );
      }).toList(),
    );
  }

  // 並べ替えが完了したときに呼ばれるコールバック関数
  void _onReorder(int oldIndex, int newIndex) {
    // newIndexがoldIndexより大きい場合、newIndexをデクリメント
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }
    // 状態を更新してリストアイテムの並べ替えを反映
    setState(() {
      String item = _items.removeAt(oldIndex); // 古いインデックスからアイテムを削除
      _items.insert(newIndex, item); // 新しいインデックスにアイテムを挿入
      print('oldIndex: $oldIndex, newIndex: $newIndex, item: $item'); // デバッグ用
    });
  }
}
