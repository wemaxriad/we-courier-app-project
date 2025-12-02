
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:shimmer/shimmer.dart';

import '../../Controllers/global-controller.dart';
import '../../Controllers/profile_controller.dart';
import '../../utils/image.dart';
import '../../utils/style.dart';
import '../Payment/balance_details.dart';
import '../Widgets/button_global.dart';
import '../Widgets/constant.dart';
import 'package:get/get.dart';

import '../Widgets/profile_card.dart';
import '../Widgets/shimmer/profile_shimmer.dart';
import 'change_language_view.dart';
import 'change_password_view.dart';
import 'edit_profile_view.dart';


class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  ProfileController profileController = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
      builder: (profile) => Scaffold(
        backgroundColor: kMainColor,
        appBar: AppBar(
          title: Text(
            'profile'.tr,
            style: kTextStyle.copyWith(color: kBgColor),
          ),
          backgroundColor: kMainColor,
          elevation: 0.0,
          iconTheme: const IconThemeData(color: kBgColor),
        ),
        body: Container(
          clipBehavior: Clip.antiAlias,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            border: Border.all(color: kGreyTextColor.withOpacity(0.2)),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(30.0),
              topRight: Radius.circular(30.0),
            ),
            color: Colors.white,
          ),
          child: profile.profileLoader || profile.profileUser == null
              ? ProfileShimmer()
              : SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  const SizedBox(height: 20),


                  Stack(
                    children: [
                      SizedBox(
                        width: 100.w,
                        height: 100.h,
                        child: CachedNetworkImage(
                          imageUrl: profile.profileUser?.image ?? "",
                          imageBuilder: (context, imageProvider) =>
                              CircleAvatar(
                                radius: 50,
                                backgroundImage: imageProvider,
                              ),
                          placeholder: (context, url) =>
                              Shimmer.fromColors(
                                baseColor: Colors.grey[300]!,
                                highlightColor: Colors.grey[400]!,
                                child: const CircleAvatar(radius: 50),
                              ),
                          errorWidget: (_, __, ___) =>
                          const CircleAvatar(
                              radius: 50,
                              child: Icon(CupertinoIcons.person)),
                        ),
                      ),


                      Positioned(
                        top: 75,
                        right: 20,
                        child: InkWell(
                          onTap: () => Get.to(EditProfileView()),
                          child: CircleAvatar(
                            radius: 15,
                            backgroundColor: Colors.white,
                            child: CircleAvatar(
                              radius: 13,
                              backgroundColor: darkGray,
                              child: Image.asset(
                                Images.iconEdit,
                                height: 20,
                                width: 20,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),


                  Text(
                    profile.profileUser?.name ?? '',
                    style: const TextStyle(
                      fontFamily: 'Rubik',
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),

                  SizedBox(height: 5.h),


                  if ((profile.profileUser?.email ?? '').isNotEmpty)
                    Text(
                      profile.profileUser?.email ?? '',
                      style: TextStyle(
                        fontFamily: 'Rubik',
                        fontSize: 14,
                        color: grayColor,
                      ),
                    ),

                  const SizedBox(height: 4),


                  Text(
                    profile.profileUser?.phone ?? '',
                    style: TextStyle(
                      fontFamily: 'Rubik',
                      fontSize: 14,
                      color: grayColor,
                    ),
                  ),

                  const SizedBox(height: 30),


                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ProfileCard(
                        page: false,
                        topic: 'opening_balance'.tr,
                        amount:
                        '${Get.find<GlobalController>().currency}${profile.profileMerchant?.openingBalance ?? 0}',
                        imgUrl: Images.logo,
                        cardColor: kSecondaryColor,
                      ),
                      const SizedBox(width: 16),
                      ProfileCard(
                        page: true,
                        topic: '${"vat".tr}%',
                        amount:
                        '${Get.find<GlobalController>().currency}${profile.profileMerchant?.vat ?? 0}',
                        imgUrl: Images.logo,
                        cardColor: kMainColor,
                      ),
                    ],
                  ),

                  const SizedBox(height: 30),


                  ButtonGlobal(
                    buttontext: 'Check Balance ➤'.tr,
                    buttonDecoration: kButtonDecoration.copyWith(
                      color: Colors.deepOrangeAccent.shade200,
                    ),
                    onPressed: () {
                      const BalanceDetails().launch(context);
                    },
                  ),

                  const SizedBox(height: 30),


                  profileItem(EditProfileView(), Images.iconEditProfile,
                      "edit_profile".tr),
                  profileItem(ChangePasswordView(),
                      Images.iconChangePass, "change_password".tr),
                  profileItem(ChangeLanguageView(),
                      Images.iconChangeLang, "change_language".tr),

                  const SizedBox(height: 14),

                  InkWell(
                    onTap: () =>
                        Get.find<GlobalController>().userLogout(),
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          Images.iconLogout,
                          height: 16.h,
                          width: 16.w,
                        ),
                        const SizedBox(width: 16),
                        Text("log_out".tr, style: fontProfile),
                      ],
                    ),
                  ),

                  const SizedBox(height: 80),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }


  InkWell profileItem(route, icon, textValue) {
    return InkWell(
      onTap: () => Get.to(route),
      child: Column(
        children: [
          const SizedBox(height: 10),
          Row(
            children: [
              SvgPicture.asset(icon, height: 18, width: 18),
              const SizedBox(width: 16),
              Text(textValue, style: fontProfile),
            ],
          ),
          const SizedBox(height: 14),
          const Divider(thickness: 1, endIndent: 10, color: dividerColor),
        ],
      ),
    );
  }
}
