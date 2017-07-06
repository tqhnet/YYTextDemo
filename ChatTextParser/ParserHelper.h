//
//  ParserHelper.h
//  ChatTextParser
//
//  Created by tqh on 2017/7/6.
//  Copyright © 2017年 tqh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ParserHelper : NSObject

/// 表情正则 例如 [偷笑]
+ (NSRegularExpression *)regexEmoticon;

/// 表情字典 key:[偷笑] value:ImagePath
+ (NSDictionary *)faceEmoticonDic;

//表情数组
+ (NSArray *)faceEmoticonArray;

//根据地址生成图片
+ (UIImage *)imageWithPath:(NSString *)imageString;

+ (NSArray *)createFaceEmotion;

@end
