//
//  WJChatFaceParser.h
//  ChatTextParser
//
//  Created by tqh on 2017/7/6.
//  Copyright © 2017年 tqh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <YYText.h>
/**聊天表情解析器*/

@interface WJChatFaceParser : NSObject <YYTextParser>

- (NSMutableAttributedString *)parseText:(NSMutableAttributedString *)text;

@end
