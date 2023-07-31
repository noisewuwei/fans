//
//  AddressListViewController.m
//  Fans
//
//  Created by 吴畏 on 2018/8/6.
//  Copyright © 2018年 吴畏. All rights reserved.
//

#import "AddressListViewController.h"
#import "AddressTableViewCell.h"
#import "AddAdressViewController.h"

@interface AddressListViewController ()<UITableViewDelegate,UITableViewDataSource>{
    UITableView *tableview;
    NSArray *dataarr;
}

@end

@implementation AddressListViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"收货地址";
    [self createBarLeftWithImage:@"iconback"];
    
    tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, zScreenWidth, zScreenHeight-50) style:UITableViewStylePlain];
    tableview.delegate = self;
    tableview.dataSource = self;
    tableview.separatorStyle = UITableViewCellSelectionStyleNone;
    
    [self.view addSubview:tableview];
    
    UIButton *addbtn = [[UIButton alloc]initWithFrame:CGRectMake(0, zScreenHeight-50, zScreenWidth, 50)];
    [addbtn setTitleColor:[UIColor colorHexString:@"383838"] forState:UIControlStateNormal];
    [addbtn setTitle:@"添加收货地址" forState:UIControlStateNormal];
    addbtn.titleLabel.font = [UIFont systemFontOfSize:16 weight:UIFontWeightRegular];
    [addbtn setBackgroundColor:[UIColor colorHexString:@"fedb43"]];
    [addbtn addTarget:self action:@selector(addclick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:addbtn];
    
    [self load];
    
    // Do any additional setup after loading the view.
}

- (void)load{
    
    [HTTPRequest postWithURL:@"api/memberaddress/getaddresslist" method:@"POST" params: nil ProgressHUD:self.Hud controller:self response:^(id json) {
        NSLog(@"1111222===%@",json);
        
        dataarr = [json objectForKey:@"data"];
        
        [tableview reloadData];
        
    } error400Code:^(id failure) {
        NSLog(@"%@",failure);
    }];
}

- (void)addclick{
    AddAdressViewController *avc = [[AddAdressViewController alloc]init];
    avc.callBackBlock = ^(NSString *text){
        
        [self load];
        
    };
    [self.navigationController pushViewController:avc animated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return dataarr.count;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 126;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"cell";
    AddressTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    NSDictionary *dic = dataarr[indexPath.row];
    if (!cell) {
        
        //单元格样式设置为UITableViewCellStyleDefault
        cell = [[AddressTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.selectionStyle =UITableViewCellSelectionStyleNone;
        
    }
    
    cell.nameLabel.text = [dic objectForKey:@"name"];
    cell.numLabel.text = [dic objectForKey:@"mobile"];
    cell.adressLabel.text = [NSString stringWithFormat:@"%@%@%@%@",[dic objectForKey:@"province"],[dic objectForKey:@"city"],[dic objectForKey:@"area"],[dic objectForKey:@"address"]];
    
    if ([[dic objectForKey:@"isDefault"] isEqualToString:@"是"]) {
        cell.adressButton.selected = YES;//== 1 ?YES:NO;
    }else{
        cell.adressButton.selected = NO;
    }
    
    
    
    [cell.editButton addTarget:self action:@selector(edit:) forControlEvents:UIControlEventTouchUpInside];
    cell.editButton.tag = 100+indexPath.row;
    [cell.adressButton addTarget:self action:@selector(select:) forControlEvents:UIControlEventTouchUpInside];
    cell.adressButton.tag = 200+indexPath.row;
    [cell.deleteButton addTarget:self action:@selector(delete:) forControlEvents:UIControlEventTouchUpInside];
    cell.deleteButton.tag = 300+indexPath.row;
    
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([_str isEqualToString:@"callback"]) {
        self.callBack(dataarr[indexPath.row]);
        [self.navigationController popViewControllerAnimated:NO];
    }
    
    
}

- (void)edit:(UIButton *)editBtn{
    
    NSDictionary *dict = dataarr[editBtn.tag - 100];
    
    AddAdressViewController *avc = [[AddAdressViewController alloc]init];
    avc.dic = dict;
    avc.callBackBlock = ^(NSString *text){
        
        [self load];
        
    };
    [self.navigationController pushViewController:avc animated:YES];

}

- (void)select:(UIButton *)selectBtn{
    selectBtn.selected = !selectBtn.selected;
    
    NSDictionary *dict = dataarr[selectBtn.tag - 200];
    
    if(selectBtn.selected == NO){
        [HTTPRequest postWithURL:@"api/memberaddress/modifyaddressdefault" method:@"POST" params: @{@"receiverId":[dict objectForKey:@"receiverId"],@"type":@"否"} ProgressHUD:self.Hud controller:self response:^(id json) {
            NSLog(@"1111222===%@",json);
            
            [self load];
            
        } error400Code:^(id failure) {
            NSLog(@"%@",failure);
        }];
        
    }else{
        
        [HTTPRequest postWithURL:@"api/memberaddress/modifyaddressdefault" method:@"POST" params: @{@"receiverId":[dict objectForKey:@"receiverId"],@"type":@"是"} ProgressHUD:self.Hud controller:self response:^(id json) {
            NSLog(@"1111222===%@",json);
            
            [self load];
            
        } error400Code:^(id failure) {
            NSLog(@"%@",failure);
        }];
        
    }
    
}

- (void)delete:(UIButton *)deleteBtn{
    
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
