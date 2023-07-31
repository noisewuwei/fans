//
//  SearchResultViewController.m
//  Fans
//
//  Created by 吴畏 on 2018/7/3.
//  Copyright © 2018年 吴畏. All rights reserved.
//

#import "SearchResultViewController.h"
#import "ZXSegmentController.h"
#import "Masonry.h"
#import "ActivityViewController.h"
#import "FansTeamViewController.h"

@interface SearchResultViewController ()

@property (nonatomic,weak) ZXSegmentController* segmentController;

@end

@implementation SearchResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"搜索结果";
    [self createBarLeftWithImage:@"iconback"];
    
    ActivityViewController *VC1 = [[ActivityViewController alloc]init];
    FansTeamViewController *VC2 = [[FansTeamViewController alloc]init];
    
    NSArray* names = @[@"活动",@"粉丝团"];
    NSArray* controllers = @[VC1,VC2];
    
    //    NSArray* names = @[@"头条",@"视频",@"娱乐",@"体育"];
    //    NSArray* controllers = @[VC_1,VC_2,VC_3,VC_4];
    
    /*
     *   controllers长度和names长度必须一致，否则将会导致cash
     *   segmentController在一个屏幕里最多显示6个按钮，如果超过6个，将会自动开启滚动功能，如果不足6个，按钮宽度=父view宽度/x  (x=按钮个数)
     */
    ZXSegmentController* segmentController = [[ZXSegmentController alloc] initWithControllers:controllers
                                                                               withTitleNames:names
                                                                             withDefaultIndex:0
                                                                               withTitleColor:[UIColor colorHexString:@"777777"]
                                                                       withTitleSelectedColor:[UIColor colorHexString:@"383838"]
                                                                              withSliderColor:[UIColor colorHexString:@"383838"]];
    [self addChildViewController:(_segmentController = segmentController)];
    [self.view addSubview:segmentController.view];
    [segmentController didMoveToParentViewController:self];
    [self createAutolayout];
    
    
    
    // Do any additional setup after loading the view.
}

-(void)createBarLeftWithImage:(NSString *)imageName{
    
    if (imageName==nil) {
        return;
    }
    
    if ([imageName length]==0) {
        return;
    }
    
    UIButton *btnb = [UIButton buttonWithType : UIButtonTypeCustom];
    
    [btnb setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [btnb sizeToFit];
    
    // btnb.showsTouchWhenHighlighted=YES;
    [btnb addTarget:self action:@selector(showLeft:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *ubar=[[UIBarButtonItem alloc] initWithCustomView :btnb];
    self.navigationItem.leftBarButtonItem = ubar;
    
}

-(void)showLeft:(UIButton *)sender{
    [self.navigationController popViewControllerAnimated:NO];
}

- (void)createAutolayout{
    /*
     高度自由化的布局，可以根据需求，把segmentController布局成你需要的样子.(面对不同的场景，设置不同的top距离)
     */
    [_segmentController.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(64);
        make.left.right.bottom.mas_equalTo(0);
    }];
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
