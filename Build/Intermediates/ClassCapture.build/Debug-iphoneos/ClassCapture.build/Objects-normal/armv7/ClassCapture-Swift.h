// Generated by Apple Swift version 2.1.1 (swiftlang-700.1.101.15 clang-700.1.81)
#pragma clang diagnostic push

#if defined(__has_include) && __has_include(<swift/objc-prologue.h>)
# include <swift/objc-prologue.h>
#endif

#pragma clang diagnostic ignored "-Wauto-import"
#include <objc/NSObject.h>
#include <stdint.h>
#include <stddef.h>
#include <stdbool.h>

#if defined(__has_include) && __has_include(<uchar.h>)
# include <uchar.h>
#elif !defined(__cplusplus) || __cplusplus < 201103L
typedef uint_least16_t char16_t;
typedef uint_least32_t char32_t;
#endif

typedef struct _NSZone NSZone;

#if !defined(SWIFT_PASTE)
# define SWIFT_PASTE_HELPER(x, y) x##y
# define SWIFT_PASTE(x, y) SWIFT_PASTE_HELPER(x, y)
#endif
#if !defined(SWIFT_METATYPE)
# define SWIFT_METATYPE(X) Class
#endif

#if defined(__has_attribute) && __has_attribute(objc_runtime_name)
# define SWIFT_RUNTIME_NAME(X) __attribute__((objc_runtime_name(X)))
#else
# define SWIFT_RUNTIME_NAME(X)
#endif
#if defined(__has_attribute) && __has_attribute(swift_name)
# define SWIFT_COMPILE_NAME(X) __attribute__((swift_name(X)))
#else
# define SWIFT_COMPILE_NAME(X)
#endif
#if !defined(SWIFT_CLASS_EXTRA)
# define SWIFT_CLASS_EXTRA
#endif
#if !defined(SWIFT_PROTOCOL_EXTRA)
# define SWIFT_PROTOCOL_EXTRA
#endif
#if !defined(SWIFT_ENUM_EXTRA)
# define SWIFT_ENUM_EXTRA
#endif
#if !defined(SWIFT_CLASS)
# if defined(__has_attribute) && __has_attribute(objc_subclassing_restricted) 
#  define SWIFT_CLASS(SWIFT_NAME) SWIFT_RUNTIME_NAME(SWIFT_NAME) __attribute__((objc_subclassing_restricted)) SWIFT_CLASS_EXTRA
#  define SWIFT_CLASS_NAMED(SWIFT_NAME) __attribute__((objc_subclassing_restricted)) SWIFT_COMPILE_NAME(SWIFT_NAME) SWIFT_CLASS_EXTRA
# else
#  define SWIFT_CLASS(SWIFT_NAME) SWIFT_RUNTIME_NAME(SWIFT_NAME) SWIFT_CLASS_EXTRA
#  define SWIFT_CLASS_NAMED(SWIFT_NAME) SWIFT_COMPILE_NAME(SWIFT_NAME) SWIFT_CLASS_EXTRA
# endif
#endif

#if !defined(SWIFT_PROTOCOL)
# define SWIFT_PROTOCOL(SWIFT_NAME) SWIFT_RUNTIME_NAME(SWIFT_NAME) SWIFT_PROTOCOL_EXTRA
# define SWIFT_PROTOCOL_NAMED(SWIFT_NAME) SWIFT_COMPILE_NAME(SWIFT_NAME) SWIFT_PROTOCOL_EXTRA
#endif

#if !defined(SWIFT_EXTENSION)
# define SWIFT_EXTENSION(M) SWIFT_PASTE(M##_Swift_, __LINE__)
#endif

#if !defined(OBJC_DESIGNATED_INITIALIZER)
# if defined(__has_attribute) && __has_attribute(objc_designated_initializer)
#  define OBJC_DESIGNATED_INITIALIZER __attribute__((objc_designated_initializer))
# else
#  define OBJC_DESIGNATED_INITIALIZER
# endif
#endif
#if !defined(SWIFT_ENUM)
# define SWIFT_ENUM(_type, _name) enum _name : _type _name; enum SWIFT_ENUM_EXTRA _name : _type
#endif
typedef float swift_float2  __attribute__((__ext_vector_type__(2)));
typedef float swift_float3  __attribute__((__ext_vector_type__(3)));
typedef float swift_float4  __attribute__((__ext_vector_type__(4)));
typedef double swift_double2  __attribute__((__ext_vector_type__(2)));
typedef double swift_double3  __attribute__((__ext_vector_type__(3)));
typedef double swift_double4  __attribute__((__ext_vector_type__(4)));
typedef int swift_int2  __attribute__((__ext_vector_type__(2)));
typedef int swift_int3  __attribute__((__ext_vector_type__(3)));
typedef int swift_int4  __attribute__((__ext_vector_type__(4)));
#if defined(__has_feature) && __has_feature(modules)
@import UIKit;
@import RealmSwift;
@import ObjectiveC;
@import CoreGraphics;
#endif

