//
//  ViewController.h
//  wallpaper-elf
//
//  Created by mervin on 16/7/11.
//  Copyright © 2016年 mervin. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef  NS_ENUM(NSInteger,EvaluationCourseType) {
    EvaluationCourseTypeNormal = 0,     // 无课型数目调整
    EvaluationCourseTypePronunciation,  // 有课型数目调整  0~1
    EvaluationCourseTypeExam            // 有课型数目调整  0~7
};

@interface TeacherEvaluationViewController : UIViewController

@property (nonatomic, strong) NSString *workOrderId;
@property (nonatomic, strong) NSString *figureUrl;
@property (nonatomic, strong) NSString *studentName;
@property (nonatomic, strong) NSString *courseIconUrl;       // 课程背景图片

- (instancetype)initWithWorkOrderId:(NSString *)workOrderId;
@end
