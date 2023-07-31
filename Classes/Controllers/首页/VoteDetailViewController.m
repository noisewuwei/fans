//
//  VoteDetailViewController.m
//  Fans
//
//  Created by 吴畏 on 2018/9/3.
//  Copyright © 2018年 吴畏. All rights reserved.
//

#import "VoteDetailViewController.h"

@interface VoteDetailViewController ()<UIWebViewDelegate>{
    UIWebView *webview;
}

@end

@implementation VoteDetailViewController

- (void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = NO;
    
    NSDictionary *dic = [ZJStoreDefaults getObjectForKey:@"userinfo"];
    
    NSString *url = [NSString stringWithFormat:@"http://192.168.0.106:8888/app3.html?voteId=%@&token=%@",_str,[dic objectForKey:@"token"]];
    
    NSLog(@"%@",url);
    
    NSURL *weburl = [NSURL URLWithString:url];
    
    NSURLRequest *request =[NSURLRequest requestWithURL:weburl];
    
    [webview loadRequest:request];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"详细内容";
    
    [self createBarLeftWithImage:@"iconback"];
    
    webview = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, zScreenWidth, zScreenHeight)];
    
    webview.delegate = self;
    
    [self.view addSubview:webview];
    
    // Do any additional setup after loading the view.
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    //核心方法如下
    JSContext *content = [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    //此处的getMessage和JS方法中的getMessage名称一致.
    
    content[@"getSupport"] = ^() {
        
        NSLog(@"getsupport");
        
    };
    
    content[@"getMore"] = ^() {
        
        NSLog(@"getmore");
        
    };
    
    //    content[@"getMessage"] = ^() {
    //
    //        NSLog(@"hahahahahah");
    //
    //        NSArray *arguments = [JSContext currentArguments];
    //        for (JSValue *jsValue in arguments) {
    //            NSLog(@"=======%@",jsValue);
    //        }
    //    };
    
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
