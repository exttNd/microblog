//
//  WalletViewController.m
//  MSI钱包
//
//  Created by XM on 16/11/12.
//  Copyright © 2016年 XM. All rights reserved.
//

#import "WalletViewController.h"
#import "TurnAccountContactsViewController.h"
#import "SendPackageMoneyViewController.h"
#import "UpdatePasswordViewController.h"
#import "FuntionPermissionUtil.h"

@interface WalletViewController ()

@property (weak, nonatomic) IBOutlet UILabel *freshAccount;//新员工账户
@property (weak, nonatomic) IBOutlet UILabel *leadAccount;//领导账户（個人賬戶）
@property (weak, nonatomic) IBOutlet UILabel *chargeAccount;//充值账户
@property (weak, nonatomic) IBOutlet UILabel *awardAccount;//奖金账户
@property (weak, nonatomic) IBOutlet UILabel *overdriftAccount;//透支账户
@property (weak, nonatomic) IBOutlet UISwitch *overiftAccountOnOff;//透支账户开关

@property (weak, nonatomic) IBOutlet UILabel *totalMoneyLb;


@property (weak, nonatomic) IBOutlet UIView *overiftAccountLayout; 
@property(nonatomic,strong)AccountInfoEntity *accountInfoEntity;
@property(nonatomic,strong)FuntionPermissionUtil *funtionPermissionUtil;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *overdriftAccoutHeight;

@end

@implementation WalletViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.funtionPermissionUtil=[[FuntionPermissionUtil alloc]init];
    [self initView];
}

-(void)initView{
  self.title=@"集點包";
  [self.overiftAccountOnOff addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
   if(![self.funtionPermissionUtil checkFunPermissionWithCode:WT_API_APP_OVERDRAW_MGT]) {
       self.overiftAccountLayout.hidden=YES;
       self.overdriftAccoutHeight.constant=0;
   }else{
     
   }
}

-(void)viewWillAppear:(BOOL)animated{
    [self iniData];
}

-(void)iniData{
  [self showLoadingDialog];
  [WalletApi getPersonalAccountInfo:^(AccountInfoEntity *accountInfoEntity) {
     [self hidenLoadingDialog];
      if ([accountInfoEntity.SYS_HEAD.RET_CODE isEqualToString:@"2000"]) {
          self.accountInfoEntity=accountInfoEntity;
          
      }else{
          [self showToast:accountInfoEntity.SYS_HEAD.RET_MSG];
      }
  } failure:^(NSError *err) {
      [self hidenLoadingDialog];
  }];
}

-(void)setAccountInfoEntity:(AccountInfoEntity *)accountInfoEntity{
    _accountInfoEntity=accountInfoEntity;
    self.freshAccount.text=[NSString stringWithFormat:@"%.2f",[accountInfoEntity.refreshArrivalMoney doubleValue]];
    self.leadAccount.text=[NSString stringWithFormat:@"%.2f",[accountInfoEntity.chargeAccountMoney doubleValue]];//個人賬戶
    self.chargeAccount.text=[NSString stringWithFormat:@"%.2f",[accountInfoEntity.preRechargeMoney doubleValue]];
    self.awardAccount.text=[NSString stringWithFormat:@"%.2f",[accountInfoEntity.awardAccountMoney doubleValue]];
    self.overdriftAccount.text=[NSString stringWithFormat:@"%.2f",[accountInfoEntity.overdriftAccountMoney doubleValue]];
    if ([accountInfoEntity.overdriftAccount isEqualToString:@"1"]) {
       [self.overiftAccountOnOff setOn:YES];
    }else{
       [self.overiftAccountOnOff setOn:NO];
    }
    
    //总金额
    double totalMoney=[accountInfoEntity.refreshArrivalMoney doubleValue]+[accountInfoEntity.chargeAccountMoney doubleValue]+[accountInfoEntity.preRechargeMoney doubleValue]+[accountInfoEntity.awardAccountMoney doubleValue];
    self.totalMoneyLb.text=[NSString stringWithFormat:@"總金額：%.2f",totalMoney];
}

//轉賬按鈕點擊
- (IBAction)turnAcBtnOnClick:(id)sender {
    if ([self.funtionPermissionUtil checkFunPermissionWithCode:WT_API_APP_TRANSFER_MGT]) {
        TurnAccountContactsViewController *turnVc=[[TurnAccountContactsViewController alloc]init];
        [self.navigationController pushViewController:turnVc animated:YES];
    }else{
         [self showToast:@"您无此权限"];
    }
}
//發紅包按鈕點擊
- (IBAction)packageBtnOnClick:(id)sender {
    if ([self.funtionPermissionUtil checkFunPermissionWithCode:WT_API_APP_SENDREDPACKAGE_MGT]) {
        SendPackageMoneyViewController *packageVc=[[SendPackageMoneyViewController alloc]init];
        [self.navigationController pushViewController:packageVc animated:YES];
    }else{
       [self showToast:@"您无此权限"];
    }
   
}
//支付密碼點擊
- (IBAction)payPwdBtnOnClick:(id)sender {
    UpdatePasswordViewController *vc=[[UpdatePasswordViewController alloc]init];
    vc.isUpdatePayPassword=YES;
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)switchAction:(id)sender
{
    UISwitch *switchButton = (UISwitch*)sender;
    BOOL isButtonOn = [switchButton isOn];
    if (isButtonOn) {
        NSLog(@"======打开======");
        //[self updateLoginPwd:@"1"];
        [self showOverdrawOnWarmDialog];
    }else {
        NSLog(@"======关闭======");
        [self updateLoginPwd:@"0"];
    }
}

-(void)updateLoginPwd:(NSString*)isOpen{
    [self showLoadingDialog];
    [WalletApi updateOverdrawSwitch:isOpen success:^(ResultEntity *resultEntity) {
        [self hidenLoadingDialog];
        if ([resultEntity.SYS_HEAD.RET_CODE isEqualToString:@"2000"]) {
            if ([resultEntity.result isEqualToString:@"1"]) {
               
            }else{
                [self showToast:@"修改失敗！請稍後再試！"];
                [self.overiftAccountOnOff setOn:!self.overiftAccountOnOff.isOn];
            }
        }else{
            [self showToast:resultEntity.SYS_HEAD.RET_MSG];
            [self.overiftAccountOnOff setOn:!self.overiftAccountOnOff.isOn];
        }
    } failure:^(NSError *err) {
        [self hidenLoadingDialog];
        [self.overiftAccountOnOff setOn:!self.overiftAccountOnOff.isOn];
    }];
}

-(void)showOverdrawOnWarmDialog{
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle: @""
                                                                              message: @"免責聲明：打開透支開關將開通透支功能，每月工資結算會自動扣除當月透支金額。是否需要開通？"
                                                                       preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [self.overiftAccountOnOff setOn:!self.overiftAccountOnOff.isOn];
    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"確定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [self updateLoginPwd:@"1"];
    }]];
    [self presentViewController:alertController animated:YES completion:nil];

}

@end
