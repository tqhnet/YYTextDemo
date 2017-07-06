//
//  ParserHelper.m
//  ChatTextParser
//
//  Created by tqh on 2017/7/6.
//  Copyright © 2017年 tqh. All rights reserved.
//

#import "ParserHelper.h"

@implementation ParserHelper

+ (NSRegularExpression *)regexEmoticon {
    static NSRegularExpression *regex;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        regex = [NSRegularExpression regularExpressionWithPattern:@"\\[[^ \\[\\]]+?\\]" options:kNilOptions error:NULL];
    });
    return regex;
}

+ (NSDictionary *)faceEmoticonDic {
    static NSMutableDictionary *dic;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        dic = [NSMutableDictionary dictionary];
        NSString *faceString = [[NSBundle mainBundle] pathForResource:@"face" ofType:@"plist"];
        NSArray *array = [NSArray arrayWithContentsOfFile:faceString];
        [array enumerateObjectsUsingBlock:^(NSDictionary *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [dic setObject:obj[@"png"] forKey:obj[@"name"]];
        }];
        
    });
    return dic;
}

+ (NSArray *)faceEmoticonArray {
    NSString *faceString = [[NSBundle mainBundle] pathForResource:@"face" ofType:@"plist"];
    NSArray *array = [NSArray arrayWithContentsOfFile:faceString];
    return array;
}

+ (UIImage *)imageWithPath:(NSString *)imageString {
    NSString *faceString = [NSString stringWithFormat:@"mouo_chat_face.bundle/%@",imageString];
    return [UIImage imageNamed:faceString];
}

+ (NSArray *)createFaceEmotion {
    NSString *faceString = @"微笑 憋嘴 色色 发呆 得意 哭 害羞 闭嘴 休息 嚎啕大哭 尴尬 发火 调皮 呲牙 惊讶 难过 冷汗 抓狂 呕吐 偷笑 可爱 白眼 傲慢 饥饿 困 惊恐 冷汗 大笑 加油 咒骂 疑问 嘘 好晕 衰 捶你 拜拜 抠鼻 鼓掌 坏笑 左哼哼 右哼哼 鄙视 委屈 快哭了 亲亲 可怜 笑哭 狗狗 嘿嘿 吐血 纠结 菜刀 玫瑰花 吃药 吃饭 点赞 胜利 握手 ok 赞 月亮 礼物包 爱心 心碎";
    
    NSArray *nameArray = [faceString componentsSeparatedByString:@" "];
    NSMutableArray *mutable = [NSMutableArray array];
    [nameArray enumerateObjectsUsingBlock:^(NSString *  _Nonnull name, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString *str = [NSString stringWithFormat:@"f_static_0%ld",idx+1];
        [mutable addObject:@{@"name":[NSString stringWithFormat:@"[%@]",name],@"png":str}];
    }];
    return mutable;
}

@end
