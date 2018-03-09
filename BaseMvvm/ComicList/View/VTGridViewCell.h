
#import <UIKit/UIKit.h>

@interface VTGridViewCell : UICollectionViewCell<HJTBindViewDelegate>

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *commentLabel;

@end
