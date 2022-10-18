import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:anywash_delivery/Components/custom_appbar.dart';
import 'package:anywash_delivery/Components/entry_field.dart';
import 'package:anywash_delivery/Locale/locales.dart';
import 'package:anywash_delivery/Themes/colors.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChatWidget();
  }
}

class ChatWidget extends StatefulWidget {
  @override
  _ChatWidgetState createState() => _ChatWidgetState();
}

class _ChatWidgetState extends State<ChatWidget> {
  TextEditingController _messageController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadedSlideAnimation(
      Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(120.0),
            child: CustomAppBar(
              leading: IconButton(
                icon: Hero(
                  tag: 'arrow',
                  child: Icon(Icons.keyboard_arrow_down),
                ),
                onPressed: () => Navigator.pop(context),
              ),
              bottom: PreferredSize(
                preferredSize: Size.fromHeight(0.0),
                child: Hero(
                  tag: 'Delivery Boy',
                  child: Container(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    child: ListTile(
                      leading: Icon(
                        Icons.location_on,
                        size: 26,
                        color: kMainColor,
                      ),
                      title: Text(
                        'Quickwashers',
                        style: Theme.of(context)
                            .textTheme
                            .headline4!
                            .copyWith(fontWeight: FontWeight.w500),
                      ),
                      subtitle: Text(
                        'Restaurant',
                        style: Theme.of(context).textTheme.headline6!.copyWith(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                      ),
                      trailing: IconButton(
                        icon: Icon(Icons.phone, color: kMainColor),
                        onPressed: () {
                          /*.........*/
                        },
                      ),
                    ),
                  ),
                ),
              ),
            )),
        body: DecoratedBox(
          position: DecorationPosition.background,
          decoration: BoxDecoration(
            image: DecorationImage(
                colorFilter:
                    ColorFilter.mode(Colors.white54, BlendMode.modulate),
                image: AssetImage('assets/Maps/map_2.jpg'),
                fit: BoxFit.cover),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              MessageStream(),
              Container(
                color: Theme.of(context).scaffoldBackgroundColor,
                padding: EdgeInsets.only(left: 12.0),
                child: EntryField(
                  controller: _messageController,
                  hint: AppLocalizations.of(context)!.enterMessage,
                  suffixIcon: IconButton(
                    icon: Icon(
                      Icons.send,
                      color: kMainColor,
                    ),
                    onPressed: () {
                      _messageController.clear();
                    },
                  ),
                  border: InputBorder.none,
                ),
              ),
            ],
          ),
        ),
      ),
      beginOffset: Offset(0, 0.3),
      endOffset: Offset(0, 0),
      slideCurve: Curves.linearToEaseOut,
    );
  }
}

class MessageStream extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<MessageBubble> messageBubbles = [
      MessageBubble(
        sender: 'user',
        text: AppLocalizations.of(context)!.heyThere,
        time: '11:58 am',
        isDelivered: false,
        isMe: false,
      ),
      MessageBubble(
        sender: 'delivery_partner',
        text: AppLocalizations.of(context)!.onMyWay,
        time: '11:59 am ',
        isDelivered: false,
        isMe: true,
      ),
    ];
    return Expanded(
      child: ListView(
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
        children: messageBubbles,
      ),
    );
  }
}

class MessageBubble extends StatelessWidget {
  final bool? isMe;
  final String? text;
  final String? sender;
  final String? time;
  final bool? isDelivered;

  MessageBubble(
      {this.sender, this.text, this.time, this.isMe, this.isDelivered});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment:
            isMe! ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: <Widget>[
          Material(
            elevation: 4.0,
            color:
                isMe! ? kMainColor : Theme.of(context).scaffoldBackgroundColor,
            borderRadius: BorderRadius.circular(6.0),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0),
              child: Column(
                crossAxisAlignment:
                    isMe! ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    text!,
                    style: isMe!
                        ? Theme.of(context)
                            .textTheme
                            .caption!
                            .copyWith(fontSize: 13.0, color: kWhiteColor)
                        : Theme.of(context)
                            .textTheme
                            .caption!
                            .copyWith(fontSize: 13.0),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        time!,
                        style: TextStyle(
                          fontSize: 10.0,
                          color: isMe!
                              ? kWhiteColor.withOpacity(0.75)
                              : kLightTextColor,
                        ),
                      ),
                      isMe!
                          ? Icon(
                              Icons.check_circle,
                              color: isDelivered! ? Colors.blue : kDisabledColor,
                              size: 10.0,
                            )
                          : SizedBox.shrink(),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
