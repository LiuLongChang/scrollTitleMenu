//
//  TopTitleView.h
//  ScrollTitleMenuDemo
//
//  Created by langyue on 16/9/2.
//  Copyright © 2016年 langyue. All rights reserved.
//

#import <UIKit/UIKit.h>


@class TopTitleView;
@protocol TopTitleViewDelegate <NSObject>


-(void)topTitleView:(TopTitleView*)topTitleView didSelectTitleAtIndex:(NSInteger)index;


@end





@interface TopTitleView : UIScrollView



//静止标题数组
@property(nonatomic,strong)NSArray* staticTitleArr;
//滚动标题数组
@property(nonatomic,strong)NSArray* scrollTitleArr;
//存入所有Label
@property(nonatomic,strong)NSMutableArray* allTitleLabel;
@property(nonatomic,assign)id<TopTitleViewDelegate>delegate_m;


/**类方法*/
+(instancetype)topTitleView_Frame:(CGRect)frame;

#pragma mark - - - 给外界ScrollView提供的方法以及自身方法实现

/**静止标题选中颜色改变以及指示器位置变化*/
-(void)staticTitleLabelSelected:(UILabel*)label;
/**滚动标题选中颜色改变以及指示器位置变化*/
-(void)scrollTitleLabelSelected:(UILabel*)label;
/**滚动标题选中居中*/
-(void)scrollTitleLabelSelectedCenter:(UILabel*)centerLabel;




@end
