import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:social_media_freelance/constants/content_constants.dart';
import 'package:social_media_freelance/constants/dummy_data.dart';

enum SecondEditPageMode { select, type, date, chip }

class SecondEditPage extends StatefulWidget {
  SecondEditPage(
      {Key? key,
      required this.mode,
      this.date,
      this.value,
      this.options,
      required this.editTitle})
      : super(key: key);

  final SecondEditPageMode mode;
  final String editTitle;
  final List<String>? options;
  DateTime? date;
  String? value;

  @override
  State<SecondEditPage> createState() => _SecondEditPageState();
}

class _SecondEditPageState extends State<SecondEditPage> {
  TextEditingController controller = TextEditingController();

  void confirm() {
    if (widget.mode == SecondEditPageMode.type) {
      widget.value = controller.text;
      Navigator.pop(context, widget.value);
    }

    if (widget.mode == SecondEditPageMode.date) {
      Navigator.pop(context, widget.date);
    }
  }

  void cancel() {
    Navigator.pop(context);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.mode == SecondEditPageMode.type) {
      controller.text = widget.value ?? "";
    }
  }

  Widget _header() => Padding(
        padding: EdgeInsets.all(8.0.w),
        child: Stack(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InkWell(
                onTap: cancel,
                child: Icon(
                  Icons.close,
                  size: 30.sp,
                ),
              ),
              widget.mode == SecondEditPageMode.select
                  ? Container()
                  : InkWell(
                      onTap: confirm,
                      child: Icon(
                        Icons.check,
                        color: Colors.blue,
                        size: 30.sp,
                      ))
            ],
          ),
          Container(
            height: 30.sp,
            child: Center(
              child: Text(
                widget.editTitle,
                style: GoogleFonts.urbanist(
                    fontSize: 16.sp, fontWeight: FontWeight.w500),
              ),
            ),
          )
        ]),
      );

  Widget _TypeBody() => Padding(
        padding: const EdgeInsets.all(12.0),
        child: TextFormField(
          controller: controller,
          decoration: const InputDecoration(
            border: UnderlineInputBorder(),
            hintText: 'Enter',
          ),
        ),
      );

  Widget _DateBody() => InkWell(
        onTap: () async {
          final DateTime? picked = await showDatePicker(
              context: context,
              initialDate: widget.date!,
              firstDate: DateTime(1900, 1),
              lastDate: DateTime(2101));
          if (picked != null && picked != widget.date)
            setState(() {
              widget.date = picked;
            });
        },
        child: Container(
          height: 50.h,
          child: Center(
            child: Text(
              DateFormat('dd/MM/yyyy').format(widget.date!),
              style: GoogleFonts.urbanist(fontSize: 16.sp),
            ),
          ),
        ),
      );

  Widget _SelectBody() => Expanded(
        child: SingleChildScrollView(
          child: Column(
              children: widget.options!
                  .map((e) => _MenuTile(
                        title: e,
                        mode: SecondEditPageMode.chip,
                        value: e,
                        chip: true,
                        onTap: (value) {
                          widget.value = e;
                          Navigator.pop(context, widget.value);
                        },
                      ))
                  .toList()),
        ),
      );

  Widget _body() {
    switch (widget.mode) {
      case SecondEditPageMode.type:
        return _TypeBody();
      case SecondEditPageMode.date:
        return _DateBody();
      case SecondEditPageMode.select:
        return _SelectBody();
      default:
        return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).padding.top,
        ),
        _header(),
        SizedBox(
          height: 20.h,
        ),
        _body()
      ],
    ));
  }
}

class _MenuTile extends StatelessWidget {
  _MenuTile(
      {Key? key,
      required this.title,
      required this.onTap,
      this.chip = false,
      required this.mode,
      this.editTitle,
      this.options,
      this.date,
      this.value})
      : super(key: key);

  final String title;
  final bool chip;
  final Function(dynamic value) onTap;

  final SecondEditPageMode mode;
  String? editTitle;
  final List<String>? options;
  final DateTime? date;
  final dynamic? value;

  DateFormat formatter = DateFormat("MMMM d, yyyy");

  String formattedValue() {
    if (mode == SecondEditPageMode.date) {
      return formatter.format(date as DateTime);
    } else {
      return value.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        if (!chip) {
          dynamic? result = await Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => SecondEditPage(
                    mode: mode,
                    value: value,
                    options: options,
                    date: date,
                    editTitle: editTitle!,
                  )));

          onTap(result);
        }
        onTap(null);
      },
      child: Container(
        width: 1.sw,
        height: 50.h,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Row(
            children: [
              Text(
                title,
                style: GoogleFonts.urbanist(
                    fontSize: 16.sp, fontWeight: FontWeight.w500),
              ),
              ...(chip
                  ? []
                  : [
                      Expanded(child: Container()),
                      Text(
                        formattedValue(),
                        style: GoogleFonts.urbanist(
                            fontSize: 16.sp,
                            color: Colors.black54,
                            fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        width: 5.w,
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.grey,
                      )
                    ])
            ],
          ),
        ),
      ),
    );
  }
}

