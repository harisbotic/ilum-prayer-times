import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/util/bloc/timing_method/timing_methods.dart';

class TimingMethodSelect extends StatefulWidget {
  final List<TimingMethod> items;
  final TimingMethod selectedItem;
  final ValueChanged<TimingMethod> onChanged;

  TimingMethodSelect({
    required this.items,
    required this.selectedItem,
    required this.onChanged,
  });

  @override
  _TimingMethodSelectState createState() => _TimingMethodSelectState();
}

class _TimingMethodSelectState extends State<TimingMethodSelect> {
  TimingMethod? _selectedItem;

  @override
  void initState() {
    super.initState();
    _selectedItem = widget.selectedItem;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _showCustomDropDown(context);
      },
      child: Container(
        width: 82.0.w,
        height: 40.0.h,
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 6.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Text(
                    _selectedItem!.shortDisplayName,
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ),
                SvgPicture.asset(
                  'assets/images/setting_icon/svg/arrow_down.svg',
                  color: Theme.of(context).textTheme.bodyText1!.color,
                  width: 20.w,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showCustomDropDown(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 200,
          child: ListView.builder(
            itemCount: widget.items.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                title: Text(widget.items[index].displayName),
                onTap: () {
                  setState(() {
                    _selectedItem = widget.items[index];
                    widget.onChanged(_selectedItem!);
                  });
                  Navigator.pop(context);
                },
              );
            },
          ),
        );
      },
    );
  }
}