#pragma clang diagnostic ignored "-Wproperty-attribute-mismatch"
#pragma clang diagnostic ignored "-Wduplicate-method-arg"
@class UIWindow;
@class UIApplication;
@class NSObject;
@class NSURL;

SWIFT_CLASS("_TtC12ClassCapture11AppDelegate")
@interface AppDelegate : UIResponder <UIApplicationDelegate>
@property (nonatomic, strong) UIWindow * __nullable window;
- (BOOL)application:(UIApplication * __nonnull)application didFinishLaunchingWithOptions:(NSDictionary * __nullable)launchOptions;
- (void)applicationWillResignActive:(UIApplication * __nonnull)application;
- (void)applicationDidEnterBackground:(UIApplication * __nonnull)application;
- (void)applicationWillEnterForeground:(UIApplication * __nonnull)application;
- (void)applicationDidBecomeActive:(UIApplication * __nonnull)application;
- (void)applicationWillTerminate:(UIApplication * __nonnull)application;
@property (nonatomic, strong) NSURL * __nonnull applicationDocumentsDirectory;
- (nonnull instancetype)init OBJC_DESIGNATED_INITIALIZER;
@end

@class UIBarButtonItem;
@class UIButton;
@class UIImagePickerController;
@class NSBundle;
@class NSCoder;

SWIFT_CLASS("_TtC12ClassCapture9CaptureVC")
@interface CaptureVC : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (nonatomic, strong) IBOutlet UIBarButtonItem * __null_unspecified menuButton;
@property (nonatomic, strong) IBOutlet UIButton * __null_unspecified cameraButton;
@property (nonatomic, strong) IBOutlet UIButton * __null_unspecified photoLibraryButton;
@property (nonatomic, strong) UIImagePickerController * __nonnull imagePicker;
- (void)viewDidLoad;
- (void)didReceiveMemoryWarning;
- (IBAction)cameraButtonTapped:(id __nonnull)sender;
- (IBAction)photoLibraryButtonTapped:(id __nonnull)sender;
- (IBAction)menuButtonTapped:(id __nonnull)sender;
- (void)imagePickerController:(UIImagePickerController * __nonnull)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *, id> * __nonnull)info;
- (nonnull instancetype)initWithNibName:(NSString * __nullable)nibNameOrNil bundle:(NSBundle * __nullable)nibBundleOrNil OBJC_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithCoder:(NSCoder * __nonnull)aDecoder OBJC_DESIGNATED_INITIALIZER;
@end

@class RLMRealm;
@class RLMObjectSchema;
@class RLMSchema;

SWIFT_CLASS("_TtC12ClassCapture6Course")
@interface Course : RealmSwiftObject
@property (nonatomic, copy) NSString * __nullable courseID;
@property (nonatomic, copy) NSString * __nullable department;
@property (nonatomic, copy) NSString * __nullable number;
- (nonnull instancetype)init OBJC_DESIGNATED_INITIALIZER;
- (nonnull instancetype)initWithValue:(id __nonnull)value OBJC_DESIGNATED_INITIALIZER;
- (nonnull instancetype)initWithRealm:(RLMRealm * __nonnull)realm schema:(RLMObjectSchema * __nonnull)schema OBJC_DESIGNATED_INITIALIZER;
- (nonnull instancetype)initWithValue:(id __nonnull)value schema:(RLMSchema * __nonnull)schema OBJC_DESIGNATED_INITIALIZER;
@end


SWIFT_CLASS("_TtC12ClassCapture22CoursesServiceProvider")
@interface CoursesServiceProvider : NSObject
- (nonnull instancetype)init OBJC_DESIGNATED_INITIALIZER;
@end


