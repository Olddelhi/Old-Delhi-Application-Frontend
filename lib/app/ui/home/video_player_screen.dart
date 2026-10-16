import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:story_view/controller/story_controller.dart';
import 'package:story_view/utils.dart';
import 'package:story_view/widgets/story_view.dart';
import 'package:video_player/video_player.dart';
import '../../components/cutom_text.dart';
import '../../components/text_styles.dart';
import '../../utils/app_assets.dart';
import '../../utils/app_size.dart';

class FullScreenVideoScreen extends StatefulWidget {
  final String videoUrl;
  final String description;
  final String name;
  final dynamic thumbnailImage;

  const FullScreenVideoScreen(
      {super.key,
      required this.videoUrl,
      required this.description,
      required this.name,
      required this.thumbnailImage});

  @override
  State<FullScreenVideoScreen> createState() => _FullScreenVideoScreenState();
}

class _FullScreenVideoScreenState extends State<FullScreenVideoScreen> {
  late VideoPlayerController _controller;
  final controller = StoryController();
  bool isVideo = false;

  // @override
  // void initState() {
  //   super.initState();
  //   _controller = VideoPlayerController.networkUrl(
  //     Uri.parse(widget.videoUrl),
  //   )..initialize().then((_) {
  //       _controller.setLooping(true);
  //       setState(() {
  //         // Start playing the video when it's initialized
  //         _controller.play();
  //       });
  //     });
  //   _controller.addListener(() {
  //     if (_controller.value.isPlaying) {
  //       print('video playing');
  //       // Video is playing
  //     } else if (_controller.value.isCompleted) {
  //       print('video endded');
  //       // Video has ended
  //       // Get.back(); // Close the screen
  //     }
  //   });
  // }
  //
  // @override
  // void dispose() {
  //   _controller.dispose();
  //   super.dispose();
  // }
  @override
  void initState() {
    super.initState();
    isVideo = widget.videoUrl.endsWith('.mp4') ||
        widget.videoUrl.endsWith('.mov'); // Check if URL is a video

    if (isVideo) {
      _controller = VideoPlayerController.network(widget.videoUrl)
        ..initialize().then((_) {
          _controller.setLooping(true);
          setState(() {
            _controller.play();
          });
        });

      _controller.addListener(() {
        if (_controller.value.isPlaying) {
          print('Video is playing');
        } else if (_controller.value.isCompleted) {
          print('Video ended');
        }
      });
    }
  }

