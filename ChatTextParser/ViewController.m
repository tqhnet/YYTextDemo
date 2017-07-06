//
//  ViewController.m
//  ChatTextParser
//
//  Created by tqh on 2017/7/6.
//  Copyright © 2017年 tqh. All rights reserved.
//

#import "ViewController.h"
#import <YYText.h>
#import "ParserHelper.h"
#import "WJChatFaceParser.h"


@interface ViewController ()

@property (nonatomic,strong) YYLabel *label;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    NSString *str =  @"哈[中毒]哈电话撒[中毒][微笑]大家很快电话撒很快电话很快电话很快电话很快电话很快电话很快电话很快电话很快电话很快电话很快电话很[中毒]快电话很快电话很快[中毒]电话很快电话[中毒]很快电话很快电话很快电话很快电话很[中毒]快电话很快电话很快电话";
//    NSArray *array = [ParserHelper createFaceEmotion];
//    [array writeToFile:@"/Users/tqh/Desktop/face.plist" atomically:YES];
//    NSMutableAttributedString *att = [[NSMutableAttributedString alloc]init];
//    [att yy_appendString:str];
    
    self.label.frame = CGRectMake(50, 100, 300, 300);
    
    
//    YYTextLayout *textLayout = [YYTextLayout layoutWithContainerSize:CGSizeMake(200, 100) text:att];
//    
    self.label.text = str;
//    self.label.frame = CGRectMake(50, 100, textLayout.textBoundingSize.width,textLayout.textBoundingSize.height);
    
    [self.view addSubview:self.label];
//    NSLog(@"%@",[ParserHelper faceEmoticonArray]);
}

- (YYLabel *)label {
    if (!_label) {
        _label = [YYLabel new];
        _label.textParser = [WJChatFaceParser new];
        _label.layer.borderWidth = 1;
        _label.numberOfLines = 0;
    }
    return _label;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