SWIFT_CLASS("_TtC12ClassCapture13DataValidator")
@interface DataValidator : NSObject
- (BOOL)isValidEmail:(NSString * __nonnull)str;
@property (nonatomic, readonly) NSInteger kMIN_PASSWORD_LENGTH;
- (BOOL)isValidPassword:(NSString * __nonnull)str;
@property (nonatomic, readonly) NSInteger kMIN_FIRST_NAME_LENGTH;
- (BOOL)isValidFirstName:(NSString * __nonnull)str;
@property (nonatomic, readonly) NSInteger kMIN_LAST_NAME_LENGTH;
- (BOOL)isValidLastName:(NSString * __nonnull)str;
- (nonnull instancetype)init OBJC_DESIGNATED_INITIALIZER;
@end

@class RecordingsServiceProvider;
@class UsersServiceProvider;

SWIFT_CLASS("_TtC12ClassCapture5Model")
@interface Model : NSObject
@property (nonatomic, readonly, strong) RecordingsServiceProvider * __nonnull recordingsServiceProvider;
@property (nonatomic, readonly, strong) CoursesServiceProvider * __nonnull coursesServiceProvider;
@property (nonatomic, readonly, strong) UsersServiceProvider * __nonnull usersServiceProvider;
@property (nonatomic, readonly, strong) DataValidator * __nonnull dataValidator;
- (nonnull instancetype)init OBJC_DESIGNATED_INITIALIZER;
@end

@class NSDate;

SWIFT_CLASS("_TtC12ClassCapture9Recording")
@interface Recording : RealmSwiftObject
@property (nonatomic, copy) NSString * __nullable recordingID;
@property (nonatomic, copy) NSString * __nullable fileName;
@property (nonatomic, copy) NSString * __nullable section;
@property (nonatomic, strong) NSDate * __nullable startTime;
@property (nonatomic, strong) NSDate * __nullable endTime;
@property (nonatomic, strong) NSDate * __nullable dateCreated;
@property (nonatomic, strong) NSDate * __nullable dateLastModified;
- (nonnull instancetype)init OBJC_DESIGNATED_INITIALIZER;
- (nonnull instancetype)initWithValue:(id __nonnull)value OBJC_DESIGNATED_INITIALIZER;
- (nonnull instancetype)initWithRealm:(RLMRealm * __nonnull)realm schema:(RLMObjectSchema * __nonnull)schema OBJC_DESIGNATED_INITIALIZER;
- (nonnull instancetype)initWithValue:(id __nonnull)value schema:(RLMSchema * __nonnull)schema OBJC_DESIGNATED_INITIALIZER;
@end

@class NSManagedObjectContext;

SWIFT_CLASS("_TtC12ClassCapture25RecordingsServiceProvider")
@interface RecordingsServiceProvider : NSObject
- (void)postRecording:(NSManagedObjectContext * __nonnull)context completionHandler:(void (^ __nonnull)(BOOL))completionHandler;
- (nonnull instancetype)init OBJC_DESIGNATED_INITIALIZER;
@end


SWIFT_CLASS("_TtC12ClassCapture7Section")
@interface Section : RealmSwiftObject
@property (nonatomic, copy) NSString * __nullable sectionID;
@property (nonatomic, copy) NSString * __nullable name;
@property (nonatomic, strong) NSDate * __nullable startTime;
@property (nonatomic, strong) NSDate * __nullable endTime;
@property (nonatomic, strong) Course * __nullable course;
- (nonnull instancetype)init OBJC_DESIGNATED_INITIALIZER;
- (nonnull instancetype)initWithValue:(id __nonnull)value OBJC_DESIGNATED_INITIALIZER;
- (nonnull instancetype)initWithRealm:(RLMRealm * __nonnull)realm schema:(RLMObjectSchema * __nonnull)schema OBJC_DESIGNATED_INITIALIZER;
- (nonnull instancetype)initWithValue:(id __nonnull)value schema:(RLMSchema * __nonnull)schema OBJC_DESIGNATED_INITIALIZER;
@end

@class UITableView;
@class NSIndexPath;
@class UITableViewCell;

SWIFT_CLASS("_TtC12ClassCapture10SettingsVC")
@interface SettingsVC : UITableViewController
@property (nonatomic, strong) IBOutlet UIBarButtonItem * __null_unspecified menuButton;
- (void)viewDidLoad;
- (void)didReceiveMemoryWarning;
- (NSInteger)numberOfSectionsInTableView:(UITableView * __nonnull)tableView;
- (NSInteger)tableView:(UITableView * __nonnull)tableView numberOfRowsInSection:(NSInteger)section;
- (UITableViewCell * __nonnull)tableView:(UITableView * __nonnull)tableView cellForRowAtIndexPath:(NSIndexPath * __nonnull)indexPath;
- (IBAction)menuButtonTapped:(id __nonnull)sender;
- (nonnull instancetype)initWithStyle:(UITableViewStyle)style OBJC_DESIGNATED_INITIALIZER;
- (nonnull instancetype)initWithNibName:(NSString * __nullable)nibNameOrNil bundle:(NSBundle * __nullable)nibBundleOrNil OBJC_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithCoder:(NSCoder * __nonnull)aDecoder OBJC_DESIGNATED_INITIALIZER;
@end


