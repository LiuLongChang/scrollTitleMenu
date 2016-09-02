//
//  TopTitleView.m
//  ScrollTitleMenuDemo
//
//  Created by langyue on 16/9/2.
//  Copyright © 2016年 langyue. All rights reserved.
//

#import "TopTitleView.h"


#import "UIView+Extension.h"

#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define labelFontOfSize [UIFont systemFontOfSize:17]
#define selectedTitleAndIndicatorViewColor [UIColor redColor]


@interface TopTitleView()

//静止标题Label
@property(nonatomic,strong)UILabel *staticTitleLabel;
//滚动标题Label
@property(nonatomic,strong)UILabel *scrollTitleLabel;
//选中标题时的Label
@property(nonatomic,strong)UILabel *selectedTitleLabel;
//指示器
@property(nonatomic,strong)UIView *inidicatorView;



@end



@implementation TopTitleView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


//label之间的间距(滚动时TitleLabel之间的间距)
static CGFloat const labelMargin = 15;
//指示器的高度
static CGFloat const indicatorHeight = 3;


-(NSMutableArray*)allTitleLabel{
    if (_allTitleLabel == nil) {
        _allTitleLabel = [NSMutableArray array];
    }
    return _allTitleLabel;
}


-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.9];
        self.showsHorizontalScrollIndicator = NO;
        self.bounces = NO;
    }
    return self;
}



+(instancetype)topTitleView_Frame:(CGRect)frame{
    return [[self alloc] initWithFrame:frame];
}



/*
 *  计算文字尺寸
 *  @param text 需要计算尺寸的文字
 *  @param font 文字的字体
 *  @param maxSize 文字的最大尺寸
 *
 */


-(CGSize)size_Text:(NSString*)text font:(UIFont*)font maxSize:(CGSize)maxSize{
    NSDictionary * attrs = @{NSFontAttributeName : font};
    return [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}


//pragma mark - - - 重写静止标题数组的setter方法
-(void)setStaticTitleArr:(NSArray*)staticTitleArr{
    _staticTitleArr = staticTitleArr;

    //计算scrollView的宽度
    CGFloat scrollViewWidth = self.frame.size.width;
    CGFloat labelX = 0;
    CGFloat labelY = 0;
    CGFloat labelW = scrollViewWidth / _staticTitleArr.count;
    CGFloat labelH = self.frame.size.height - indicatorHeight;

    for (NSInteger j=0; j < _staticTitleArr.count; j++) {
        //创建静止时的标题Label
        self.staticTitleLabel = [[UILabel alloc] init];
        _staticTitleLabel.userInteractionEnabled = YES;
        _staticTitleLabel.text = self.staticTitleArr[j];
        _staticTitleLabel.textAlignment = NSTextAlignmentCenter;
        _staticTitleLabel.tag = j;

        //设置高亮文字颜色
        _staticTitleLabel.highlightedTextColor = selectedTitleAndIndicatorViewColor;
        //计算staticTitleLabel的x值
        labelX = j*labelW;
        _staticTitleLabel.frame = CGRectMake(labelX, labelY, labelW, labelH);
        //添加到titleLabels的数组
        [self.allTitleLabel addObject:_staticTitleLabel];

        //添加点按手势
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(staticTitleClick:)];
        [_staticTitleLabel addGestureRecognizer:tap];

        //默认选中第0个label
        if (j == 0) {
            [self staticTitleClick:tap];
        }

        [self addSubview:_staticTitleLabel];
        
    }

    //取出第一个子控件
    UILabel * firstLabel = self.subviews.firstObject;
    //添加指示器
    self.inidicatorView = [[UIView alloc] init];
    _inidicatorView.backgroundColor = selectedTitleAndIndicatorViewColor;
    _inidicatorView.height = indicatorHeight;
    _inidicatorView.y = self.frame.size.height - indicatorHeight;
    [self addSubview:_inidicatorView];


    //指示器默认在第一次选中位置
    //计算TitleLabel内容的Size
    CGSize labelSize = [self size_Text:firstLabel.text font:labelFontOfSize maxSize:CGSizeMake(MAXFLOAT, labelH)];
    _inidicatorView.width = labelSize.width;
    _inidicatorView.centerX = firstLabel.centerX;

}




-(void)staticTitleClick:(UITapGestureRecognizer*)tap{

    // 0.获取选中的label
    UILabel * selLabel = (UILabel*)tap.view;

    // 1.标题颜色变成红色 设置高亮状态下的颜色 以及指示器位置
    [self staticTitleLabelSelected:selLabel];

    //代理方法实现
    NSInteger index = selLabel.tag;
    if ([self.delegate_m respondsToSelector:@selector(topTitleView:didSelectTitleAtIndex:)]) {
        [self.delegate_m topTitleView:self didSelectTitleAtIndex:index];
    }

}





