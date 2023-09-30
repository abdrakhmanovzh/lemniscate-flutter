import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lemniscate_flutter/core/utils/app_colors.dart';
import 'package:lemniscate_flutter/features/post/domain/entities/post_model.dart';
import 'package:lemniscate_flutter/features/post/presentation/cubit/post_cubit.dart';
import 'package:lemniscate_flutter/features/post/presentation/utils/get_formatted_date.dart';
import 'package:lemniscate_flutter/features/post/presentation/utils/get_formatted_name.dart';
import 'package:lemniscate_flutter/features/post/presentation/utils/get_post_image.dart';
import 'package:lemniscate_flutter/features/user/domain/entities/user_model.dart';
import 'package:lemniscate_flutter/features/user/presentation/utils/get_user_avatar.dart';

class PostCardWidget extends StatefulWidget {
  final PostModel post;
  final UserModel author;
  const PostCardWidget({super.key, required this.post, required this.author});

  @override
  State<PostCardWidget> createState() => _PostCardWidgetState();
}

class _PostCardWidgetState extends State<PostCardWidget> {
  bool isLiked = false;

  @override
  void initState() {
    isLiked = widget.post.likes.contains(widget.author.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.secondaryBlack,
        border: Border.all(
          color: AppColors.primaryGray,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 16,
                backgroundImage: NetworkImage(GetUserAvatar.getAvatar(widget.author.name)),
                backgroundColor: AppColors.neutralGray,
              ),
              const SizedBox(
                width: 12,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    GetFormattedName.getFormattedName(widget.author.name),
                    style: const TextStyle(
                      color: AppColors.primaryWhite,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    GetFormattedDate.getFormattedDate(widget.post.createdAt),
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppColors.neutralGray,
                    ),
                  )
                ],
              ),
              const Spacer(),
              InkWell(
                onTap: () {
                  setState(() {
                    isLiked = !isLiked;
                  });
                  BlocProvider.of<PostCubit>(context).likePost(widget.post.id!, widget.author.id);
                },
                splashColor: AppColors.neutralGray,
                child: isLiked
                    ? const Icon(
                        Icons.favorite,
                        size: 20,
                        color: AppColors.primaryRed,
                      )
                    : const Icon(
                        Icons.favorite_outline,
                        size: 20,
                        color: AppColors.primaryWhite,
                      ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            widget.post.text,
            style: const TextStyle(
              color: AppColors.primaryWhite,
              fontSize: 16,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                GetPostImage.getPostImage(widget.post.image),
                fit: BoxFit.cover,
              ),
            ),
          )
        ],
      ),
    );
  }
}
