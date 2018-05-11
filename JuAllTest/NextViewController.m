//
//  NextViewController.m
//  JuAllTest
//
//  Created by Juvid on 2018/5/7.
//  Copyright © 2018年 Juvid. All rights reserved.
//

#import "NextViewController.h"
#import "JuObject+Cate.h"
#import "JuAllTest-Swift.h"
//#import "UIImage+Gif.h"
@interface NextViewController (){
    JuObject *subLod;
}

@end

@implementation NextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];

    subLod=[[JuObject alloc]init];
    subLod.sh_subLoda=[[JuSubSubLoad alloc]init];
    UIButton *btn;


    UIImageView *view=[[UIImageView alloc]initWithFrame:CGRectMake(50, 64, 250, 250)];
//    view.image=[UIImage juGetGifWithName:@"123456"];
    [self.view addSubview:view];
    view.contentMode=UIViewContentModeScaleAspectFit;
//    view. ju
//    [view juSetGifImage:@"123456"];
    // Do any additional setup after loading the view.
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
