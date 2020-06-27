//
//  CusPickerView.m
//  MallApp
//
//  Created by Mac on 2020/1/11.
//  Copyright © 2020 Mac. All rights reserved.
//
#define SCREEN_WIDTH                [[UIScreen mainScreen] bounds].size.width
#define SCREEN_HEIGHT               [[UIScreen mainScreen] bounds].size.height
#define PICKERVIEW_HEIGHT           230*AdapterHeightScal

#import "CusPickerView.h"
@interface CusPickerView ()<UIPickerViewDelegate,UIPickerViewDataSource>


@property (strong, nonatomic) UIView *baseView;
@property (strong, nonatomic) UIButton *cancelBtn;
@property (strong, nonatomic) UIButton *okBtn;

@property (nonatomic, strong) NSString *BuyerId;
@property (nonatomic, strong) NSString *Buyername;
@property (nonatomic, strong) NSString *value;
@end

@implementation CusPickerView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self initProp];
    
        self.backgroundColor = [UIColor clearColor];
        _baseView = [[UIView alloc] initWithFrame:CGRectMake(0, Screen_Height-PICKERVIEW_HEIGHT, Screen_Width, PICKERVIEW_HEIGHT)];
        _baseView.backgroundColor = self.baseViewColor;
        [self addSubview:_baseView];
        
        UIButton *btnOK = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-50, 0, 40, 40)];
        [btnOK setTitle:@"确定" forState:UIControlStateNormal];
        [btnOK setTitleColor:self.btnTitleColor forState:UIControlStateNormal];
        [btnOK addTarget:self action:@selector(pickerViewBtnOK:) forControlEvents:UIControlEventTouchUpInside];
        _okBtn = btnOK;
        [_baseView addSubview:btnOK];
        
        UIButton *btnCancel = [[UIButton alloc] initWithFrame:CGRectMake(10, 0, 40, 40)];
        [btnCancel setTitle:@"取消" forState:UIControlStateNormal];
        [btnCancel setTitleColor:self.btnTitleColor forState:UIControlStateNormal];
        [btnCancel addTarget:self action:@selector(pickerViewBtnCancel:) forControlEvents:UIControlEventTouchUpInside];
        _cancelBtn = btnCancel;
        [_baseView addSubview:btnCancel];
        
        _pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 40, SCREEN_WIDTH, PICKERVIEW_HEIGHT-40)];
        _pickerView.delegate = self;
        _pickerView.dataSource = self;
        _pickerView.backgroundColor = [UIColor whiteColor];
        [_baseView addSubview:_pickerView];
        
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissPickerView)];
        [self addGestureRecognizer:tapGesture];

        
    }
    return self;
}

- (void)initProp{
    self.baseViewColor = APPColor;
    self.btnTitleColor = [UIColor whiteColor];
    self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
}


- (void)setBaseViewColor:(UIColor *)baseViewColor{
    _baseViewColor = baseViewColor;
    _baseView.backgroundColor = baseViewColor;
}

- (void)setBtnTitleColor:(UIColor *)btnTitleColor{
    _btnTitleColor = btnTitleColor;
    [_cancelBtn setTitleColor:btnTitleColor forState:0];
    [_okBtn setTitleColor:btnTitleColor forState:0];
}

- (void)setDataArr:(NSArray *)dataArr{
    _dataArr = dataArr;
    NSDictionary *dic = dataArr.firstObject;
    self.BuyerId = [NSString stringWithFormat:@"%@",dic[@"job_id"]];
    self.Buyername =  [NSString stringWithFormat:@"%@",dic[@"job_name"]];
    self.value = [NSString stringWithFormat:@"%@",dic[@"value"]];
    [self.pickerView reloadAllComponents];
}

//返回多少列
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

//每列对应多少行
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return self.dataArr.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    NSDictionary *dic = self.dataArr[row];
    return [NSString stringWithFormat:@"%@",dic[@"job_name"]];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    NSDictionary *dic = self.dataArr[row];
    self.BuyerId = [NSString stringWithFormat:@"%@",dic[@"job_id"]];
    self.Buyername =  [NSString stringWithFormat:@"%@",dic[@"job_name"]];
    self.value = [NSString stringWithFormat:@"%@",dic[@"value"]];
}


//弹出pickerView
- (void)popPickerView
{
    [UIView animateWithDuration:0.5
                     animations:^{
        self.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    }];
    
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self dismissPickerView];
}

//取消pickerView
- (void)dismissPickerView
{
    [UIView animateWithDuration:0.5
                     animations:^{
                         self.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT);
                     }];
}

//确定
- (void)pickerViewBtnOK:(id)sender
{
    
    if (self.selectBlock)
    {
        self.selectBlock(self.BuyerId, self.Buyername, [XJUtil insertStringWithNotNullObject:self.value andDefailtInfo:@""]);
    }
    [self dismissPickerView];
}

//取消
- (void)pickerViewBtnCancel:(id)sender
{

    
    [self dismissPickerView];
    
}


@end
