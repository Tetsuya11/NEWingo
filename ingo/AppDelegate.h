//
//  AppDelegate.h
//  ingo
//
//  Created by 一野哲也 on 2015/07/30.
//  Copyright (c) 2015年 TetsuyaIchino. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>{

NSString *categoryName;

    
NSString *largeCate;
    
NSString *categoryImage;
NSArray *categoryCommentary;

NSString *categoryName1;
    
NSString *idStr;
    
NSString *title;
    
NSString *cateAry;//cateで定義

NSString *mada;

NSString *mainImage;

int iPath;

NSDictionary *_dic;
    

}
@property (nonatomic,strong) NSString *categoryName;

@property (nonatomic,strong) NSString *categorydetail;

@property (nonatomic,strong) NSString *detail;



@property (nonatomic,strong) NSString *largeCate;
@property (nonatomic,strong) NSString *categoryImage;
@property (nonatomic,strong) NSArray *categoryCommentary;

@property (nonatomic,assign) int iPath;

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic,strong) NSString *categoryName1;

@property (strong,nonatomic) NSString *idStr;

@property (strong,nonatomic) NSArray *arr;

@property (strong,nonatomic)NSString *arr2;

@property (nonatomic,assign) int iPath2;

@property (strong,nonatomic)NSString *title;

@property (nonatomic,strong) NSString *cateAry;

@property (strong,nonatomic)NSString *mainImage;

@property (nonatomic,strong)NSDictionary *_dic;

@end

