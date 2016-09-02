//
//  ViewController.m
//  ScrollTitleMenuDemo
//
//  Created by langyue on 16/9/2.
//  Copyright © 2016年 langyue. All rights reserved.
//

#import "ViewController.h"
#import "StaticViewController.h"
#import "ScrollViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}



- (IBAction)itemToShow:(UIButton *)sender {


    if (sender.tag == 200) {
        //staticTitle
        StaticViewController * vc = [[StaticViewController alloc] init];
        UINavigationController * nc = [[UINavigationController alloc] initWithRootViewController:vc];
        nc.navigationBar.barTintColor = [UIColor cyanColor];
        [self presentViewController:nc animated:YES completion:nil];

    }

    if (sender.tag == 201) {
        //scrollTitle


        ScrollViewController * vc = [[ScrollViewController alloc] init];
        UINavigationController * nc = [[UINavigationController alloc] initWithRootViewController:vc];
        [self presentViewController:nc animated:YES completion:nil];


    }

    if (sender.tag == 202) {
        //navigationBarTitle


        
    }
    





}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
