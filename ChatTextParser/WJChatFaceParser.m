//
//  WJChatFaceParser.m
//  ChatTextParser
//
//  Created by tqh on 2017/7/6.
//  Copyright © 2017年 tqh. All rights reserved.
//

#import "WJChatFaceParser.h"
#import "ParserHelper.h"

@interface WJChatFaceParser ()

@property (nonatomic, strong) UIFont *font;     //字体大小
@property (nonatomic, assign) CGFloat linSpace; //行间距

@end

@implementation WJChatFaceParser

- (instancetype)init
{
    self = [super init];
    if (self) {
        _font = [UIFont systemFontOfSize:15];
        _linSpace = 5;
    }
    return self;
}

- (NSMutableAttributedString *)parseText:(NSMutableAttributedString *)text {
    NSArray<NSTextCheckingResult *> *emoticonResults = [[ParserHelper regexEmoticon]matchesInString:text.string options:kNilOptions range:text.yy_rangeOfAll];
    NSUInteger clipLength = 0;
    for (NSTextCheckingResult *emo in emoticonResults) {
        if (emo.range.location == NSNotFound && emo.range.length <= 1) continue;
        NSRange range = emo.range;
        range.location -= clipLength;
        if ([text yy_attribute:YYTextAttachmentAttributeName atIndex:range.location]) continue;
        NSString *emoString = [text.string substringWithRange:range];
        NSString *imagePath = [ParserHelper faceEmoticonDic][emoString];
        UIImage *image = [ParserHelper imageWithPath:imagePath];
        if (!image) continue;
        __block BOOL containsBindingRange = NO;
        [text enumerateAttribute:YYTextBindingAttributeName inRange:range options:NSAttributedStringEnumerationLongestEffectiveRangeNotRequired usingBlock:^(id value, NSRange range, BOOL *stop) {
            if (value) {
                containsBindingRange = YES;
                *stop = YES;
            }
        }];
        if (containsBindingRange) continue;
        YYTextBackedString *backed = [YYTextBackedString stringWithString:emoString];
        
        NSMutableAttributedString *emoText = [NSMutableAttributedString yy_attachmentStringWithContent:image contentMode:UIViewContentModeScaleAspectFit attachmentSize:CGSizeMake(27.5 + 5, 27.5) alignToFont:[UIFont systemFontOfSize:15] alignment:YYTextVerticalAlignmentCenter];
        // original text, used for text copy
        
        [emoText yy_setTextBackedString:backed range:NSMakeRange(0, emoText.length)];
        [emoText yy_setTextBinding:[YYTextBinding bindingWithDeleteConfirm:NO] range:NSMakeRange(0, emoText.length)];
        
        [text replaceCharactersInRange:range withAttributedString:emoText];
        
        
        clipLength += range.length - emoText.length;
    }
    
    text.yy_font = _font;
    text.yy_lineSpacing = _linSpace;
  
    return text;
}

- (BOOL)parseText:(NSMutableAttributedString *)text selectedRange:(NSRangePointer)selectedRange {
    
    NSArray<NSTextCheckingResult *> *emoticonResults = [[ParserHelper regexEmoticon]matchesInString:text.string options:kNilOptions range:text.yy_rangeOfAll];
    NSUInteger clipLength = 0;
    for (NSTextCheckingResult *emo in emoticonResults) {
        if (emo.range.location == NSNotFound && emo.range.length <= 1) continue;
        NSRange range = emo.range;
        range.location -= clipLength;
        if ([text yy_attribute:YYTextAttachmentAttributeName atIndex:range.location]) continue;
        NSString *emoString = [text.string substringWithRange:range];
        NSString *imagePath = [ParserHelper faceEmoticonDic][emoString];
        UIImage *image = [ParserHelper imageWithPath:imagePath];
        if (!image) continue;
        __block BOOL containsBindingRange = NO;
        [text enumerateAttribute:YYTextBindingAttributeName inRange:range options:NSAttributedStringEnumerationLongestEffectiveRangeNotRequired usingBlock:^(id value, NSRange range, BOOL *stop) {
            if (value) {
                containsBindingRange = YES;
                *stop = YES;
            }
        }];
        if (containsBindingRange) continue;
        YYTextBackedString *backed = [YYTextBackedString stringWithString:emoString];
        
        NSMutableAttributedString *emoText = [NSMutableAttributedString yy_attachmentStringWithContent:image contentMode:UIViewContentModeScaleAspectFit attachmentSize:CGSizeMake(27.5 + 5, 27.5) alignToFont:[UIFont systemFontOfSize:15] alignment:YYTextVerticalAlignmentCenter];
        // original text, used for text copy
        
        [emoText yy_setTextBackedString:backed range:NSMakeRange(0, emoText.length)];
        [emoText yy_setTextBinding:[YYTextBinding bindingWithDeleteConfirm:NO] range:NSMakeRange(0, emoText.length)];
        
        [text replaceCharactersInRange:range withAttributedString:emoText];
        
        if (selectedRange) {
            *selectedRange = [self _replaceTextInRange:range withLength:emoText.length selectedRange:*selectedRange];
        }
        clipLength += range.length - emoText.length;
    }
   
    text.yy_font = _font;
    text.yy_lineSpacing = _linSpace;
    return YES;
}

// correct the selected range during text replacement
- (NSRange)_replaceTextInRange:(NSRange)range withLength:(NSUInteger)length selectedRange:(NSRange)selectedRange {
    // no change
    if (range.length == length) return selectedRange;
    // right
    if (range.location >= selectedRange.location + selectedRange.length) return selectedRange;
    // left
    if (selectedRange.location >= range.location + range.length) {
        selectedRange.location = selectedRange.location + length - range.length;
        return selectedRange;
    }
    // same
    if (NSEqualRanges(range, selectedRange)) {
        selectedRange.length = length;
        return selectedRange;
    }
    // one edge same
    if ((range.location == selectedRange.location && range.length < selectedRange.length) ||
        (range.location + range.length == selectedRange.location + selectedRange.length && range.length < selectedRange.length)) {
        selectedRange.length = selectedRange.length + length - range.length;
        return selectedRange;
    }
    selectedRange.location = range.location + length;
    selectedRange.length = 0;
    return selectedRange;
}


@end
