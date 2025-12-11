import 'package:flutter/material.dart';
import 'package:social_media_mobile/models/has_id.dart';

class InifiniteScrollList<T extends HasId> extends StatefulWidget {
  final int recordPerPage;
  final Widget Function(T, int) itemBuilder;
  final Future<int> Function(int) fetchData;
  final List<T> data;
  final bool reverse;

  const InifiniteScrollList({
    super.key, 
    required this.recordPerPage,
    required this.itemBuilder, 
    required this.fetchData,
    required this.data,
    this.reverse = false
  });

  @override
  State<StatefulWidget> createState() => InifiniteScrollListState<T>();
}

class InifiniteScrollListState<T extends HasId> extends State<InifiniteScrollList<T>> {
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

      final fetchedDataCount = await widget.fetchData(widget.data.length);
      setState(() {
        if(fetchedDataCount < widget.recordPerPage) {
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
      reverse: widget.reverse,
      controller: _scrollController,
      itemCount: widget.data.length + 1,
      separatorBuilder: (context, index) => const SizedBox(height: 20),
      itemBuilder:(context, index) {
        if(index == widget.data.length) {
          return _isAllFetched ? const SizedBox.shrink()
            : Center(child: CircularProgressIndicator());
        } else {
          return widget.itemBuilder(widget.data[index], index);
        }
      },
    );
  }
}