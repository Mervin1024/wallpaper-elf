//
//  TagSelectViewController.h
//  YLExperimentForOC
//
//  Created by mingdffe on 16/7/15.
//  Copyright © 2016年 yilin. All rights reserved.
//

#import <UIKit/UIKit.h>

#define ONLINE_BAD_REVIEW_TEACHER       @"ONLINE_BAD_REVIEW_TEACHER"
#define ONLINE_COURSE_REVIEW            @"ONLINE_COURSE_REVIEW"
#define ONLINE_SYSTEM_REVIEW            @"ONLINE_SYSTEM_REVIEW"

typedef NS_ENUM(NSUInteger, StudentEvaluationTagType) {
    TagTypeBadReviewTeacher,
    TagTypeCourseReview,
    TagTypeSystemReview
};

@interface TagSelectViewController : UIViewController

@property (nonatomic, assign) StudentEvaluationTagType evaluationTagType; // 评价类型
@property (nonatomic, copy) NSArray *evaluationTags; // 所有评价条目
@property (nonatomic, copy, readonly) NSArray *selectedTags; // 已选中项目
@property (nonatomic, assign, readonly) CGSize viewSize;
@property (nonatomic, strong) UICollectionView *collectionView;

- (instancetype)initWithEvaluationTagType:(StudentEvaluationTagType)evaluationTagType evaluationTags:(NSArray *)evaluationTags;

@end

@interface StudentEvaluationTag : NSObject

@property (nonatomic, copy) NSString *tagName;
@property (nonatomic, copy) NSString *tagCode;
@property (nonatomic, assign) StudentEvaluationTagType tagType;

- (instancetype)initWithDictionary:(NSDictionary *)dic;

@end