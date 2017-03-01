//
//  ViewController.m
//  UISkipControlOC
//
//  Created by AKsoftware on 2016/10/24.
//  Copyright © 2016年 AKsoftware. All rights reserved.
//

#import "ViewController.h"
#import "UINavigationController+UISkipControl.h"
#import "UIViewController+UISkipControl.h"


#define case1
//#define case2
//#define case3
//#defin case4

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)didSelected:(id)sender {
    
    
    //运行时，选择其中的某一个case 运行,打开上面的宏
#ifdef case1
    //case 1
   // [self.navigationController pushViewController:[[UIViewController alloc] init] animated:YES];
    //[self.navigationController pushViewController:[[UIViewController alloc] init] animated:YES];
#endif
    
#ifdef case2
    //case 2
    [self.navigationController pushViewController:[[UIViewController alloc] init]  animated:YES isAllowQueued:NO completionBlock:^{
        [self.navigationController pushViewController:[[UIViewController alloc] init] animated:YES];
    }];
#endif
    
#ifdef case3

    //case 3
    [self.navigationController pushViewController:[[UIViewController alloc] init] animated:YES];
    [self.navigationController pushViewController:[[UIViewController alloc] init]  animated:YES isAllowQueued:YES completionBlock:nil];
#endif

#ifdef case4
    [self presentViewController:[[UIViewController alloc] init] animated:YES completion:nil];
    [self dismissViewControllerAnimated:YES allowQueued:YES completion:nil];
#endif
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
