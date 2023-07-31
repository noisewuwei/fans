//
//  SecondViewController.m
//  Fans
//
//  Created by 吴畏 on 2018/6/20.
//  Copyright © 2018年 吴畏. All rights reserved.
//

#import "SecondViewController.h"
#import "BigBarViewController.h"
#import "PersonStationViewController.h"
#import "FansPhotoViewController.h"
#import "FansDrawViewController.h"
#import "CompanyViewController.h"
#import "ZXSegmentController.h"
#import "Masonry.h"

@interface SecondViewController ()<UITextFieldDelegate>{
    UITextField *search;
    UITableView *tableview;
}

@property (nonatomic,weak) ZXSegmentController* segmentController;

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, zScreenWidth, zScreenHeight)];
    backView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:backView];
    
    UIView *topback = [[UIView alloc]initWithFrame:CGRectMake(0, 0, zScreenWidth, 40)];
    topback.backgroundColor = [UIColor clearColor];
    [self.navigationController.navigationBar addSubview:topback];
    
    UIView *whiteback = [[UIView alloc]initWithFrame:CGRectMake(5.5, 5.5, zScreenWidth-11, 29)];
    whiteback.backgroundColor = [UIColor colorHexString:@"ececec"];
    whiteback.layer.masksToBounds = YES;
    whiteback.layer.cornerRadius = 14.5;
    [topback addSubview:whiteback];
    
    UIImageView *searchImg = [[UIImageView alloc]initWithFrame:CGRectMake(11, 4.5, 20, 20)];
    searchImg.image = [UIImage imageNamed:@"icon_search"];
    [whiteback addSubview:searchImg];
    
    search = [[UITextField alloc]initWithFrame:CGRectMake(11+20+10, 0, zScreenWidth-80, 29)];
    search.placeholder = @"请输入作品关键词、明星或达人昵称";
    search.returnKeyType = UIReturnKeyDone;
    search.delegate = self;
    search.font = [UIFont systemFontOfSize:14 weight:UIFontWeightRegular];
    [whiteback addSubview:search];
    
    
    
    BigBarViewController *VC1 = [[BigBarViewController alloc]init];
    PersonStationViewController *VC2 = [[PersonStationViewController alloc]init];
    FansPhotoViewController *VC3 = [[FansPhotoViewController alloc]init];
    FansDrawViewController *VC4 = [[FansDrawViewController alloc]init];
    CompanyViewController *VC5 = [[CompanyViewController alloc]init];
    
    NSArray* names = @[@"大吧",@"个站",@"饭拍",@"饭绘",@"机构"];
    NSArray* controllers = @[VC1,VC2,VC3,VC4,VC5];
    
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

- (void)createAutolayout{
    /*
     高度自由化的布局，可以根据需求，把segmentController布局成你需要的样子.(面对不同的场景，设置不同的top距离)
     */
    [_segmentController.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.right.bottom.mas_equalTo(0);
    }];
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (textField) {
        [search resignFirstResponder];
    }
    return YES;
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
