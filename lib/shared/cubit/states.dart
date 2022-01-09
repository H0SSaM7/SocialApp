abstract class SocialStates {}

class SocialInitialState extends SocialStates {}

class SocialLoadingGetUserState extends SocialStates {}

class SocialSuccessGetUserState extends SocialStates {}

class SocialErrorGetUserState extends SocialStates {}

class SocialLoadingGetPostsState extends SocialStates {}

class SocialSuccessGetPostsState extends SocialStates {}

class SocialErrorGetPostsState extends SocialStates {}

class SocialChangeNavBarState extends SocialStates {}

class SocialPickImageState extends SocialStates {}

class SocialLoadingUploadProfileImageState extends SocialStates {}

class SocialSuccessUploadProfileImageState extends SocialStates {}

class SocialLoadingUploadPostImageState extends SocialStates {}

class SocialSuccessUploadPostImageState extends SocialStates {}

class SocialDeletePostImageState extends SocialStates {}

//upload new post.
class SocialLoadingCreateNewPostState extends SocialStates {}

class SocialSuccessCreateNewPostState extends SocialStates {}

class SocialErrorCreateNewPostState extends SocialStates {}

//like post
class SocialSuccessPostLikeState extends SocialStates {}

class SocialErrorPostLikeState extends SocialStates {}
