import 'package:flutter/material.dart';
import 'package:lemniscate_flutter/core/utils/app_colors.dart';
import 'package:lemniscate_flutter/features/post/domain/entities/post_model.dart';
import 'package:lemniscate_flutter/features/post/presentation/utils/get_formatted_date.dart';
import 'package:lemniscate_flutter/features/post/presentation/utils/get_post_image.dart';
import 'package:lemniscate_flutter/features/user/domain/entities/user_model.dart';
import 'package:lemniscate_flutter/features/user/presentation/utils/get_user_avatar.dart';

class PostCardWidget extends StatelessWidget {
  final PostModel post;
  final UserModel author;
  const PostCardWidget({super.key, required this.post, required this.author});

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
                backgroundImage: NetworkImage(GetUserAvatar.getAvatar(author.name)),
              ),
              const SizedBox(
                width: 8,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    author.name,
                    style: const TextStyle(
                      color: AppColors.primaryWhite,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    GetFormattedDate.getFormattedDate(post.createdAt),
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppColors.neutralGray,
                    ),
                  )
                ],
              ),
              const Spacer(),
              GestureDetector(
                child: post.likes.contains(author.name)
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
            height: 6,
          ),
          Text(
            post.text,
            style: const TextStyle(color: AppColors.primaryWhite),
          ),
          const SizedBox(
            height: 6,
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                GetPostImage.getPostImage(post.image),
                fit: BoxFit.cover,
              ),
            ),
          )
        ],
      ),
    );
  }
}
