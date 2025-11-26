
import '../../Utill/app_dateformatters.dart';
import '../../Utill/app_required.dart';

class SearchKeyWidget extends StatelessWidget {
  final List<String?> items;
  final Function(int index)? onTap;
  final int SelectedIndex;
  // Constructor to pass the items and optional onTap callback
  const SearchKeyWidget({
    Key? key,
    required this.items,
    this.onTap,
    required this.SelectedIndex
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      margin: const EdgeInsets.only(
          top: Dimensions.paddingSizeDefault,
          left: Dimensions.paddingSizeMedium,
          right: Dimensions.paddingSizeMedium),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: items.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => onTap != null ? onTap!(index) : null,
            child: Center(
            child: Text(
             DateConverterHelper.dateMounthformatDate(items[index]!) ,
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
          style: Styles.inriaSansRegular.copyWith(
          fontSize: Dimensions.fontSizeLarge17,
          fontWeight: SelectedIndex == index
          ? FontWeight.w600
              : FontWeight.w400,
          color: SelectedIndex == index
          ? AppColors.primaryColor
              : AppColors.fountGray,
          ),
          ),
          ),
          );
        },
      ),
    );
  }
}
