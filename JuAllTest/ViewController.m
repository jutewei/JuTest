//
//  ViewController.m
//  JuAllTest
//
//  Created by Juvid on 2018/5/7.
//  Copyright © 2018年 Juvid. All rights reserved.
//

#import "ViewController.h"
#import "JuObject.h"
#import "JuThread.h"
#import "JuRunLoop.h"
#import "JuEnum.h"
#import "NextViewController.h"
#import "JuAllTest-Swift.h"
#import "JuButtonView.h"
#import <JuSwiftFrame/JuSwiftFrame-Swift.h>
#import "NSAttributedString+style.h"
#import "JuCornerView.h"


@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *sh_labTest;
@property (nonatomic,strong)JuRunLoop *ju_loop;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    runTime消息转发
    JuSwift *objSwift=[[JuSwift alloc]init];
    [objSwift juTestWithName:@"hhhh"];

    JuFirst *first=[[JuFirst alloc]init];
//    NSLog(@"%@",objSwift.juLib);
//    JuLibOC *module=[[JuLibOC alloc]init];

    [self juRunTimeMsg];
    [self juThread];
    [self juLoop];
    [self juEmun];

//    JuCornerView *btn =[[ JuCornerView alloc]init];
//    btn.frame=CGRectMake(100, 100, 100, 100);
//    btn.backgroundColor=[ UIColor redColor];
//    [self.view addSubview:btn];


    _sh_labTest.minimumScaleFactor=0.75;
    _sh_labTest.attributedText=[NSMutableAttributedString juGetWithString:@"经济观察网 记者 宋笛经过一年半的培育期，人工智能科技企业正在尝试不断下沉，并在零售、制造业、医疗、金融等多个领域寻求可以进行商业应用的具体场景。\n人工智能在制造业的智能化质检、生产工艺自动化、预测性生产运维等多个环节都有很大的应用空间”，创新奇智CEO徐辉对经济观察网表示。\n创新奇智是一家主要从事“AI＋”的企业服务公司，这家公司孵化于创新工场内部建立的人工智能工程院。5月22日，创新奇智宣布完成了过亿元的天使轮融资，领投方为成为资本，创新工场等机构参与了此轮投资，此轮融资过后，创新工场依然是该公司的控股方。\n 值得关注的是，目前这家新成立的公司已经实现了一些落地的案例，其中包括鸿海科技、招商局、永辉等头部企业，涉及的行业包括制造业、保险以及零售等。" lineSpace:5 paragraph:10];
    _sh_labTest.adjustsFontSizeToFitWidth=YES;
    _sh_labTest.baselineAdjustment=UIBaselineAdjustmentAlignCenters;
//    _sh_labTest.text=@"经济观察网 记者 宋笛经过一年半的培育期，人工智能科技企业正在尝试不断下沉，并在零售、制造业、医疗、金融等多个领域寻求可以进行商业应用的具体场景。\n人工智能在制造业的智能化质检、生产工艺自动化、预测性生产运维等多个环节都有很大的应用空间”，创新奇智CEO徐辉对经济观察网表示。\n创新奇智是一家主要从事“AI＋”的企业服务公司，这家公司孵化于创新工场内部建立的人工智能工程院。5月22日，创新奇智宣布完成了过亿元的天使轮融资，领投方为成为资本，创新工场等机构参与了此轮投资，此轮融资过后，创新工场依然是该公司的控股方。\n 值得关注的是，目前这家新成立的公司已经实现了一些落地的案例，其中包括鸿海科技、招商局、永辉等头部企业，涉及的行业包括制造业、保险以及零售等。";



//    NSLog(@"%@",btn.titleLabel);
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)juLoop{
    _ju_loop =[[ JuRunLoop alloc]init];
}
-(void)juRunTimeMsg{
    JuObject *myTestObject=[[JuObject alloc]init];
    [myTestObject juStart];
    [myTestObject nonClassMethod:@"你好呀"];
}
- (IBAction)juNext:(id)sender {
    SNextViewController *next=[[SNextViewController alloc]init];
    [self.navigationController pushViewController:next animated:YES];
}
-(void)juEmun{
    JuEnum *juEnum=[[JuEnum alloc]init];
    [juEnum juStartEnum];
}
-(void)juThread{
    JuGCD *gcd=[[JuGCD alloc]init];
    [gcd shGroupQueue];
    [gcd shGlobalQueue];
    [gcd shSingQueue];
    [gcd shMoreQueue];
    [gcd juDisApply];
    [gcd juDisSpecific];
    [gcd juBarrier];


    JuOpetation *opetation=[[JuOpetation alloc]init];
    [opetation juOperation];

}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [_ju_loop juStarLoop];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
