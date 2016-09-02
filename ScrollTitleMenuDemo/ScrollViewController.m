//
//  ScrollViewController.m
//  ScrollTitleMenuDemo
//
//  Created by langyue on 16/9/2.
//  Copyright © 2016年 langyue. All rights reserved.
//

#import "ScrollViewController.h"
#import "TopTitleView.h"

#import "OneViewController.h"
#import "TwoViewController.h"
#import "ThreeViewController.h"
#import "FourViewController.h"
#import "FiveViewController.h"
#import "SixViewController.h"
#import "SevenViewController.h"
#import "EightViewController.h"
#import "NineViewController.h"




@interface ScrollViewController ()<TopTitleViewDelegate,UIScrollViewDelegate>


@property(nonatomic,strong)TopTitleView * topTitleView;
@property(nonatomic,strong)UIScrollView * mainScrollView;
@property(nonatomic,strong)NSArray * titles;



@end

@implementation ScrollViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.view.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1.0];
    self.automaticallyAdjustsScrollViewInsets = NO;

    //添加所有子控制器
    [self setupChildViewController];



    self.titles = @[@"精选",@"电视剧",@"电影",@"综艺",@"NBA",@"新闻",@"娱乐",@"音乐",@"网络电影"];

    self.topTitleView = [TopTitleView topTitleView_Frame:CGRectMake(0, 64, self.view.frame.size.width, 44)];
    _topTitleView.scrollTitleArr = [NSArray arrayWithArray:_titles];
    _topTitleView.delegate_m = self;
    [self.view addSubview:_topTitleView];


    //创建底部滚动视图
    self.mainScrollView = [[UIScrollView alloc] init];
    _mainScrollView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    _mainScrollView.contentSize = CGSizeMake(self.view.frame.size.width * _titles.count, 0);
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


    //
    OneViewController * oneVC = [[OneViewController alloc] init];
    [self.mainScrollView addSubview:oneVC.view];
    [self.view insertSubview:_mainScrollView belowSubview:_topTitleView];

}

#pragma mark --- TopScrollMenu代理方法
-(void)topTitleView:(TopTitleView *)topTitleView didSelectTitleAtIndex:(NSInteger)index{


    CGFloat offsetX = index * self.view.frame.size.width;

    [self.mainScrollView setContentOffset:CGPointMake(offsetX, 0) animated:true];
    //给对应位置添加对应子控制器
    [self showVc:index];

}

-(void)showVc:(NSInteger)index{
    CGFloat offsetX = index * self.view.frame.size.width;
    UIViewController * vc = self.childViewControllers[index];
    //判断控制器的view有没有加载过 如果已经加载过 就不需再加载
    if (vc.isViewLoaded) {
        return;
    }

    [self.mainScrollView addSubview:vc.view];
    vc.view.frame = CGRectMake(offsetX, 0, self.view.frame.size.width, self.view.frame.size.height);

}




-(void)setupChildViewController{
    //精选
    OneViewController * oneVC = [[OneViewController alloc] init];
    [self addChildViewController:oneVC];

    //电视剧
    TwoViewController * twoVC = [[TwoViewController alloc] init];
    [self addChildViewController:twoVC];

    //电影
    ThreeViewController * threeVC = [[ThreeViewController alloc] init];
    [self addChildViewController:threeVC];

    //综艺
    FourViewController * fourVC = [[FourViewController alloc] init];
    [self addChildViewController:fourVC];


    //NBA
    FiveViewController * fiveVC = [[FiveViewController alloc] init];
    [self addChildViewController:fiveVC];

    //新闻
    SixViewController * sixVc = [[SixViewController alloc] init];
    [self addChildViewController:sixVc];

    //娱乐
    SevenViewController * sevenVC = [[SevenViewController alloc] init];
    [self addChildViewController:sevenVC];

    //音乐
    EightViewController * eightVC = [[EightViewController alloc] init];
    [self addChildViewController:eightVC];

    //网络电视
    NineViewController * nineVC = [[NineViewController alloc] init];
    [self addChildViewController:nineVC];


}


#pragma mark - UIScrollViewDelegate
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{

    NSInteger index = scrollView.contentOffset.x / scrollView.frame.size.width;
    //添加子控制器的view
    [self showVc:index];
    //把对应的标题选中
    UILabel * selLabel = self.topTitleView.allTitleLabel[index];

    [self.topTitleView scrollTitleLabelSelected:selLabel];
    //让选中的标题居中
    [self.topTitleView scrollTitleLabelSelectedCenter:selLabel];

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
