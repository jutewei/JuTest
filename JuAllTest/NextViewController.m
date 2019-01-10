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
#import "UIImage+Gif.h"
@interface NextViewController (){
    JuObject *subLod;
    UIImageView *imageView;
}

@end

@implementation NextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];

    subLod=[[JuObject alloc]init];
    subLod.sh_subLoda=[[JuSubSubLoad alloc]init];


    imageView=[[UIImageView alloc]initWithFrame:CGRectMake(50, 64, 250, 250)];
//    view.image=[UIImage juGetGifWithName:@"123456"];
    [self.view addSubview:imageView];
    imageView.contentMode=UIViewContentModeScaleAspectFit;
//    view. ju
    [imageView juSetGifImage:@"123456"];


    UIButton *btn=[[UIButton alloc]initWithFrame:CGRectMake(100, 300, 100, 50)];
    [btn addTarget:self action:@selector(JuGotoNexe) forControlEvents:UIControlEventTouchUpInside];
    btn.backgroundColor=[UIColor redColor];
    [self.view addSubview:btn];

   
    // Do any additional setup after loading the view.
}
-(void)JuGotoNexe{
    NextViewController *next=[[NextViewController alloc]init];
    [self.navigationController pushViewController:next animated:YES];
}
-(void)dealloc{
    [imageView juDealloc];
}
-(BOOL)prefersStatusBarHidden{
    return YES;
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
