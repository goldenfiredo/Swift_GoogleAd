//
//  TextFlowView.m
//  Paoma
//

#import "TextFlowView.h"

#define SPACE_WIDTH 50

@implementation TextFlowView
- (CGRect)moveNewPoint:(CGPoint)point rect:(CGRect)rect
{
    CGSize tmpSize;
    tmpSize.height = rect.size.height + (rect.origin.y - point.y);
    tmpSize.width = rect.size.width + (rect.origin.x - point.x);
    return CGRectMake(point.x, point.y, tmpSize.width, tmpSize.height);
}

- (void)startRun
{
    _timer = [NSTimer scheduledTimerWithTimeInterval:0.02 target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
}

- (void)cancelRun
{
    if (_timer) 
    {
        [_timer invalidate];
    }
}

- (void)timerAction
{
    static CGFloat offsetOnce = -1;
    _XOffset += offsetOnce;
    if (_XOffset +  _textSize.width <= 0) 
    {
        _XOffset += _textSize.width;
        _XOffset += SPACE_WIDTH;
    }
    [self setNeedsDisplay];
    
}

- (CGSize)computeTextSize:(NSString *)text
{
    if (text == nil) 
    {
        return CGSizeMake(0, 0);
    }
    CGSize boundSize = CGSizeMake(10000, 100);
    CGSize stringSize = [_text sizeWithFont:_font constrainedToSize:boundSize lineBreakMode:UILineBreakModeWordWrap];
    return stringSize;
}


- (id)initWithFrame:(CGRect)frame Text:(NSString *)text
{
    self = [super initWithFrame:frame];
    if (self) 
    {
        _text = text;
        _frame = frame;
        _font = [UIFont systemFontOfSize:16.0F];
        self.backgroundColor = [UIColor whiteColor];
        _textSize = [self computeTextSize:text];
        if (_textSize.width > frame.size.width)
        {
            _needFlow = YES;
            [self startRun];
        }
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    CGContextRef context= UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [UIColor blueColor].CGColor);
    // Drawing code
    CGFloat startYOffset = (rect.size.height - _textSize.height)/2;
    CGPoint origin = rect.origin;
    if (_needFlow == YES) 
    {
        rect = [self moveNewPoint:CGPointMake(_XOffset, startYOffset) rect:rect];
        while (rect.origin.x <= rect.size.width+rect.origin.x)
        {
            [_text drawInRect:rect withFont:_font];
            rect = [self moveNewPoint:CGPointMake(rect.origin.x+_textSize.width+SPACE_WIDTH, rect.origin.y) rect:rect];
        }
        
    }
    else
    {
        origin.x = (rect.size.width - _textSize.width)/2;
        origin.y = (rect.size.height - _textSize.height)/2;
        rect.origin = origin;
        [_text drawInRect:rect withFont:_font];
    }
}

- (void)setFont:(UIFont *)font
{
    _font = font;
}

- (void)setText:(NSString *)text
{
    _text = text;

}
@end