SWIFT_CLASS("_TtC12ClassCapture16SideDrawerMenuVC")
@interface SideDrawerMenuVC : UITableViewController
- (void)viewDidLoad;
- (void)didReceiveMemoryWarning;
- (NSInteger)numberOfSectionsInTableView:(UITableView * __nonnull)tableView;
- (NSInteger)tableView:(UITableView * __nonnull)tableView numberOfRowsInSection:(NSInteger)section;
- (UITableViewCell * __nonnull)tableView:(UITableView * __nonnull)tableView cellForRowAtIndexPath:(NSIndexPath * __nonnull)indexPath;
- (void)tableView:(UITableView * __nonnull)tableView didSelectRowAtIndexPath:(NSIndexPath * __nonnull)indexPath;
- (nonnull instancetype)initWithStyle:(UITableViewStyle)style OBJC_DESIGNATED_INITIALIZER;
- (nonnull instancetype)initWithNibName:(NSString * __nullable)nibNameOrNil bundle:(NSBundle * __nullable)nibBundleOrNil OBJC_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithCoder:(NSCoder * __nonnull)aDecoder OBJC_DESIGNATED_INITIALIZER;
@end

@class UILabel;
@class UITextField;
@class UIPanGestureRecognizer;

SWIFT_CLASS("_TtC12ClassCapture8SignUpVC")
@interface SignUpVC : UIViewController
@property (nonatomic, strong) Model * __nullable model;
@property (nonatomic, strong) IBOutlet UILabel * __null_unspecified welcomeLabel;
@property (nonatomic, strong) IBOutlet UIButton * __null_unspecified signUpButton;
@property (nonatomic, strong) IBOutlet UIButton * __null_unspecified existingUserButton;
@property (nonatomic, strong) IBOutlet UILabel * __null_unspecified firstNameLabel;
@property (nonatomic, strong) IBOutlet UITextField * __null_unspecified firstNameTextField;
@property (nonatomic, strong) IBOutlet UILabel * __null_unspecified lastNameLabel;
@property (nonatomic, strong) IBOutlet UITextField * __null_unspecified lastNameTextField;
@property (nonatomic, strong) IBOutlet UILabel * __null_unspecified emailLabel;
@property (nonatomic, strong) IBOutlet UITextField * __null_unspecified emailTextField;
@property (nonatomic, strong) IBOutlet UILabel * __null_unspecified passwordLabel;
@property (nonatomic, strong) IBOutlet UITextField * __null_unspecified passwordTextField;
- (void)viewDidLoad;
- (BOOL)isSignUpDataValid;
- (void)didReceiveMemoryWarning;
- (IBAction)panGestureRecognized:(UIPanGestureRecognizer * __nonnull)recognizer;
- (IBAction)signUpButtonTapped:(id __nonnull)sender;
- (IBAction)existingUserButtonTapped:(id __nonnull)sender;
- (nonnull instancetype)initWithNibName:(NSString * __nullable)nibNameOrNil bundle:(NSBundle * __nullable)nibBundleOrNil OBJC_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithCoder:(NSCoder * __nonnull)aDecoder OBJC_DESIGNATED_INITIALIZER;
@end

@class UIPickerView;

SWIFT_CLASS("_TtC12ClassCapture17UploadRecordingVC")
@interface UploadRecordingVC : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource>
@property (nonatomic, strong) IBOutlet UILabel * __null_unspecified descriptionLabel;
@property (nonatomic, strong) IBOutlet UILabel * __null_unspecified courseLabel;
@property (nonatomic, strong) IBOutlet UIButton * __null_unspecified selectCourseButton;
@property (nonatomic, strong) IBOutlet UILabel * __null_unspecified sectionLabel;
@property (nonatomic, strong) IBOutlet UIButton * __null_unspecified selectSectionButton;
@property (nonatomic, strong) IBOutlet UIPickerView * __null_unspecified pickerView;
- (void)viewDidLoad;
- (void)didReceiveMemoryWarning;
- (IBAction)selectCourseButtonTapped:(id __nonnull)sender;
- (IBAction)selectSectionButtonTapped:(id __nonnull)sender;
- (IBAction)panGestureRecognized:(UIPanGestureRecognizer * __nonnull)recognizer;
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView * __nonnull)pickerView;
- (NSInteger)pickerView:(UIPickerView * __nonnull)pickerView numberOfRowsInComponent:(NSInteger)component;
- (NSString * __nullable)pickerView:(UIPickerView * __nonnull)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component;
- (void)showPickerView;
- (void)hidePickerView;
- (void)pickerView:(UIPickerView * __nonnull)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component;
- (nonnull instancetype)initWithNibName:(NSString * __nullable)nibNameOrNil bundle:(NSBundle * __nullable)nibBundleOrNil OBJC_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithCoder:(NSCoder * __nonnull)aDecoder OBJC_DESIGNATED_INITIALIZER;
@end


