

#import "CommonWS.h"
@implementation CommonWS
@synthesize SettingID,RegisterDic;

+(CommonWS*)sharedInstance
{
    static CommonWS *sharedInstance_ = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        sharedInstance_ = [[CommonWS alloc] init];
    });
    
    return sharedInstance_;
}

+(void)PUTAuthorisationTocken :(NSString*)strUrl withParam:(id)dictParam withCompletion:(void(^)(NSDictionary*response,BOOL success1))completion
{
    NSString *Token=[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"];
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager.requestSerializer setValue:Token forHTTPHeaderField:@"authorization"];
    
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    [KVNProgress show] ;
    
    [manager PUT:strUrl parameters:dictParam success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         NSLog(@"success!");
         
         NSString *strRes=[[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
         NSData *data=[strRes dataUsingEncoding:NSUTF8StringEncoding];
         NSError *err;
         NSDictionary *parsedObject = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&err];
         [KVNProgress dismiss];
       //  NSLog(@"Response : %@",parsedObject);
         if (parsedObject==nil)
         {
             completion (parsedObject,NO);
         }
         else
         {
             if ([[parsedObject valueForKey:@"Message"] isEqualToString:@"Success"])
             {
                 completion (parsedObject,YES);
                 NSLog(@"Pass");
             }
             else
             {
                 completion (parsedObject, YES);
                 NSLog(@"Fail");
             }
         }
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
     {
         NSLog(@"error: %@", error);
         completion (nil,YES);
         [KVNProgress dismiss];
         NSLog(@"Inside Failure");
     }];
}


+(void)GetmethodForAuthorisationTocken :(NSString *)StrUrl withCompletion:(void(^)(NSDictionary*response,BOOL success1))completion
{
    NSDictionary *parameters = @{@"format": @"json"};
    NSString *Token=[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"];
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager.requestSerializer setValue:Token forHTTPHeaderField:@"authorization"];
    
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    [KVNProgress show];
    [manager GET:StrUrl parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         NSLog(@"success!");
         
         NSString *strRes=[[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
         NSData *data=[strRes dataUsingEncoding:NSUTF8StringEncoding];
         NSError *err;
         NSDictionary *parsedObject = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&err];
         [KVNProgress dismiss];
        // NSLog(@"Response : %@",parsedObject);
         if (parsedObject==nil)
         {
             completion (parsedObject,NO);
         }
         else
         {
             if ([[parsedObject valueForKey:@"Message"] isEqualToString:@"Success"])
             {
                 completion (parsedObject,YES);
                 NSLog(@"Pass");
             }
             else
             {
                 completion (parsedObject, YES);
                 NSLog(@"Fail");
             }
         }
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
     {
         NSLog(@"error: %@", error);
         completion (nil,YES);
         [KVNProgress dismiss];
         NSLog(@"Inside Failure");
     }];
}

+(void)Getmethod :(NSString *)StrUrl withCompletion:(void(^)(NSDictionary*response,BOOL success1))completion
{
    NSDictionary *parameters = @{@"format": @"json"};
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];

    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    [KVNProgress show];
    [manager GET:StrUrl parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
    {
        NSLog(@"success!");
        
        NSString *strRes=[[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSData *data=[strRes dataUsingEncoding:NSUTF8StringEncoding];
        NSError *err;
        NSDictionary *parsedObject = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&err];
        [KVNProgress dismiss];
     //   NSLog(@"Response : %@",parsedObject);
        if (parsedObject==nil)
        {
            completion (parsedObject,NO);
        }
        else
        {
            if ([[parsedObject valueForKey:@"Message"] isEqualToString:@"Success"])
            {
                completion (parsedObject,YES);
                NSLog(@"Pass");
            }
            else
            {
                completion (parsedObject, YES);
                NSLog(@"Fail");
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
    {
         NSLog(@"error: %@", error);
         completion (nil,YES);
         [KVNProgress dismiss];
         NSLog(@"Inside Failure");
     }];
}

+ (void)AAwebserviceWithURL:(NSString*)strUrl withParam:(NSDictionary*)dictParam withCompletion:(void(^)(NSDictionary*response,BOOL success1))completion
{
    NSString *Token=[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"];
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    [manager.requestSerializer setValue:Token forHTTPHeaderField:@"authorization"];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    [KVNProgress show];
    [manager POST:strUrl parameters:dictParam progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
    {
        NSLog(@"success!");
        NSString *strRes=[[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSData *data=[strRes dataUsingEncoding:NSUTF8StringEncoding];
        NSError *err;
        NSDictionary *parsedObject = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&err];
        [KVNProgress dismiss];
        NSLog(@"Response : %@",parsedObject);
        if (parsedObject==nil)
        {
            completion (parsedObject,NO);
        }
        else
        {
            if ([[parsedObject valueForKey:@"Message"] isEqualToString:@"Success"])
            {
                completion (parsedObject,YES);
                NSLog(@"Pass");
            }
            else
            {
                completion (parsedObject, YES);
                NSLog(@"Fail");
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
    {
        
        NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
        NSLog(@"Response statusCode: %li", (long)response.statusCode);
        
        
        
        NSData *errorData = error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey];
        NSDictionary *serializedData = [NSJSONSerialization JSONObjectWithData: errorData options:kNilOptions error:nil];
        completion (serializedData,NO);
        NSLog(@"error: %ld", (long)response.statusCode);
        
        NSLog(@"error: %@", error);
        completion (nil,YES);
        [KVNProgress dismiss];
        NSLog(@"Inside Failure");
    }];
}

+(void)DeteteAuthorisationTocken :(NSString *)StrUrl withCompletion:(void(^)(NSDictionary*response,BOOL success1))completion
{
    NSDictionary *parameters = @{@"format": @"json"};
    NSString *Token=[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"];
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager.requestSerializer setValue:Token forHTTPHeaderField:@"authorization"];
    
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    [KVNProgress show];
    
    
    [manager DELETE:StrUrl parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         NSLog(@"success!");
         
         NSString *strRes=[[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
         NSData *data=[strRes dataUsingEncoding:NSUTF8StringEncoding];
         NSError *err;
         NSDictionary *parsedObject = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&err];
         [KVNProgress dismiss];
         //  NSLog(@"Response : %@",parsedObject);
         if (parsedObject==nil)
         {
             completion (parsedObject,NO);
         }
         else
         {
             if ([[parsedObject valueForKey:@"Message"] isEqualToString:@"Success"])
             {
                 completion (parsedObject,YES);
                 NSLog(@"Pass");
             }
             else
             {
                 completion (parsedObject, YES);
                 NSLog(@"Fail");
             }
         }
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
     {
         NSLog(@"error: %@", error);
         completion (nil,YES);
         [KVNProgress dismiss];
         NSLog(@"Inside Failure");
     }];
}

+ (void)DeletewithParamPass:(NSString*)strUrl withParam:(NSDictionary*)dictParam withCompletion:(void(^)(NSDictionary*response,BOOL success1))completion
{
    NSString *Token=[[NSUserDefaults standardUserDefaults]objectForKey:@"Token"];
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager.requestSerializer setValue:Token forHTTPHeaderField:@"authorization"];
    
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    [KVNProgress show];
    
    
    [manager DELETE:strUrl parameters:dictParam success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         NSLog(@"success!");
         
         NSString *strRes=[[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
         NSData *data=[strRes dataUsingEncoding:NSUTF8StringEncoding];
         NSError *err;
         NSDictionary *parsedObject = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&err];
         [KVNProgress dismiss];
         //  NSLog(@"Response : %@",parsedObject);
         if (parsedObject==nil)
         {
             completion (parsedObject,NO);
         }
         else
         {
             if ([[parsedObject valueForKey:@"Message"] isEqualToString:@"Success"])
             {
                 completion (parsedObject,YES);
                 NSLog(@"Pass");
             }
             else
             {
                 completion (parsedObject, YES);
                 NSLog(@"Fail");
             }
         }
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
     {
         NSLog(@"error: %@", error);
         completion (nil,YES);
         [KVNProgress dismiss];
         NSLog(@"Inside Failure");
     }];}

@end
