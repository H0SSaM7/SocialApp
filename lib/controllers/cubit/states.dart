abstract class SocialStates {}

class SocialInitialState extends SocialStates {}

class SocialLoadingGetAllUsersState extends SocialStates {}

class SocialSuccessGetAllUsersState extends SocialStates {}

class SocialErrorGetAllUsersState extends SocialStates {}

class SocialLoadingGetUserByIdState extends SocialStates {}

class SocialSuccessGetUserByIdState extends SocialStates {}

class SocialErrorGetUserByIdState extends SocialStates {}

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

//chats
class SocialSuccessSendMessagesFromMeState extends SocialStates {}

class SocialErrorSendMessagesFromMeState extends SocialStates {}

class SocialSuccessSendMessagesToOtherState extends SocialStates {}

class SocialErrorSendMessagesToOtherState extends SocialStates {}

class SocialSuccessfullyReceivedMessage extends SocialStates {}
