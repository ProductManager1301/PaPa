//
//  WeiBoTableViewCell.m
//  DGWeiBo
//
//  Created by 钟伟迪 on 15/5/27.
//  Copyright (c) 2015年 钟伟迪. All rights reserved.
//

#import "WeiBoTableViewCell.h"
#import "DGJSONModel.h"
#import "HTTPRequest.h"


void * _timeContext;
void * _contentContext;

@implementation WeiBoTableViewCell

- (void)awakeFromNib{
    _contentTextLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 60, 280, 40)];
    _contentTextLabel.font = [UIFont systemFontOfSize:16];
    [self.contentView addSubview:_contentTextLabel];
    _contentTextLabel.numberOfLines = 0;
    
    
    [_contentTextLabel addObserver:self forKeyPath:@"text" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:_contentContext];
        
    _imagesView = [[ImageContentView alloc] initWithFrame:CGRectMake(20, 60, 280, 100)];
    
    _imagesView.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1.0];
    
    [self.contentView addSubview:_imagesView];
    
    _headerImageView.layer.masksToBounds = YES;
    _headerImageView.layer.cornerRadius = CGRectGetHeight(_headerImageView.frame)/2.0f;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{

    if (context == _contentContext) {
        CGRect rect = [self.contentTextLabel.text boundingRectWithSize:CGSizeMake(_contentTextLabel.frame.size.width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : _contentTextLabel.font} context:nil];
        
        CGRect contentTextRect = _contentTextLabel.frame;
        contentTextRect.size = rect.size;
        _contentTextLabel.frame = contentTextRect;
        
        CGRect myRect = self.frame;
        myRect.size.height = contentTextRect.size.height + 230.0f;
        self.frame = myRect;
        
        CGRect imagesViewRect = self.imagesView.frame;
        imagesViewRect.origin.y = contentTextRect.size.height + contentTextRect.origin.y + 20;
        self.imagesView.frame = imagesViewRect;
    }
    
}

- (void)setTimeString:(NSString *)timeString{
    _timeString = timeString;
        NSArray * strings = [timeString componentsSeparatedByString:@" "];
        if (strings.count >=4) {
            _timeLabel.text = [NSString stringWithFormat:@"%@",strings[3]];
            
            NSLog(@"%@",strings);
        }
}

- (void)setImageUrls:(NSArray *)imageUrls{
    _imageUrls = imageUrls;
    
    float x = 10;
    float y = 10;
    float width = 60;
    float height = 80;
    
    int i = 0;
    for (PicModel * pic in imageUrls) {
        x = 10 + (width+5)*(i%4);
        y = 10 + (height+5)*(i/4);
        UIImageView  * imageView = [[UIImageView alloc] init];
        imageView.frame = CGRectMake(x, y, width, height);
        imageView.backgroundColor = [UIColor whiteColor];
        [self.imagesView addSubview:imageView];
        i++;

        [HTTPRequest downLoadImage:pic.thumbnail_pic qualityRatio:1.0 pixelRatio:1.0 responseObject:^(id responseObject) {
            imageView.image = responseObject;
        } failure:^(NSError *error, NSString *pathString) {
            NSLog(@"错误");
        }];
        
    }
    
    
    int index = i%4 ? 1 : 0;
    
    //计算图片视图的尺寸
    CGRect imagesViewRect = self.imagesView.frame;
    imagesViewRect.size.height = 20 + (height+5)*(i/4 + index);
    self.imagesView.frame = imagesViewRect;
    
    //重新规划imagesView的尺寸
    CGRect rect = self.frame;
    if (i !=0) {
        rect.size.height = imagesViewRect.size.height + _contentTextLabel.frame.size.height +130;
        self.imagesView.hidden = NO;

    }else{
        rect.size.height = imagesViewRect.size.height + _contentTextLabel.frame.size.height +100;
        self.imagesView.hidden = YES;
    }
    self.frame = rect;
}


- (void)dealloc{
    [_contentTextLabel removeObserver:self forKeyPath:@"text"];
}

@end


@implementation ImageContentView



@end
