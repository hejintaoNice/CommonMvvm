
#import "VTGridViewCell.h"
#import "ComicRecommend.h"

@interface VTGridViewCell()

@property (nonatomic, strong)UIView *translucentView;

@property (nonatomic, strong)UIActivityIndicatorView *acView;

@end

@implementation VTGridViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self configUI];
    }
    return self;
}

- (void)configUI{
    
    self.backgroundColor = [UIColor whiteColor];
    
    [self configRadius];
    
    [self addSubview:self.imageView];
    [self addSubview:self.titleLabel];
    [self addSubview:self.translucentView];
    [self.translucentView addSubview:self.commentLabel];
    [self addSubview:self.acView];
    
    [self configConstraints];
    
}

-(UIImageView *)imageView{
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
        _imageView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        _imageView.clipsToBounds = YES;
    }
    return _imageView;
}

-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.font = [UIFont fontWithName:@"Helvetica" size:13.f];
        _titleLabel.numberOfLines = 0;
    }
    return _titleLabel;
}

-(UIView *)translucentView{
    if (!_translucentView) {
        _translucentView  = [[UIView alloc]init];
        _translucentView.backgroundColor = RGBCOLOR(85, 152, 220);
    }
    return _translucentView;
}

-(UILabel *)commentLabel{
    if (!_commentLabel) {
        _commentLabel = [[UILabel alloc] init];
        _commentLabel.textAlignment = NSTextAlignmentRight;
        _commentLabel.font = [UIFont systemFontOfSize:11.f];
        _commentLabel.textColor = [UIColor whiteColor];
    }
    return _commentLabel;
}

-(UIActivityIndicatorView *)acView{
    if (!_acView) {
        _acView  = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        _acView.center = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
    }
    return _acView;
}

-(void)configRadius{
    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(5, 5)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.bounds;
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;
    
}

-(void)configConstraints{
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(self);
        make.bottom.equalTo(self).offset(-34);
    }];
    
    [self.translucentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.imageView);
        make.bottom.equalTo(self.imageView.mas_bottom);
        make.height.equalTo(@20);
    }];
    
    [self.commentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.left.right.equalTo(self.translucentView);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.imageView.mas_bottom);
        make.height.equalTo(@34);
        make.left.right.equalTo(self);
    }];
}


-(void)bindModel:(ComicRecommend*)model{
    
    self.titleLabel.text = model.comic_name;
    self.commentLabel.text = model.last_chapter_name;

    NSString *str = @"http://image.yyhao.com/mh/$$.jpg";
    NSString *strr = [str stringByReplacingOccurrencesOfString:@"$$" withString:[NSString stringWithFormat:@"%@",model.comic_id]];

    [self.acView startAnimating];
    W_S
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:strr] placeholderImage:[UIImage imageNamed:@"404_pic_No data"] options:SDWebImageContinueInBackground | SDWebImageRetryFailed completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
        if ([NSThread isMainThread]) {
            [weakSelf.acView stopAnimating];
        }

    }];
}



@end
