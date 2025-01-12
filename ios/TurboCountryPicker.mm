#import "TurboCountryPicker.h"
#import "react_native_turbo_country_picker-Swift.h"


@implementation TurboCountryPicker {
  CountryPickerImpl *countryPickerImpl;
}

- (instancetype) init {
    self = [super init];
    
    if (self) {
      countryPickerImpl = [CountryPickerImpl new];
    }
    
    return self;
}

RCT_EXPORT_MODULE()

- (std::shared_ptr<facebook::react::TurboModule>)getTurboModule:
    (const facebook::react::ObjCTurboModule::InitParams &)params
{
    return std::make_shared<facebook::react::NativeTurboCountryPickerSpecJSI>(params);
}

- (void)openPicker:(RCTResponseSenderBlock)onCountrySelect {
    [countryPickerImpl openPickerOnCountrySelect:^(NSString * _Nonnull selectedCountry) {
        onCountrySelect(@[selectedCountry]);
    }];
}

@end
