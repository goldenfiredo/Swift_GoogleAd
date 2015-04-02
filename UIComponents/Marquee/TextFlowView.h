//
//  TextFlowView.h
//  Paoma
//

#import <UIKit/UIKit.h>


@interface TextFlowView : UIView {
    
    UILabel *_firstLabel;
    UILabel *_secondLabel;
    
    NSTimer *_timer;
    
    NSString *_text;
    
    BOOL _needFlow;
    
    CGRect _frame;
    
    UIFont *_font;
    
    NSInteger _startIndex;
    
    CGFloat _XOffset;
    
    CGSize _textSize;
}

- (id)initWithFrame:(CGRect)frame Text:(NSString *)text;
- (void)setFont:(UIFont *)font;
- (void)setText:(NSString *)text;
@end