class EditPage extends StatefulWidget {
  EditPage({Key? key}) : super(key: key);

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  String _username = "ranatrkylmz",
      _gender = "Kadın",
      _biography = ".............",
      _city = "İstanbul",
      _country = "Türkiye",
      _language = "Türkçe";

  DateTime _birthday = DateTime(2000, 1, 1);

  Widget Menu({
    required List<Widget> children,
  }) =>
      Container(
        decoration: BoxDecoration(color: Colors.white, boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.02),
              blurRadius: 10.0,
              spreadRadius: 5.0,
              offset: Offset(0.0, -2.0)),
        ]),
        child: Column(
          children: children,
        ),
      );

  Widget _ProfilePictureBar() => Container(
        width: 1.sw,
        height: 80.h,
        decoration: BoxDecoration(color: Colors.white, boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.02),
              blurRadius: 10.0,
              spreadRadius: 5.0,
              offset: Offset(0.0, -2.0))
        ]),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Profil",
                  style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.black.withOpacity(0.7))),
              Container(
                width: 60.h,
                height: 60.h,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: ProfileDummyData.profileImage.image,
                    fit: BoxFit.cover,
                  ),
                ),
              )
            ],
          ),
        ),
      );

  Widget _header(BuildContext context) => Padding(
        padding: EdgeInsets.all(20.0.w),
        child: Stack(
          children: [
            Container(
              width: 1.sw,
              child: Center(
                child: Text(
                  'Profil Düzenle',
                  style: TextStyle(
                    fontSize: 22.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
            InkWell(
              child: Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
                size: 25.sp,
              ),
              onTap: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      );

  Widget horizontalLine() => Container(
        width: 0.95.sw,
        height: 1.h,
        color: Colors.grey.withOpacity(0.3),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        child: Column(children: [
          SizedBox(height: MediaQuery.of(context).padding.top),
          _header(context),
          _ProfilePictureBar(),
          SizedBox(
            height: 60,
          ),
          Menu(children: [
            _MenuTile(
              title: "Kullanıcı Adı",
              editTitle: "Kullanıcı Adı Değiştir",
              mode: SecondEditPageMode.type,
              value: _username,
              onTap: (val) {
                if (val == null) {
                  return;
                }
                setState(() {
                  _username = val;
                });
              },
            ),
            horizontalLine(),
            _MenuTile(
              title: "Cinsiyet",
              editTitle: "Cinsiyet Değiştir",
              value: _gender,
              mode: SecondEditPageMode.select,
              options: [
                "Kadın",
                "Erkek",
                "Diğer",
              ],
              onTap: (val) {
                if (val == null) {
                  return;
                }
                setState(() {
                  _gender = val;
                });
              },
            ),
            horizontalLine(),
            _MenuTile(
              editTitle: "Doğum Tarihi Değiştir",
              title: "Doğum Tarihi",
              mode: SecondEditPageMode.date,
              date: _birthday,
              onTap: (val) {
                if (val == null) {
                  return;
                }
                setState(() {
                  _birthday = val;
                });
              },
            ),
            horizontalLine(),
            _MenuTile(
              editTitle: "Biyografi Değiştir",
              mode: SecondEditPageMode.type,
              value: _biography,
              title: "Biyografi",
              onTap: (val) {
                if (val == null) {
                  return;
                }
                setState(() {
                  _biography = val;
                });
              },
            ),
          ]),
          SizedBox(
            height: 60,
          ),
          Menu(children: [
            _MenuTile(
              editTitle: "Şehir Değiştir",
              mode: SecondEditPageMode.select,
              value: _city,
              title: "Şehir",
              options: ContentConstants.cities,
              onTap: (val) {
                if (val == null) {
                  return;
                }
                setState(() {
                  _city = val;
                });
              },
            ),
            horizontalLine(),
            _MenuTile(
              editTitle: "Ülke Değiştir",
              mode: SecondEditPageMode.select,
              value: _country,
              title: "Ülke",
              options: ContentConstants.countries,
              onTap: (val) {
                if (val == null) {
                  return;
                }
                setState(() {
                  _country = val;
                });
              },
            ),
            horizontalLine(),
            _MenuTile(
              editTitle: "Dil Değiştir",
              mode: SecondEditPageMode.select,
              value: _language,
              title: "Dil",
              options: ["Türkçe"],
              onTap: (val) {
                if (val == null) {
                  return;
                }
                setState(() {
                  _language = val;
                });
              },
            ),
          ]),
        ]),
      ),
    );
  }
}
