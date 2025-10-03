import 'package:flutter/material.dart';
import 'package:social_media_mobile/models/has_id.dart';

class InifiniteScrollList<T extends HasId> extends StatefulWidget {
  final int recordPerPage;
  final Widget Function(T) itemBuilder;
  final Future<List<T>> Function(int) fetchData;

  const InifiniteScrollList({
    super.key, 
    required this.recordPerPage,
    required this.itemBuilder, 
    required this.fetchData
  });

  @override
  State<StatefulWidget> createState() => InifiniteScrollListState<T>();
}

class InifiniteScrollListState<T extends HasId> extends State<InifiniteScrollList<T>> {
  final List<T> _data = [];
  final ScrollController _scrollController = ScrollController();

  bool _isError = false;
  bool _isFetching = false;
  bool _isAllFetched = false;

  @override
  void initState() {
    super.initState();
    _fetchData();
    _scrollController.addListener(() {
      if(_isAllFetched) return;

      final bool shouldLoadMore = _scrollController.offset >= _scrollController.position.maxScrollExtent - 200 &&
          !_scrollController.position.outOfRange;
      if (shouldLoadMore) {
        _fetchData();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _fetchData() async {
    try {
      if(_isFetching) return;
      setState(() {
        _isFetching = true;
      });

      final fetchedData = await widget.fetchData(_data.length);

      Set<dynamic> existingDataIds = _data.map((data) => data.id).toSet();
      List<T> newData = fetchedData.where((data) => !existingDataIds.contains(data.id)).toList();
      setState(() {
        _data.addAll(newData);
        if(fetchedData.length < widget.recordPerPage) {
          _isAllFetched = true;
        }
      });

    } on Exception catch (e) {
      print("Failed to fetch data: $e");
      setState(() {
        _isError = true;
      });
    } finally {
      setState(() {
        _isFetching = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      controller: _scrollController,
      itemCount: _data.length + 1,
      separatorBuilder: (context, index) => const SizedBox(height: 20),
      itemBuilder:(context, index) {
        if(index == _data.length) {
          return _isAllFetched ? const SizedBox.shrink()
            : Center(child: CircularProgressIndicator());
        } else {
          return widget.itemBuilder(_data[index]);
        }
      },
    );
  }
}