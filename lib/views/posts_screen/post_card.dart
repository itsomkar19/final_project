import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:credbud/views/constants/app_colors.dart';
import 'package:credbud/views/posts_screen/pdf_viewer_screen.dart';
import 'package:credbud/views/posts_screen/post_model.dart';
import 'package:credbud/views/welcome_screen/divider_with_margins.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PostCard extends StatelessWidget {
  final Post data;
  final String urlEndsWith;
  const PostCard({super.key, required this.data, required this.urlEndsWith});

  String formatFirebaseTimestamp(Timestamp timestamp) {
    final DateFormat formatter =
        DateFormat('HH:mm, dd/MM/yyyy'); // Create formatter
    final DateTime dateTime =
        timestamp.toDate(); // Convert timestamp to DateTime
    final String formattedString =
        formatter.format(dateTime); // Format the date
    return formattedString;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    SizedBox(
                        height: 35,
                        width: 35,
                        child: Image.asset('assets/images/profile.png')),
                    const SizedBox(
                      width: 16,
                    ),
                    Text(
                      data.ownerName,
                      style: const TextStyle(fontSize: 18),
                    ),
                  ],
                ),
                GestureDetector(
                    onTap: () {
                      showDialog<String>(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                          title: const Text('Verification Status'),
                          content: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'Verified: ${data.isVerified}',
                              ),
                              Text('Verified by: ${data.verifiedBy}'),
                              Text('Department: ${data.department}'),
                              const Text(''),
                              Text('Owner Id: ${data.ownerId}'),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text('Earned: ${data.credPoints.toString()}'),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  SizedBox(
                                    height: 20,
                                    width: 20,
                                    child:
                                        Image.asset('assets/images/coin.png'),
                                  ),
                                ],
                              )
                            ],
                          ),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () => Navigator.pop(context, 'OK'),
                              child: const Text('OK'),
                            ),
                          ],
                        ),
                      );
                    },
                    child: const SizedBox(
                        height: 35,
                        width: 35,
                        child: Icon(
                          Icons.info,
                          color: AppColors.malibu,
                        )))
              ],
            ),
            const DividerWithMarginsPostCard(),
            urlEndsWith == '.jpg'
                ? PostCardImage(
                    imgUrl: data.imageUrl,
                  )
                : PostCardPdf(
                    pdfUrl: data.imageUrl,
                  ),
            const DividerWithMarginsPostCard(),
            Align(
                alignment: Alignment.topLeft,
                child: Text(
                  data.postText,
                  style: const TextStyle(fontSize: 16),
                )),
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                formatFirebaseTimestamp(data.timestamp),
                style: const TextStyle(color: Colors.black54),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class PostCardWithDelete extends StatelessWidget {
  final Post data;
  final String urlEndsWith;
  const PostCardWithDelete(
      {super.key, required this.data, required this.urlEndsWith});

  String formatFirebaseTimestamp(Timestamp timestamp) {
    final DateFormat formatter =
        DateFormat('HH:mm, dd/MM/yyyy'); // Create formatter
    final DateTime dateTime =
        timestamp.toDate(); // Convert timestamp to DateTime
    final String formattedString =
        formatter.format(dateTime); // Format the date
    return formattedString;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    SizedBox(
                        height: 35,
                        width: 35,
                        child: Image.asset('assets/images/profile.png')),
                    const SizedBox(
                      width: 16,
                    ),
                    Text(
                      data.ownerName,
                      style: const TextStyle(fontSize: 18),
                    ),
                  ],
                ),
                GestureDetector(
                    onTap: () {
                      showDialog<String>(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                          title: const Text('Verification Status'),
                          content: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'Verified: ${data.isVerified}',
                              ),
                              Text('Verified by: ${data.verifiedBy}'),
                              Text('Department: ${data.department}'),
                              const Text(''),
                              Text('Owner Id: ${data.ownerId}'),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text('Earned: ${data.credPoints.toString()}'),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  SizedBox(
                                    height: 20,
                                    width: 20,
                                    child:
                                        Image.asset('assets/images/coin.png'),
                                  ),
                                ],
                              )
                            ],
                          ),
                          actions: <Widget>[
                            data.isVerified == false
                                ? TextButton(
                                    onPressed: () async{
                                      // Navigator.pop(context, 'OK'),
                                      await FirebaseFirestore.instance.collection('Sinhgad/users/posts').doc(data.documentId).delete();
                                      Navigator.pop(context, 'Deleted Successfully');
                                    },
                                    child: const Text(' Delete Post'),
                                  )
                                : const SizedBox(),
                            TextButton(
                              onPressed: () => Navigator.pop(context, 'OK'),
                              child: const Text('OK'),
                            ),
                          ],
                        ),
                      );
                    },
                    child: const SizedBox(
                        height: 35,
                        width: 35,
                        child: Icon(
                          Icons.info,
                          color: AppColors.malibu,
                        )))
              ],
            ),
            const DividerWithMarginsPostCard(),
            urlEndsWith == '.jpg'
                ? PostCardImage(
                    imgUrl: data.imageUrl,
                  )
                : PostCardPdf(
                    pdfUrl: data.imageUrl,
                  ),
            const DividerWithMarginsPostCard(),
            Align(
                alignment: Alignment.topLeft,
                child: Text(
                  data.postText,
                  style: const TextStyle(fontSize: 16),
                )),
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                formatFirebaseTimestamp(data.timestamp),
                style: const TextStyle(color: Colors.black54),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class PostCardImage extends StatelessWidget {
  final String imgUrl;
  const PostCardImage({super.key, required this.imgUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
        // height: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18.0), // Adjust as needed
          color: Colors.transparent,
          border: Border.all(color: Colors.black, width: 0.5), // Black border
        ),
        constraints: BoxConstraints(
            maxHeight: 180.0,
            minWidth: MediaQuery.of(context).size.width,
            minHeight: 180),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(18.0), // Match container radius
          child: CachedNetworkImage(
            // height: 200,
            // width: MediaQuery.of(context).size.width,
            imageUrl: imgUrl,
            placeholder: (context, url) => const Icon(Icons.downloading),
            errorWidget: (context, url, error) => const Icon(Icons.error),
            fit: BoxFit.cover,
          ),
        ));
  }
}

class PostCardPdf extends StatelessWidget {
  final String pdfUrl;
  const PostCardPdf({super.key, required this.pdfUrl});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(18),
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (ctx) => PDFViewerScreen(pdfUrl: pdfUrl)));
      },
      child: Container(
          // height: 200,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18.0), // Adjust as needed
            color: AppColors.mauve.withAlpha(50),
            // color: AppColors.malibu.withAlpha(50),
            border: Border.all(color: Colors.black, width: 0.5), // Black border
          ),
          constraints: BoxConstraints(
              maxHeight: 180.0,
              minWidth: MediaQuery.of(context).size.width,
              minHeight: 180),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(18.0), // Match container radius
            child: const Center(
              child: Icon(
                Icons.picture_as_pdf,
                size: 80,
                color: Colors.red,
              ),
            ),
          )),
    );
  }
}

// Padding(
// padding: const EdgeInsets.fromLTRB(10,10,10,0),
// child: Card(
// shape: RoundedRectangleBorder(
// borderRadius: BorderRadius.circular(18.0),
// ),
// color: Colors.white,
// elevation: 01,
