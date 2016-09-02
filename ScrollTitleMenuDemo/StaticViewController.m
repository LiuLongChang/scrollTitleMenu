//
//  StaticViewController.m
//  ScrollTitleMenuDemo
//
//  Created by langyue on 16/9/2.
//  Copyright © 2016年 langyue. All rights reserved.
//

#import "StaticViewController.h"
#import "TopTitleView.h"
#import "OneViewController.h"
#import "TwoViewController.h"
#import "ThreeViewController.h"
#import "FourViewController.h"


@interface StaticViewController ()<TopTitleViewDelegate,UIScrollViewDelegate>


@property(nonatomic,strong)TopTitleView* topTitleView;
@property(nonatomic,strong)UIScrollView* mainScrollView;
@property(nonatomic,strong)NSArray* titles;



@end







@implementation StaticViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"三四项 没有占满屏幕 不用滑动";

    self.view.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1.0];
    self.automaticallyAdjustsScrollViewInsets = NO;
    //添加所有自控制器
    [self setupChildViewController];


    self.titles = @[@"精选",@"电视剧",@"电影",@"综艺"];
    self.topTitleView = [TopTitleView topTitleView_Frame:CGRectMake(0, 64, self.view.frame.size.width, 44)];
    _topTitleView.staticTitleArr = [NSArray arrayWithArray:_titles];
    _topTitleView.delegate_m = self;
    [self.view addSubview:_topTitleView];

    //创建底部滚动视图
    self.mainScrollView = [[UIScrollView alloc] init];
    _mainScrollView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    _mainScrollView.contentSize = CGSizeMake(self.view.frame.size.width * _titles.count,0);
    _mainScrollView.backgroundColor = [UIColor clearColor];
    //开启分页
    _mainScrollView.pagingEnabled = YES;
    //没有弹簧效果
    _mainScrollView.bounces = NO;
    //隐藏水平滚动条
    _mainScrollView.showsHorizontalScrollIndicator = NO;
    //设置代理
    _mainScrollView.delegate = self;
    [self.view addSubview:_mainScrollView];



    OneViewController * vc = [[OneViewController alloc] init];
    [self.mainScrollView addSubview:vc.view];
    [self.view insertSubview:_mainScrollView belowSubview:_topTitleView];



    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn addTarget:self action:@selector(leftNavBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * btnItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.leftBarButtonItem = btnItem;
    [btn setTitle:@"返回" forState:UIControlStateNormal];
    //btn.backgroundColor = [UIColor blackColor];
    btn.frame = CGRectMake(0, 0, 50, 50*0.618);
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];


}


-(void)leftNavBtnAction:(UIButton*)btn{


    [self dismissViewControllerAnimated:YES completion:^{

    }];

}

#pragma mark - - - TopScrollMenu代理方法
-(void)topTitleView:(TopTitleView *)topTitleView didSelectTitleAtIndex:(NSInteger)index{

    CGFloat offsetX = index * self.view.frame.size.width;
    [self.mainScrollView setContentOffset:CGPointMake(offsetX, 0) animated:true];
    [self showVc:index];

}


//显示控制器的view
-(void)showVc:(NSInteger)index{


    CGFloat offsetX = index * self.view.frame.size.width;
    UIViewController * vc= self.childViewControllers[index];
    //判断控制器的view有没有加载过 如果已经加再过 就不需要再加载

    if (vc.isViewLoaded) {
        return;
    }

    [self.mainScrollView addSubview:vc.view];
    vc.view.frame = CGRectMake(offsetX, 0, self.view.frame.size.width, self.view.frame.size.height);

}



-(void)setupChildViewController{

    //精选
    OneViewController * oneVc = [[OneViewController alloc] init];
    [self addChildViewController:oneVc];

    //电视剧
    TwoViewController * twoVc = [[TwoViewController alloc] init];
    [self addChildViewController:twoVc];

    //电影
    ThreeViewController * three = [[ThreeViewController alloc] init];
    [self addChildViewController:three];

    //综艺
    FourViewController * four = [[FourViewController alloc] init];
    [self addChildViewController:four];

}

#pragma mark - UIScrollViewDelegate
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    //计算滚动到哪一页
    NSInteger index = scrollView.contentOffset.x / scrollView.frame.size.width;
    //添加子控制器view
    [self showVc:index];

    //把对应的标题选中
    UILabel * selLabel = self.topTitleView.allTitleLabel[index];

    //滚动时 改变标题选中
    [self.topTitleView staticTitleLabelSelected:selLabel];

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