SWIFT_CLASS("_TtC12ClassCapture4User")
@interface User : RealmSwiftObject
@property (nonatomic, copy) NSString * __nullable firstName;
@property (nonatomic, copy) NSString * __nullable lastName;
@property (nonatomic, copy) NSString * __nullable email;
@property (nonatomic, copy) NSString * __nullable password;
- (nonnull instancetype)init OBJC_DESIGNATED_INITIALIZER;
- (nonnull instancetype)initWithValue:(id __nonnull)value OBJC_DESIGNATED_INITIALIZER;
- (nonnull instancetype)initWithRealm:(RLMRealm * __nonnull)realm schema:(RLMObjectSchema * __nonnull)schema OBJC_DESIGNATED_INITIALIZER;
- (nonnull instancetype)initWithValue:(id __nonnull)value schema:(RLMSchema * __nonnull)schema OBJC_DESIGNATED_INITIALIZER;
@end


SWIFT_CLASS("_TtC12ClassCapture20UsersServiceProvider")
@interface UsersServiceProvider : NSObject
- (BOOL)isLocalUserLoggedIn;
- (User * __nullable)getLocalUser;
- (void)registerNewUser:(NSString * __nonnull)firstName lastName:(NSString * __nonnull)lastName email:(NSString * __nonnull)email password:(NSString * __nonnull)password completionHandler:(void (^ __nonnull)(BOOL))completionHandler;
- (nonnull instancetype)init OBJC_DESIGNATED_INITIALIZER;
@end

@class UIView;
@class NSLayoutConstraint;
@class UIStoryboardSegue;

SWIFT_CLASS("_TtC12ClassCapture14ViewController")
@interface ViewController : UIViewController
@property (nonatomic, strong) IBOutlet UIView * __null_unspecified backgroundTintView;
@property (nonatomic, strong) IBOutlet NSLayoutConstraint * __null_unspecified menuLeadingSpace;
@property (nonatomic, strong) IBOutlet UIView * __null_unspecified menuContainer;
@property (nonatomic, strong) IBOutlet UIView * __null_unspecified recordingsContainer;
@property (nonatomic, strong) IBOutlet UIView * __null_unspecified captureContainer;
@property (nonatomic, strong) IBOutlet UIView * __null_unspecified settingsContainer;
@property (nonatomic, strong) Model * __nonnull model;
@property (nonatomic, readonly) double MAX_MENU_ANIMATION_DURATION;
@property (nonatomic, readonly) CGFloat OPEN_MENU_LEADING_SPACE_TO_CONTAINER;
@property (nonatomic, readonly) CGFloat CLOSED_MENU_LEADING_SPACE_TO_CONTAINER;
@property (nonatomic, readonly) CGFloat OPEN_MENU_BLACK_TINT_VIEW_ALPHA;
- (void)viewDidLoad;
- (void)viewDidAppear:(BOOL)animated;
- (void)didReceiveMemoryWarning;
- (IBAction)panGestureRecognized:(UIPanGestureRecognizer * __nonnull)recognizer;
- (void)openMenuAnimationWithVelocity:(CGFloat)velocity;
- (void)closeMenuAnimationWithVelocity:(CGFloat)velocity;
- (void)prepareForSegue:(UIStoryboardSegue * __nonnull)segue sender:(id __nullable)sender;
- (void)menuButtonTapped;
- (nonnull instancetype)initWithNibName:(NSString * __nullable)nibNameOrNil bundle:(NSBundle * __nullable)nibBundleOrNil OBJC_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithCoder:(NSCoder * __nonnull)aDecoder OBJC_DESIGNATED_INITIALIZER;
@end

#pragma clang diagnostic pop