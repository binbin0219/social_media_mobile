import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:social_media_mobile/providers/current_user_provider.dart';
import 'package:social_media_mobile/providers/websocket_client_provider.dart';
import 'package:social_media_mobile/widgets/chat_list.dart';
import 'package:social_media_mobile/widgets/post_list.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => HomePateState();
}

class HomePateState extends ConsumerState<HomePage> {
  int _selectedIndex = 0;

  Widget _getBodyWidget(int selectedIndex) {
    switch(selectedIndex) {
      case 0:
        return PostList();

      case 2:
        return Column(
          children: [
            Expanded(
              child: ChatList() 
            )
          ],
        );

      default:
        return const Text("Page not found");
    }
  }

  void _onItemTapped(int idx) {
    setState(() {
      _selectedIndex = idx;
    });
    // Navigate to the appropriate screen...
  }

  void handleEnterChatSection() {
    // ref.read(currentUserProvider.notifier).updateUnreadMessages(0);
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = ref.watch(currentUserProvider)!;
    ref.watch(websocketClientProvider);

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 243, 246, 250),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 1,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(16)),
        ),
        title: Text(
          "Blogify",
          style: TextStyle(
            color: const Color(0xFF673AB7),
            fontWeight: FontWeight.w900,
            fontFamily: 'FugazOne',
          ),
        ),
        leading: Padding(
          padding: const EdgeInsets.only(left: 16),
          child: GestureDetector(
            onTap: () {
              // go to profile
            },
            child: const CircleAvatar(
              radius: 18,
              backgroundImage: NetworkImage(
                'https://img.freepik.com/free-vector/smiling-young-man-illustration_1308-174669.jpg',
              ),
            ),
          ),
        ),
        actions: [
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.notifications_none),
                onPressed: () {
                  // open notifications
                },
              ),
              // Badge
              Positioned(
                right: 8,
                top: 8,
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: Colors.redAccent,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      floatingActionButton: Transform.translate(
        offset: const Offset(0, 12),
        child: Container(
          height: 76,
          width: 76,
          decoration: BoxDecoration(
            // color: const Color.fromARGB(255, 177, 135, 250),
            color: const Color(0xFFE6FF00),
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white, width: 4),
          ),
          child: IconButton(
            icon: const Icon(Icons.add, size: 32),
            color: Colors.black87,
            onPressed: () {
              /* open create-post */
            },
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: _getBodyWidget(_selectedIndex),
      bottomNavigationBar: ClipRRect(
        child: BottomAppBar(
          color: Colors.white,
          elevation: 8,
          notchMargin: 0,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Left icons
                Expanded(
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: Icon(
                          _selectedIndex == 0
                              ? Icons.grid_view_rounded
                              : Icons.grid_view,
                          size: 32,
                          color:
                              _selectedIndex == 0
                                  ? Colors.black
                                  : Color(0xFF999AA1),
                        ),
                        onPressed: () => _onItemTapped(0),
                      ),
                      // const SizedBox(width: 30),
                      IconButton(
                        icon: Icon(
                          _selectedIndex == 1
                              ? Icons.explore
                              : Icons.explore_outlined,
                          size: 32,
                          color:
                              _selectedIndex == 1
                                  ? Colors.black
                                  : Color(0xFF999AA1),
                        ),
                        onPressed: () => _onItemTapped(1),
                      ),
                    ],
                  ),
                ),

                const SizedBox(width: 120),

                // Right icons
                Expanded(
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Stack(
                        children: [
                          IconButton(
                            icon: Icon(
                              _selectedIndex == 2
                                  ? Icons.chat_bubble
                                  : Icons.chat_bubble_outline,
                              size: 32,
                              color:
                                  _selectedIndex == 2
                                      ? Colors.black
                                      : Color(0xFF999AA1),
                            ),
                            onPressed: () {
                              _onItemTapped(2);
                              handleEnterChatSection();
                            },
                          ),
                          if(currentUser.unreadChatMessageCount > 0)
                            Positioned(
                              top: 0,
                              right: 2,
                              child: Container(
                                padding: EdgeInsets.all(6),
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  shape: BoxShape.circle,
                                ),
                                child: Text(
                                  currentUser.unreadChatMessageCount.toString(),
                                  style: const TextStyle(
                                    fontSize: 10,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              )
                            )
                        ],
                      ),
                      // const SizedBox(width: 30),
                      IconButton(
                        icon: Icon(
                          _selectedIndex == 3
                              ? Icons.account_circle
                              : Icons.account_circle_outlined,
                          size: 32,
                          color:
                              _selectedIndex == 3
                                  ? Colors.black
                                  : Color(0xFF999AA1),
                        ),
                        onPressed: () => _onItemTapped(3),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
