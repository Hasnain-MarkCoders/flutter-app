class MessageCommonList{
  String profileIcon;
  String text;

  MessageCommonList({
    required this.profileIcon,
    required this.text,
  });
}
class ChatMessage{
  String text;
  int type;
  ChatMessage({
    required this.text,
    required this.type,
});
}