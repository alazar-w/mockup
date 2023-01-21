import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';
import 'package:stacked_card_carousel/stacked_card_carousel.dart';
import '../../../business/business.dart';
import '../../../data/data.dart';
import 'package:interview_mockup/presentation/presentation.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late ThemeStyle _themeStyle;
  late String todayDate = CommonMethods.formatedDate(DateTime.now());
  late int cardIndex;
  late String documentId;
  late List<Widget> styleCards;
  late List<String> bottomDropDownContent = <String>[
    'Jira',
    'Slack',
    'Trello',
    'None'
  ];
  late List<String> topDropDownContent = <String>[
    'Sarah Cobb',
    'Taylor Buchanan',
    'Amanda Rogers',
    'New +'
  ];
  final myController = TextEditingController();
  late String bottomDropDownValue = bottomDropDownContent.first;
  late String topDropDownValue = topDropDownContent.first;
  late bool showStatus = false;
  late BoxConstraints boxConstraints;
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the widget tree.
    // This also removes the _printLatestValue listener.
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _themeStyle = context.watch<CurrentThemeBloc>().state;
    styleCards = [];

    return Material(
      color: _themeStyle.secondaryColor,
      elevation: 2.0,
      child: LayoutBuilder(builder: (context, constraint) {
        boxConstraints = constraint;
        return CenteredView(
          child: Column(
            children: [
              _navBar(),
              Expanded(
                  child: constraint.maxWidth < 700
                      ? Column(
                          children: [
                            // _introduction(),

                            Center(
                              child: _callToAction(),
                            ),
                            Expanded(
                              child: CustomPaint(
                                  painter: CardBackground(),
                                  child:
                                      BlocConsumer<CardItemBloc, CardItemState>(
                                    listener: (context, state) {},
                                    builder: (context, state) {
                                      if (state is ListCardItemSuccess) {
                                        for (int i = 0;
                                            i < state.cardItem.length;
                                            i++) {
                                          styleCards.add(_card(
                                              i,
                                              state.cardItem[i].source!,
                                              state.cardItem[i].description!));
                                        }

                                        return SizedBox(
                                          width: constraint.maxWidth > 700
                                              ? 50.w
                                              : 90.w,
                                          child: StackedCardCarousel(
                                            initialOffset: 40,
                                            spaceBetweenItems: 40.h,
                                            items: styleCards,
                                            applyTextScaleFactor: true,
                                            onPageChanged: (int pageIndex) {
                                              setState(() {
                                                cardIndex = pageIndex;
                                                documentId = state
                                                    .cardItem[cardIndex].id
                                                    .toString();
                                              });
                                            },
                                          ),
                                        );
                                      } else if (state is CardItemDataLoading) {
                                        return Center(
                                            child: CircularProgressIndicator(
                                          color: _themeStyle.primaryTextColor,
                                        ));
                                      }

                                      return _retryButton(
                                          message:
                                              "Something Went Wrong,Retry!",
                                          onPressed: () {
                                            BlocProvider.of<CardItemBloc>(
                                                    context)
                                                .add(ListCardItem());
                                          });
                                    },
                                  )),
                            ),
                          ],
                        )
                      : Row(
                          children: [
                            // _introduction(),
                            CustomPaint(
                                painter: CardBackground(),
                                child:
                                    BlocConsumer<CardItemBloc, CardItemState>(
                                  listener: (context, state) {},
                                  builder: (context, state) {
                                    if (state is ListCardItemSuccess) {
                                      for (int i = 0;
                                          i < state.cardItem.length;
                                          i++) {
                                        styleCards.add(_card(
                                            i,
                                            state.cardItem[i].source!,
                                            state.cardItem[i].description!));
                                      }

                                      return SizedBox(
                                        width: constraint.maxWidth > 700
                                            ? 50.w
                                            : 90.w,
                                        child: StackedCardCarousel(
                                          initialOffset: 40,
                                          spaceBetweenItems: 50.h,
                                          items: styleCards,
                                          applyTextScaleFactor: true,
                                          onPageChanged: (int pageIndex) {
                                            setState(() {
                                              cardIndex = pageIndex;
                                              documentId = state
                                                  .cardItem[cardIndex].id
                                                  .toString();
                                            });
                                          },
                                        ),
                                      );
                                    } else if (state is CardItemDataLoading) {
                                      return Center(
                                          child: CircularProgressIndicator(
                                        color: _themeStyle.primaryTextColor,
                                      ));
                                    }

                                    return _retryButton(
                                        message: "Something Went Wrong,Retry!",
                                        onPressed: () {
                                          BlocProvider.of<CardItemBloc>(context)
                                              .add(ListCardItem());
                                        });
                                  },
                                )),

                            Expanded(
                                child: Center(
                              child: _callToAction(),
                            ))
                          ],
                        ))
            ],
          ),
        );
      }),
    );
  }

  Widget _retryButton({required Function onPressed, required String message}) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: TextButton(onPressed: onPressed(), child: Text(message)),
    );
  }

  Widget _callToAction() {
    return CustomButtons.primaryButton(
      onPressed: () async {
        setState(() {
          BlocProvider.of<CardItemBloc>(context)
              .add(AddCardItemEvent("", "", "", ""));
        });
      },
      themeStyle: ThemeStyle(isLight: true),
      minWidth: 18.w,
      text: LocalStrings.localString(string: "requests", context: context),
    );
  }

  Widget _navBar() {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.transparent,
      ),
      height: 20.h,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: [
              SvgPicture.asset(ImageAssets.iconLogo),
              SizedBox(
                width: 2.w,
              ),
              _navBarItem('overview'),
              SizedBox(
                width: 2.w,
              ),
              _navBarItem('news'),
              SizedBox(
                width: 2.w,
              ),
              _navBarItem('users'),
            ],
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[_notificationButton(), _themeButton()],
          )
        ],
      ),
    );
  }

  Widget _navBarItem(String title) {
    return AutoSizeText(
      LocalStrings.localString(string: title, context: context),
      style: TextStyle(
        color: _themeStyle.primaryTextColor,
        fontWeight: FontWeight.bold,
      ),
      maxFontSize: 7.sp.floorToDouble(),
      minFontSize: 4.sp.floorToDouble(),
    );
  }

  Widget _themeButton() {
    return CustomButtons.circularButton(
      onPressed: () {
        BlocProvider.of<CurrentThemeBloc>(context).switchTheme();
      },
      padding: EdgeInsets.only(right: 4.w),
      // svgPath: ImageAssets.userSvg,
      iconData: Icons.nightlight,
      iconColor: _themeStyle.mainColor,
      tooltip: LocalStrings.localString(string: "theme", context: context),
      backgroundColor: _themeStyle.primaryColorOnPrimary,
    );
  }

  Widget _notificationButton() {
    return CustomButtons.circularButton(
      onPressed: () {
        // Navigator.push(context, Navigation.getRoute(const NotificationSettings()));
      },
      padding: EdgeInsets.only(right: 4.w),
      svgPath: ImageAssets.notificationskSvg,
      tooltip:
          LocalStrings.localString(string: "notification", context: context),
      backgroundColor: _themeStyle.primaryColorOnPrimary,
      iconColor: _themeStyle.mainColor,
    );
  }

  Widget _card(int index, String description, String source) {
    return Container(
        decoration: BoxDecoration(
          color: _themeStyle.primaryColorOnPrimary,
          borderRadius: BorderRadius.circular(55.0),
        ),
        padding: EdgeInsets.all(4.w),
        child: _cardContent(index, description, source));
  }

  Widget _cardContent(int index, String description, String source) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _cardContentTop(),
        SizedBox(
          height: 2.h,
        ),
        _cardContentMiddle(index, description, source),
        _cardContentBottom()
      ],
    );
  }

  Widget _cardContentTop() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            _commonDropDown("top", topDropDownContent),
          ],
        ),
        Row(
          children: [
            _datePicker(),
            SizedBox(
              width: 1.w,
            ),
            AutoSizeText(
              todayDate.toString(),
              style: TextStyle(
                color: _themeStyle.evenDarkColor,
                fontWeight: FontWeight.bold,
              ),
              maxFontSize: 6.sp.floorToDouble(),
              minFontSize: 4.sp.floorToDouble(),
            )
          ],
        )
      ],
    );
  }

  Widget _datePicker() {
    return GestureDetector(
        onTap: () async {
          setState(() {
            showStatus = true;
          });

          var response = await CommonMethods.pickDate(context);

          if (response == "display") {
            setState(() {
              showStatus = false;
            });
          }
          setState(() {
            todayDate = CommonMethods.formatedDate(response);
            showStatus = false;
          });
        },
        child: Icon(
          Icons.calendar_today,
          size: 1.5.w,
          color: _themeStyle.evenDarkColor,
        ));
  }

  Widget _cardContentMiddle(int index, String description, String source) {
    return Container(
      margin: EdgeInsets.only(left: 2.w),
      child: _inputTextField(
          index: index,
          onSuffixIconPressed: () {},
          currentValue: description,
          themeStyle: _themeStyle),
    );
  }

  Widget _inputTextField({
    required int index,
    required VoidCallback onSuffixIconPressed,
    required String currentValue,
    required ThemeStyle themeStyle,
    IconData suffixIconData = Icons.delete,
    IconData prefixIconData = Icons.add,
    bool enabled = true,
  }) {
    return TextFormField(
      onChanged: (text) {
        //call firebase to save data
        currentValue = text;
      },
      keyboardType: TextInputType.multiline,
      maxLines: null,
      initialValue: currentValue,
      enabled: index != 0 ? enabled : !enabled,
      decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide.none,
          ),
          contentPadding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 0.h),
          filled: true,
          fillColor: themeStyle.primaryColorOnPrimary,
          prefixIconColor: themeStyle.primaryColorOnPrimary,
          prefixIcon: index != 0
              ? InkWell(
                  onTap: () {
                    setState(() {
                      BlocProvider.of<CardItemBloc>(context)
                          .add(EditCardItemEvent(documentId, currentValue));
                    });
                  },
                  child: Icon(prefixIconData))
              : const Icon(Icons.sort),
          suffixIcon: index != 0
              ? InkWell(
                  onTap: () {
                    setState(() {
                      if (styleCards.length == 1) {
                        BlocProvider.of<CardItemBloc>(context)
                            .add(AddCardItemEvent("", "", "", ""));
                      }
                      BlocProvider.of<CardItemBloc>(context)
                          .add(RemoveCardItemEvent(documentId));
                      BlocProvider.of<CardItemBloc>(context)
                          .add(EditCardItemEvent(documentId, currentValue));
                    });
                  },
                  child: Icon(suffixIconData))
              : Icon(
                  suffixIconData,
                  color: Colors.transparent,
                ),
          hintText: index != 0 ? "Add Task Description" : "Task Description"),
    );
  }

  Widget _cardContentBottom() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        _commonDropDown("bottom", bottomDropDownContent),
        SizedBox(
          width: 4.w,
        ),
        showStatus ? _bottomContentRight() : const Text("")
      ],
    );
  }

  Widget _commonDropDown(String content, List<String> items) {
    return Container(
      padding: content == "bottom"
          ? EdgeInsets.only(left: 2.w)
          : const EdgeInsets.only(left: 0),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          iconSize: 0.0,
          value: content == "bottom" ? bottomDropDownValue : topDropDownValue,
          // icon: const Icon(Icons.arrow_downward),
          elevation: 16,
          style: TextStyle(color: _themeStyle.evenDarkColor),

          onChanged: (String? value) {
            // This is called when the user selects an item;
            if (value == topDropDownContent.last) {
            } else {
              setState(() {
                content == "bottom"
                    ? bottomDropDownValue = value!
                    : topDropDownValue = value!;
              });
            }
          },
          items: items.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
                value: value,
                child: content == "bottom"
                    ? _bottomDropDownContent(value)
                    : _topDropDownContent(value));
          }).toList(),
        ),
      ),
    );
  }

  Widget _bottomDropDownContent(String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Icons.abc),
        SizedBox(
          width: 0.5.w,
        ),
        Text(value)
      ],
    );
  }

  Widget _topDropDownContent(String value) {
    return Row(
      children: [
        value == "New +"
            ? Container(
                padding: EdgeInsets.only(left: 1.5.w),
              )
            : Container(
                width: 5.w,
                height: 5.w,
                decoration: BoxDecoration(
                    color: _themeStyle.evenDarkColor, shape: BoxShape.circle),
                child: Center(
                  child: AutoSizeText(
                    value[0].toUpperCase() + value[0].toUpperCase(),
                    style: TextStyle(
                      color: _themeStyle.evenLightColor,
                      fontWeight: FontWeight.bold,
                    ),
                    maxFontSize: 5.sp.floorToDouble(),
                    minFontSize: 3.sp.floorToDouble(),
                  ),
                ),
              ),
        SizedBox(
          width: boxConstraints.maxWidth < 700 ? 1.w : 0.w,
        ),
        AutoSizeText(
          value,
          style: TextStyle(
            color: value == "New +"
                ? _themeStyle.mainColor
                : _themeStyle.evenDarkColor,
            fontWeight: FontWeight.bold,
          ),
          maxFontSize: 6.sp.floorToDouble(),
          minFontSize: 4.sp.floorToDouble(),
        )
      ],
    );
  }

  Widget _bottomContentRight() {
    return Row(
      children: [
        Row(
          children: [
            Row(
              children: [
                Icon(
                  Icons.history,
                  color: _themeStyle.mainColor,
                ),
                AutoSizeText(
                  "90%",
                  style: TextStyle(
                    color: _themeStyle.mainColor,
                    fontWeight: FontWeight.bold,
                  ),
                  maxFontSize: 5.sp.floorToDouble(),
                  minFontSize: 2.5.sp.floorToDouble(),
                )
              ],
            ),
            SizedBox(
              width: 0.5.w,
            ),
            Row(
              children: [
                Icon(
                  Icons.history,
                  color: _themeStyle.mainColor,
                ),
                AutoSizeText(
                  "2 days",
                  style: TextStyle(
                    color: _themeStyle.mainColor,
                    fontWeight: FontWeight.bold,
                  ),
                  maxFontSize: 5.sp.floorToDouble(),
                  minFontSize: 2.5.sp.floorToDouble(),
                )
              ],
            )
          ],
        )
      ],
    );
  }
}
