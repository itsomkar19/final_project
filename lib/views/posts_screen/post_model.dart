// Model for Post data
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class Post {
  final int credPoints;
  final String department;
  final String imageUrl;
  final bool isVerified;
  final String ownerId;
  final String ownerName;
  final String postText;
  final String postType;
  final Timestamp timestamp;
  final String verifiedBy;
  String documentId = '';

  Post({
    required this.credPoints,
    required this.department,
    required this.imageUrl,
    required this.isVerified,
    required this.ownerId,
    required this.ownerName,
    required this.postText,
    required this.postType,
    required this.timestamp,
    required this.verifiedBy,
  });

  factory Post.fromDocument(DocumentSnapshot doc) {
    return Post(
      credPoints: doc['credPoints'],
      department: doc['department'],
      imageUrl: doc['imageUrl'],
      isVerified: doc['isVerified'],
      ownerId: doc['ownerId'],
      ownerName: doc['ownerName'],
      postText: doc['postText'],
      postType: doc['postType'],
      timestamp: doc['timestamp'],
      verifiedBy: doc['verifiedBy'],
    );
  }
}

final postsProvider = StreamProvider<List<Post>>((ref) {
  final postsCollection =
      FirebaseFirestore.instance.collection('Sinhgad/users/posts');
  // Query posts and order by timestamp in descending order
  final query = postsCollection.orderBy('timestamp', descending: true);
  // final query = postsCollection.orderBy('timestamp', descending: true).where('ownerId', isEqualTo: 'PSVYR20');
  // final query = postsCollection.orderBy('timestamp', descending: true).where('ownerId', isEqualTo: ref.read(profileStateProvider).value!.id);
  return query.snapshots().map((snapshot) =>
      snapshot.docs.map((doc) => Post.fromDocument(doc)).toList());
});

// final personalPostsProvider = StreamProvider<List<Post>>((ref) {
//   final postsCollection =
//   FirebaseFirestore.instance.collection('Sinhgad/users/posts');
//   final ownerId = FirebaseAuth.instance.currentUser!.uid;
//   final query = postsCollection.orderBy('timestamp', descending: true).where('ownerId', isEqualTo: ownerId);
//   return query.snapshots().map((snapshot)
//   => snapshot.docs.map((doc) => Post.fromDocument(doc)).toList());
// });


final personalPostsProvider = StreamProvider<List<Post>>((ref) {
  final postsCollection = FirebaseFirestore.instance.collection('Sinhgad/users/posts');
  final ownerId = FirebaseAuth.instance.currentUser!.uid;
  print("Hello guys i am : $ownerId");
  final query = postsCollection.orderBy('timestamp', descending: true).where('ownerId', isEqualTo: ownerId);
  return query.snapshots().map((snapshot) {
    return snapshot.docs.map((doc) {
      // Create a Post object and include the document ID
      final post = Post.fromDocument(doc);
      post.documentId = doc.id;
      return post;
    }).toList();
  });
});