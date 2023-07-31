//
//  HTTPRequest.m
//  BusinessManage
//
//  Created by Jion on 15/8/7.
//  Copyright (c) 2015年 Youjuke. All rights reserved.
//

#import "HTTPRequest.h"
//线上线下只需修改if 1线上 if 0线下
//#ifdef DEBUG
//
//#if 0
//#define baseUrl   @"m.youjuke.com"
//#else
//#define baseUrl  @"prebk.youjuke.com"
//#endif
//
//#else
//#define baseUrl  @"m.youjuke.com"
//
//#endif

#define baseUrl  @"yingyuan.dui3.cn"
//192.168.0.126:8080
//39.108.11.98:8084
HTTPRequest *request;

@implementation HTTPRequest

static HTTPRequest *instance = nil;

+ (instancetype)shareIntance
{
    NSDictionary *dic = [ZJStoreDefaults getObjectForKey:@"userinfo"];
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
//        if ([ZJStoreDefaults getObjectForKey:@"userinfo"]) {
//            instance = [[HTTPRequest alloc]initWithHostName:baseUrl customHeaderFields:@{@"token":[dic objectForKey:@"token"]}];
//        }else{
//            instance = [[HTTPRequest alloc]initWithHostName:baseUrl];
//        }
        
    });
    return instance;
}
+(void)postWithURL:(NSString *)url method:(NSString *)str params:(NSDictionary*)params ProgressHUD:(MBProgressHUD*)HUD controller:(UIViewController*)vc response:(void(^)(id json))result error400Code:(void (^)(id failure))failureCode {
    [self postWithURL:url method:str params:params filePathAndKey:nil ProgressHUD:HUD controller:vc response:^(id json) {
        result(json);
    } error400Code:^(id failure) {
        failureCode(failure);
    }];
}

+(void)postWithURL:(NSString *)url method:(NSString *)str params:(NSDictionary*)params filePathAndKey:(NSDictionary*)pathKey ProgressHUD:(MBProgressHUD*)HUD controller:(UIViewController*)vc response:(void(^)(id json))result error400Code:(void (^)(id failure))failureCode {
//    NSDictionary *lastParam;
//    if (!url) {
//
//        lastParam = params;
//
//    }else{
//        url = [url stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
//        lastParam = params;
////        NSDictionary *inDictionary = params;
////        NSString *paramStr = [ZJStaticFunction getJsonStringByDictionary:inDictionary encoding:NSUTF8StringEncoding];
////        lastParam = @{@"json_msg":paramStr};
//    }
    
    //发送请求
    NSDictionary *dic = [ZJStoreDefaults getObjectForKey:@"userinfo"];
    if ([ZJStoreDefaults getObjectForKey:@"userinfo"]) {
        request = [[HTTPRequest alloc]initWithHostName:baseUrl customHeaderFields:@{@"token":[dic objectForKey:@"token"]}];
    }else{
        request = [[HTTPRequest alloc]initWithHostName:baseUrl];
    }
    //
    //    HTTPRequest *request = [HTTPRequest shareIntance];
    //Api/management_interface
    //    NSString *path = @"/yrycapi/user/login";
    MKNetworkOperation* operation=[request operationWithPath:url params: params httpMethod:str];
    
    [operation setFreezable:YES];
    
    NSArray *filePaths = [pathKey objectForKey:pathKey.allKeys.firstObject];
    
    for (id file in filePaths) {
        
        NSData *data = UIImageJPEGRepresentation(file, 0.3);
        
        [operation addData:data forKey:pathKey.allKeys.firstObject];
        
        //循环上传图片
        //        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        //        dispatch_async(queue, ^{
        //
        //
        //            //                   [operation addFile:filePath forKey:pathKey.allKeys.firstObject];
        //
        //        });
    }
    
    //    if (pathKey.allKeys.count == 1) {
    //
    //
    ////        if ([pathKey.allValues.firstObject isKindOfClass:[NSArray class]]) {
    ////
    ////
    ////        }else{
    //////            [operation addFile:pathKey.allValues.firstObject forKey:pathKey.allKeys.firstObject];
    //////            NSData *data = UIImageJPEGRepresentation(pathKey.allValues.firstObject, 0.3);
    //////            [operation addData:data forKey:pathKey.allKeys.firstObject];
    ////        }
    //
    //    }
    if (HUD) {
        //HUD需在主线程执行
        if ([NSThread isMainThread]) {
            [HUD show:YES];
        }else{
            dispatch_sync(dispatch_get_main_queue(), ^(){
                // 如果不是主线程 转到主线程执行
                [HUD show:YES];
            });
        }
        
    }

    [operation addCompletionHandler:^(MKNetworkOperation *response) {
        if (HUD) {
            [HUD hide:NO];
        }
        NSLog(@"%@",[response responseString]);
        id dataDictionary=[ZJStaticFunction getDictionaryByJsonString:[response responseString]];
        NSDictionary *dic = [dataDictionary objectForKey:@"head"];
        if ([ZJStaticFunction isCurrectResult:dic]){
            id data = [dataDictionary objectForKey:@"content"];
            result(data);
            
        }else{
            
            id message = [dataDictionary objectForKey:@"head"];
            if ([message isKindOfClass:[NSDictionary class]]) {
                NSLog(@"400===%@",[message valueForKey:@"message"]);
                if (vc) {
                    [ZJStaticFunction alertView:vc.view msg:[message valueForKey:@"message"]];
                }
                
            }else if ([message isKindOfClass:[NSString class]]){
                if (vc) {
                    [ZJStaticFunction alertView:vc.view msg:message];
                }
            }
            else{
                NSLog(@"400===%@",message);
            }
            failureCode(dataDictionary);
            
        }

        
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        if (HUD) {
             [HUD hide:NO];
        }
        if (vc) {
            for (id objc in vc.view.subviews) {
                if ([objc isKindOfClass:[UIScrollView class]]) {
                    [((UIScrollView*)objc).header endRefreshing];
                    [((UIScrollView*)objc).footer endRefreshing];
                }
            }
            
        }
        [ZJStaticFunction alertView:[[UIApplication sharedApplication] keyWindow] msg:kServerError];
        NSLog(@"%@ \n%@",completedOperation,error);
    }];
    
    [operation onUploadProgressChanged:^(double progress) {
         HUD.progress = progress;
    }];
    
    
    [request enqueueOperation:operation];
    
}
@end
