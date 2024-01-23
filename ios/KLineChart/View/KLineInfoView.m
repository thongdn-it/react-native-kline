//
//  KLineInfoView.m
//  KLine-Chart-OC
//
//  Created by 何俊松 on 2020/3/10.
//  Copyright © 2020 hjs. All rights reserved.
//

#import "KLineInfoView.h"
#import "ChartStyle.h"
#import "KLineStateManager.h"

@interface KLineInfoView()

@property (weak, nonatomic) IBOutlet UILabel *lbTimeText;
@property (weak, nonatomic) IBOutlet UILabel *lbTimeValue;

@property (weak, nonatomic) IBOutlet UILabel *lbOpenText;
@property (weak, nonatomic) IBOutlet UILabel *lbOpenValue;

@property (weak, nonatomic) IBOutlet UILabel *lbHighText;
@property (weak, nonatomic) IBOutlet UILabel *lbHighValue;

@property (weak, nonatomic) IBOutlet UILabel *lbLowText;
@property (weak, nonatomic) IBOutlet UILabel *lbLowValue;

@property (weak, nonatomic) IBOutlet UILabel *lbCloseText;
@property (weak, nonatomic) IBOutlet UILabel *lbCloseValue;

@property (weak, nonatomic) IBOutlet UILabel *lbIncreaseText;
@property (weak, nonatomic) IBOutlet UILabel *lbIncreaseValue;

@property (weak, nonatomic) IBOutlet UILabel *lbAmplitudeText;
@property (weak, nonatomic) IBOutlet UILabel *lbAmplitudeValue;

@property (weak, nonatomic) IBOutlet UILabel *lbAmountText;
@property (weak, nonatomic) IBOutlet UILabel *lbAmountValue;

@end

@implementation KLineInfoView

+(instancetype)lineInfoView {
    KLineInfoView *view = [[NSBundle mainBundle] loadNibNamed:@"KLineInfoView" owner:self options:nil].lastObject;
    view.frame = CGRectMake(0, 0, 120, 145);
  if ([KLineStateManager manager].locales != nil && [KLineStateManager manager].locales.count > 6) {
   view.lbTimeText.text = [KLineStateManager manager].locales[0];
    view.lbOpenText.text = [KLineStateManager manager].locales[1];
    view.lbHighText.text = [KLineStateManager manager].locales[2];
    view.lbLowText.text = [KLineStateManager manager].locales[3];
    view.lbCloseText.text = [KLineStateManager manager].locales[4];
    view.lbIncreaseText.text = [KLineStateManager manager].locales[5];
    view.lbAmplitudeText.text = [KLineStateManager manager].locales[6];
    view.lbAmountText.text = [KLineStateManager manager].locales[7];
  }
    return view;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor = ChartColors_bgColor;
    self.layer.borderWidth = 1;
    self.layer.borderColor = ChartColors_gridColor.CGColor;
}

- (void)setModel:(KLineModel *)model {
    _model = model;
//    _lbTimeValue.text =
    NSNumber *fixedPrice = [KLineStateManager manager].pricePrecision;
    NSNumber *fixedVolume = [KLineStateManager manager].volumePrecision;
    NSString *fixedPriceStr = [NSString stringWithFormat:@"%@%@f", @"%.", fixedPrice];
    NSString *fixedVolumeStr = [NSString stringWithFormat:@"%@%@f", @"%.", fixedVolume];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:model.id];
    NSDateFormatter *formater = [[NSDateFormatter alloc] init];
    formater.dateFormat = @"yyyy-MM-dd HH:mm";
    _lbTimeValue.text = [formater stringFromDate:date];
    
    _lbOpenValue.text = [NSString stringWithFormat:fixedPriceStr,model.open];
     _lbHighValue.text = [NSString stringWithFormat:fixedPriceStr,model.high];
     _lbLowValue.text = [NSString stringWithFormat:fixedPriceStr,model.low];
     _lbCloseValue.text = [NSString stringWithFormat:fixedPriceStr,model.close];
    CGFloat upDown = model.close - model.open;
    NSString *symbol = @"-";
    if(upDown > 0) {
        symbol = @"+";
        self.lbIncreaseValue.textColor = ChartColors_upColor;
        self.lbAmplitudeValue.textColor = ChartColors_upColor;
    } else {
        self.lbIncreaseValue.textColor = ChartColors_dnColor;
        self.lbAmplitudeValue.textColor = ChartColors_dnColor;
    }
    CGFloat upDownPercent = 0.0;
    if (model.open != 0) {
      upDownPercent = upDown / model.open * 100;
    }
    _lbIncreaseValue.text = [NSString stringWithFormat:@"%@%.2f",symbol,ABS(upDown)];
    _lbAmplitudeValue.text = [NSString stringWithFormat:@"%@%.2f%%",symbol,ABS(upDownPercent)];
    _lbAmountValue.text = [NSString stringWithFormat:fixedVolumeStr, model.vol];
    
}

@end
