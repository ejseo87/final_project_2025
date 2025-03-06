import 'package:final_project_2025/common/widgets/app_bar_widget.dart';
import 'package:final_project_2025/common/widgets/form_button_widget.dart';
import 'package:final_project_2025/constants/gaps.dart';
import 'package:final_project_2025/constants/sizes.dart';
import 'package:final_project_2025/features/post/view_models/post_mood_view_model.dart';
import 'package:final_project_2025/features/settings/view_models/settings_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PostScreen extends ConsumerStatefulWidget {
  static const String routeName = "post";
  static const String routeURL = "/post";
  const PostScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PostScreenState();
}

class _PostScreenState extends ConsumerState<PostScreen> {
  final TextEditingController _textController = TextEditingController();

  final List<String> _icons = ["😀", "😍", "😊", "🥳", "😭", "🤬", "🫠", "🤮"];

  String _text = "";
  int _selectedIconIndex = 0;

  @override
  void initState() {
    super.initState();
    _textController.addListener(() {
      setState(() {
        _text = _textController.text;
      });
    });
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  void _onTapHideKeyboard() {
    FocusManager.instance.primaryFocus?.unfocus();
  }

  void _onPost(BuildContext context) {
    ref
        .read(postMoodProvider.notifier)
        .postMood(
          context: context,
          mood: _text,
          icon: _icons[_selectedIconIndex],
        );
  }

  void _onIconTap(int index) {
    setState(() {
      _selectedIconIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isDark = ref.watch(settingsProvider).darkmode;
    return GestureDetector(
      onTap: _onTapHideKeyboard,
      child: Scaffold(
        appBar: AppBarWidget(showGear: true),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: Sizes.size20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Gaps.v32,
              Text(
                "How do you feel?",
                style: TextStyle(
                  fontSize: Sizes.size18,
                  fontWeight: FontWeight.w800,
                ),
              ),
              Gaps.v10,
              Container(
                decoration: BoxDecoration(
                  color:
                      isDark
                          ? Colors.grey.shade800
                          : Theme.of(context).scaffoldBackgroundColor,
                  borderRadius: BorderRadius.circular(Sizes.size16),
                  border: Border.all(
                    width: Sizes.size1,
                    color: isDark ? Colors.grey.shade600 : Colors.black,
                  ),
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(-1, 3),
                      color: isDark ? Colors.grey.shade600 : Colors.black,
                      //blurRadius: 3,
                      spreadRadius: 0,
                    ),
                  ],
                ),
                child: TextField(
                  controller: _textController,
                  showCursor: true,
                  cursorColor: Theme.of(context).primaryColor,
                  maxLines: 8,
                  textInputAction: TextInputAction.newline,
                  decoration: InputDecoration(
                    hintText: "Write it down here!",
                    hintStyle: TextStyle(fontSize: Sizes.size14),
                    contentPadding: EdgeInsets.symmetric(
                      vertical: Sizes.size10,
                      horizontal: Sizes.size10,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(Sizes.size16),
                      borderSide: BorderSide(
                        width: Sizes.size1,
                        color: isDark ? Colors.grey.shade600 : Colors.black,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(Sizes.size16),
                      borderSide: BorderSide(
                        width: Sizes.size1,
                        color: isDark ? Colors.grey.shade600 : Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
              Gaps.v20,
              Text(
                "What's your mood?",
                style: TextStyle(
                  fontSize: Sizes.size18,
                  fontWeight: FontWeight.w800,
                ),
              ),
              Gaps.v10,
              Container(
                height: 35,
                width: size.width,
                color: Theme.of(context).scaffoldBackgroundColor,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () => _onIconTap(index),
                      child: Container(
                        width: 35,
                        height: 35,

                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color:
                              index == _selectedIconIndex
                                  ? Theme.of(context).primaryColor
                                  : isDark
                                  ? Colors.grey.shade800
                                  : Colors.white,
                          borderRadius: BorderRadius.circular(Sizes.size5),
                          border: Border.all(
                            width: 1,
                            color: isDark ? Colors.grey.shade600 : Colors.black,
                          ),
                          boxShadow: [
                            BoxShadow(
                              offset: Offset(0, 4),
                              color:
                                  isDark ? Colors.grey.shade600 : Colors.black,
                              //blurRadius: 3,
                              spreadRadius: 0,
                            ),
                          ],
                        ),
                        child: Text(
                          _icons[index],
                          style: TextStyle(fontSize: Sizes.size24),
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => Gaps.h10,
                  itemCount: _icons.length,
                ),
              ),
              Gaps.v48,
              Container(
                width: size.width,
                alignment: Alignment.center,
                child: GestureDetector(
                  onTap: () => _onPost(context),
                  child: FormButtonWidget(
                    isValid: _text.isNotEmpty,
                    text: "Post",
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