/** 静止标题选中颜色改变以及指示器位置变化*/
-(void)staticTitleLabelSelected:(UILabel *)label{
    //取消高亮
    _selectedTitleLabel.highlighted = NO;
    //颜色恢复
    _selectedTitleLabel.textColor = [UIColor blackColor];

    //高亮
    label.highlighted = YES;
    _selectedTitleLabel = label;

    //改变指示器位置
    [UIView animateWithDuration:0.2 animations:^{

        //计算指示器的位置
        CGSize labelSize = [self size_Text:_selectedTitleLabel.text font:labelFontOfSize maxSize:CGSizeMake(MAXFLOAT, self.frame.size.height - indicatorHeight)];

        self.inidicatorView.width = labelSize.width;
        self.inidicatorView.centerX = label.centerX;

    }];
}

#pragma mark --- 重写滚动标题数组setter方法
-(void)setScrollTitleArr:(NSArray *)scrollTitleArr{


    _scrollTitleArr = scrollTitleArr;
    CGFloat labelX = 0;
    CGFloat labelY = 0;
    CGFloat labelH = self.frame.size.height - indicatorHeight;


    for (NSUInteger i = 0; i < self.scrollTitleArr.count; i++) {

        self.scrollTitleLabel = [[UILabel alloc] init];
        _scrollTitleLabel.userInteractionEnabled = YES;
        _scrollTitleLabel.text = self.scrollTitleArr[i];
        _scrollTitleLabel.textAlignment = NSTextAlignmentCenter;
        _scrollTitleLabel.tag = i;

        //设置高亮文字颜色
        _scrollTitleLabel.highlightedTextColor = selectedTitleAndIndicatorViewColor;
        //计算内容的Size
        CGSize labelSize = [self size_Text:_scrollTitleLabel.text font:labelFontOfSize maxSize:CGSizeMake(MAXFLOAT, labelH)];
        //计算内容的宽度
        CGFloat labelW = labelSize.width + 2 * labelMargin;

        _scrollTitleLabel.frame = CGRectMake(labelX, labelY, labelW, labelH);
        //计算每个label的x值
        labelX = labelX + labelW;
        //添加到titleLabels数组
        [self.allTitleLabel addObject:_scrollTitleLabel];

        //添加点按手势
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(scrollTitleClick:)];
        [_scrollTitleLabel addGestureRecognizer:tap];

        //默认选中第0个label
        if (i == 0) {
            [self scrollTitleClick:tap];
        }
        [self addSubview:_scrollTitleLabel];
    }


    //计算scrollView的宽度
    CGFloat scrollViewWidth = CGRectGetMaxX(self.subviews.lastObject.frame);
    self.contentSize = CGSizeMake(scrollViewWidth, self.frame.size.height);
    //取出第一个子控件
    UILabel * firstLabel = self.subviews.firstObject;

    //添加指示器
    self.inidicatorView = [[UIView alloc] init];
    _inidicatorView.backgroundColor = selectedTitleAndIndicatorViewColor;
    _inidicatorView.height = indicatorHeight;
    _inidicatorView.y = self.frame.size.height - indicatorHeight;
    [self addSubview:_inidicatorView];

    //指示器默认在第一个选中位置
    //计算TitleLabel内容的Size
    CGSize labelSize = [self size_Text:firstLabel.text font:labelFontOfSize maxSize:CGSizeMake(MAXFLOAT, labelH)];
    _inidicatorView.width = labelSize.width;
    _inidicatorView.centerX = firstLabel.centerX;

}





/** scrollTitleClick的点击事件*/
-(void)scrollTitleClick:(UITapGestureRecognizer*)tap{
    //获取选中的label
    UILabel * selLabel = (UILabel*)tap.view;
    //标题颜色变成红色 设置高亮状态下的颜色 以及指示器位置
    [self scrollTitleLabelSelected:selLabel];
    //让选中的标题据中 （当contentSize 大于self的宽度才会生效）
    [self scrollTitleLabelSelectedCenter:selLabel];

    //代理方法实现
    NSInteger index = selLabel.tag;
    if ([self.delegate_m respondsToSelector:@selector(topTitleView:didSelectTitleAtIndex:)]) {
        [self.delegate_m topTitleView:self didSelectTitleAtIndex:index];
    }

}


/**滚动标题选中颜色改变以及指示器位置变化*/
-(void)scrollTitleLabelSelected:(UILabel *)label{

    //取消高亮
    _selectedTitleLabel.highlighted = NO;
    //颜色恢复
    _selectedTitleLabel.textColor = [UIColor blackColor];
    //高亮
    label.highlighted = YES;
    _selectedTitleLabel = label;
    //改变指示器位置
    [UIView animateWithDuration:0.20 animations:^{
        self.inidicatorView.width = label.width - 2*labelMargin;
        self.inidicatorView.centerX = label.centerX;
    }];

}



-(void)scrollTitleLabelSelectedCenter:(UILabel *)centerLabel{

    //计算偏移量
    CGFloat offsetX = centerLabel.center.x - kScreenWidth * 0.5;
    if (offsetX < 0) {
        offsetX = 0;
    }
    //获取最大滚动范围
    CGFloat maxOffsetX = self.contentSize.width - kScreenWidth;
    if (offsetX > maxOffsetX) {
        offsetX = maxOffsetX;
    }
    //滚动标题滚动条
    [self setContentOffset:CGPointMake(offsetX, 0) animated:YES];

}






@end
