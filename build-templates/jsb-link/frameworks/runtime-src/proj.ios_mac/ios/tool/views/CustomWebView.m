//
//  CustomWebView.m
//  template
//
//  Created by mac on 17/3/6.
//
//

#import "CustomWebView.h"

@implementation CustomWebView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
#ifdef DEBUG
        self.layer.borderWidth = 1;
        self.layer.borderColor = [[UIColor redColor] CGColor];
#endif
    }
    return self;
}

-(void)awakeFromNib
{
    [super awakeFromNib];
#ifdef DEBUG
    self.layer.borderWidth = 1;
    self.layer.borderColor = [[UIColor redColor] CGColor];
#endif
}
@end
