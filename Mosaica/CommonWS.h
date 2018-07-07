#import <Foundation/Foundation.h>
#import "Mosaica.pch"
@interface CommonWS : NSObject
{
}
@property (nonatomic, readwrite) NSString *SettingID;
@property (nonatomic, readwrite) NSMutableDictionary *RegisterDic;

+(void)Getmethod :(NSString *)StrUrl withCompletion:(void(^)(NSDictionary*response,BOOL success1))completion;
+(void)AAwebserviceWithURL:(NSString*)strUrl withParam:(NSDictionary*)dictParam withCompletion:(void(^)(NSDictionary*response,BOOL success1))completion;
+(CommonWS*)sharedInstance;
+(void)GetmethodForAuthorisationTocken :(NSString *)StrUrl withCompletion:(void(^)(NSDictionary*response,BOOL success1))completion;
+(void)DeteteAuthorisationTocken :(NSString *)StrUrl withCompletion:(void(^)(NSDictionary*response,BOOL success1))completion;
+(void)PUTAuthorisationTocken :(NSString*)strUrl withParam:(id)dictParam withCompletion:(void(^)(NSDictionary*response,BOOL success1))completion;
+ (void)DeletewithParamPass:(NSString*)strUrl withParam:(NSDictionary*)dictParam withCompletion:(void(^)(NSDictionary*response,BOOL success1))completion
;
@end
