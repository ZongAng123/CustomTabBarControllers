//
//  ZATabbarController.m
//  CustomTabBarControllers
//
//  Created by 纵昂 on 2023/6/5.
//

#import "ZATabbarController.h"
#import "ViewController.h"
#import "OneViewController.h"
#import "TwoViewController.h"
#import "ThreeViewController.h"



@interface ZATabbarController ()
@property (nonatomic, assign) NSInteger  itemSelectIndex;
@property (nonatomic, strong) CABasicAnimation *animation;

@end

@implementation ZATabbarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor =[UIColor whiteColor];
    
    self.tabBar.backgroundColor=[UIColor redColor];
    self.tabBar.tintColor = [UIColor blackColor];
    
    [self creatTabbar];
}

-(void)creatTabbar{
    

    NSArray * controllers = @[@"ViewController",@"OneViewController",@"TwoViewController",@"ThreeViewController"];
    NSArray * titles = @[@"",@"",@"",@""];
    NSArray * normalImages = @[@"home_normal",@"start_normal",@"play_normal",@"pause_normal"];
    NSArray * selectImage = @[@"home_select",@"start_select",@"play_select",@"pause_select"];
    [self creatChildControllerWithControllers:controllers andTiles:titles NormalImages:normalImages andSelectImages:selectImage];

}

-(void)creatChildControllerWithControllers:(NSArray * )controllers andTiles:(NSArray * )titles NormalImages:(NSArray * )normalImages andSelectImages:(NSArray *)selectImages{
    self.itemSelectIndex =  0;
    NSMutableArray * navArr = [NSMutableArray array];
    for (NSInteger i = 0 ; i < controllers.count; i++) {
        Class  vcClass = NSClassFromString(controllers[i]);
        
        UIViewController * vc = [[vcClass alloc]init];
        vc.title = titles[i];
        vc.view.backgroundColor = [UIColor whiteColor];
        vc.tabBarItem.image = [[UIImage imageNamed:normalImages[i]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        vc.tabBarItem.selectedImage = [[UIImage imageNamed:selectImages[i]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        NSMutableDictionary *md = [NSMutableDictionary dictionary];
        md[NSFontAttributeName] =[UIFont systemFontOfSize:10 weight:UIFontWeightMedium];
        md[NSForegroundColorAttributeName] =[UIColor orangeColor];
        [vc.tabBarItem setTitleTextAttributes:md forState:UIControlStateNormal];
//      设置高亮状态文字的颜色
        NSMutableDictionary *higMd = [NSMutableDictionary dictionary];
        higMd[NSForegroundColorAttributeName] = [UIColor blueColor];
        higMd[NSFontAttributeName] =[UIFont systemFontOfSize:10 weight:UIFontWeightMedium];
        [vc.tabBarItem setTitleTextAttributes:higMd forState:UIControlStateSelected];
        UINavigationController * navVC = [[UINavigationController alloc]initWithRootViewController:vc];
        [navArr addObject:navVC];
        
    }
    self.viewControllers = navArr;
 
    
}

-(void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item{
        NSInteger index = [self.tabBar.items indexOfObject:item];
         if (index != self.itemSelectIndex) {
//             获取按钮
               NSMutableArray *arry = [NSMutableArray array];
               for (UIView *btn in self.tabBar.subviews) {
                   if ([btn isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
                        [arry addObject:btn];
                   }
               }
#pragma mark - 添加动画 向上移动 选中的向上移动
             self.animation = [CABasicAnimation animationWithKeyPath:@"transform.translation.y"];
//           速度控制函数，控制动画运行的节奏
             self.animation.fromValue = [NSNumber numberWithFloat:0];
             self.animation.toValue = [NSNumber numberWithFloat:-20];
             self.animation.duration = 0.2; //動畫時長
             self.animation.repeatCount = 1; // 重複次數
             self.animation.removedOnCompletion = NO;
             self.animation.fillMode=kCAFillModeForwards;
             [[arry[index] layer] addAnimation:self.animation forKey:nil];
//             [[arry[index] layer] addAnimation:self.animation forKey:nil];
//            移除其他tabbar的动画
                 for (int i = 0; i<arry.count; i++) {
                     if (i != index) {
                         [[arry[i] layer] removeAllAnimations];
                     }
                 }
                 self.itemSelectIndex = index;
             }

}
-(void)didClickCenterButton{
    NSLog(@"didClickCenterButton");
    
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