  @override
  void dispose() {
    if (isVideo) {
      _controller.pause(); // Stop the video before disposing
      _controller.dispose();
    }
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<StoryItem> storyItems = [
      // StoryItem.text(title: 'dddd', backgroundColor:Colors.black ),
      // StoryItem.inlineImage( url: 'https://image.ibb.co/cU4WGx/Omotuo-Groundnut-Soup-braperucci-com-1.jpg', controller: controller),
      // StoryItem.inlineImage(url: '', controller: controller),
      StoryItem.pageVideo(
        widget.videoUrl,
        controller: controller,
      ),
    ];
    return Scaffold(
      backgroundColor: Colors.grey,
      body: Stack(children: <Widget>[
        if (isVideo)
          StoryView(
            controller: controller,
            // pass controller here too
            // repeat: true, // should the stories be slid forever
            // onStoryShow: (s) {notifyServer(s)},
            onComplete: () {},
            onVerticalSwipeComplete: (direction) {
              if (direction == Direction.down) {
                Navigator.pop(context);
              }
            },
            storyItems:
                storyItems, // To disable vertical swipe gestures, ignore this parameter.
            // Preferrably for inline story view.
          )
        else
          Center(
            child: Image.network(
              widget.videoUrl,
              fit: BoxFit.cover,
            ),
          ),
        Container(
          padding: const EdgeInsets.only(
            top: 70,
            left: 16,
            right: 16,
          ),
          child: _buildProfileView(context),
        ),
        Positioned(
            bottom: 10,
            left: 0,
            right: 0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomText(
                  text: widget.description,
                  color: Colors.white,
                  fontSize: AppSize.font18,
                  textStyle: TextStyles.regularText,
                  textAlign: TextAlign.center,
                ),
              ],
            ))
      ]),
    );

    //   Scaffold(
    //   body: SafeArea(
    //     child: Padding(
    //       padding: const EdgeInsets.all(8.0),
    //       child: SizedBox(
    //         height: Get.size.height * 1.5,
    //         child: Column(
    //           children: [
    //             _appBar(),
    //             // controller.showLoader.value==true? const CircularProgressIndicator():  _foodDetails(),
    //             _foodDetails(),
    //             Expanded(child: SizedBox()),
    //             Divider(
    //               color: Colors.red,
    //             ),
    //             SizedBox(
    //               height: AppSize.height10,
    //             ),
    //             Image.asset(
    //               AppAssets.homeFooter,
    //               width: Get.width,
    //             ),
    //           ],
    //         ),
    //       ),
    //     ),
    //   ),
    // );
  }

  Widget _buildProfileView(context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Column(
          children: [
            const SizedBox(
              height: 8,
            ),
            InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
            ),
          ],
        ),
        const SizedBox(
          width: 5,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.red, width: 2)),
                child: Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2)),
                    child: ClipOval(
                        child: widget.thumbnailImage == AppAssets.logoIcon ||
                                !isVideo
                            ? Image.asset(AppAssets.logoIcon)
                            : Image.file(
                                widget.thumbnailImage,
                                fit: BoxFit.cover,
                              )))),
            // CircleAvatar(
            //   radius: 24,
            //   backgroundImage: NetworkImage(
            //       "https://avatars2.githubusercontent.com/u/5024388?s=460&u=d260850b9267cf89188499695f8bcf71e743f8a7&v=4"),
            // ),
            const SizedBox(
              width: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  CustomText(
                    text: widget.name.toUpperCase(),
                    textStyle: TextStyles.boldText,
                    color: Colors.white,
                    fontSize: AppSize.font13,
                    maxLine: 1,
                  ),
                  // Text(
                  //   "Today,12 PM",
                  //   style: TextStyle(
                  //     color: Colors.white,fontSize: 12,
                  //   ),
                  // )
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _appBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: Image.asset(
                  AppAssets.backIcon,
                  height: AppSize.height50,
                  width: AppSize.width50,
                )),
            Image.asset(
              AppAssets.logoIcon,
              height: AppSize.height50,
              width: AppSize.width50,
            ),
          ],
        ),
        //   ],
        // ),
      ],
    );
  }

  Widget _foodDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.2), // Shadow color
                spreadRadius: 2, // How much the shadow should spread
                blurRadius: 5, // How blurry the shadow should be
                offset: const Offset(0, 5), // Shadow offset
              ),
            ],
          ),
          child: Center(
            child: AspectRatio(
              aspectRatio: 2.3,
              child: VideoPlayer(_controller),
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Center(
          child: Container(
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(
                  Radius.circular(30),
                ),
                border: Border.all(color: Colors.red)),
            child: CustomText(
              text: widget.name.toUpperCase(),
              textStyle: TextStyles.boldText,
              color: Colors.black,
              fontSize: AppSize.font13,
              maxLine: 2,
            ).paddingSymmetric(
                horizontal: AppSize.width10, vertical: AppSize.height8),
          ),
        ),
        CustomText(
          text: widget.description,
          color: Colors.black54,
          fontSize: AppSize.font18,
          textStyle: TextStyles.regularText,
          textAlign: TextAlign.center,
        ).paddingSymmetric(
            vertical: AppSize.height24, horizontal: AppSize.width10),
      ],
    ).paddingOnly(top: AppSize.height15);
  }

//   return Scaffold(
//     backgroundColor: Colors.black,
//     body: Center(
//       child: AspectRatio(
//         aspectRatio: _controller.value.aspectRatio,
//         child: VideoPlayer(_controller),
//       ),
//     ),
//   );
// }
}
