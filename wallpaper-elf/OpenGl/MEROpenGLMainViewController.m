//
//  MEROpenGLMainViewController.m
//  wallpaper-elf
//
//  Created by 马遥 on 2018/1/19.
//  Copyright © 2018年 mervin. All rights reserved.
//

#import "MEROpenGLMainViewController.h"

@interface MEROpenGLMainViewController () <GLKViewDelegate>
@property (nonatomic, assign) GLfloat xUnit;
@property (nonatomic, assign) GLfloat yUnit;
@property (nonatomic, strong) EAGLContext *mContext;
@property (nonatomic, strong) GLKBaseEffect *mEffect;
@property (nonatomic, strong) UIImage *image;
@end

@implementation MEROpenGLMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self countImageSize];
    [self setupConfig];
    [self uploadVertexArray];
    [self uploadTexture];
}

- (void)countImageSize {
    CGFloat screenRatio = SCREEN_HEIGHT / SCREEN_WIDTH;
    
    CGSize imageSize = self.image.size;
    CGFloat imageRatio = imageSize.height / imageSize.width;
    if (imageRatio < screenRatio) {
        self.yUnit = 1.0f;
        self.xUnit = screenRatio / imageRatio;
    } else {
        self.xUnit = 1.0f;
        self.yUnit = imageRatio / screenRatio;
    }
}

- (void)setupConfig {
    // 使用OpenGL ES 2.0
    self.mContext = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];

    GLKView *view = (GLKView *)self.view;
    view.delegate = self;
    view.context = self.mContext;
    view.drawableColorFormat = GLKViewDrawableColorFormatRGBA8888;
    [EAGLContext setCurrentContext:self.mContext];
}

- (void)uploadVertexArray {
    GLfloat squareVertexData[] = {
        // 第一个三角形
        /**
            ***********
              *       *
                *     *
                  *   *
                    * *
                      *
         */
        self.xUnit, -self.yUnit, 0.0f,      1.0f, 0.0f,     // 右下
        self.xUnit, self.yUnit, 0.0f,       1.0f, 1.0f,     // 右上
        -self.xUnit, self.yUnit, 0.0f,      0.0f, 1.0f,     // 左上
        // 第二个三角形
        /**
         *
         *  *
         *    *
         *      *
         *        *
         ************

         */
        self.xUnit, -self.yUnit, 0.0f,      1.0f, 0.0f,     // 右下
        -self.xUnit, self.yUnit, 0.0f,      0.0f, 1.0f,     // 左上
        -self.xUnit, -self.yUnit, 0.0f,     0.0f, 0.0f,     // 左下
    };

    GLuint buffer;// 创建缓冲区
    glGenBuffers(1, &buffer);// 申请标识符
    glBindBuffer(GL_ARRAY_BUFFER, buffer);// 绑定标识符到 GL_ARRAY_BUFFER
    glBufferData(GL_ARRAY_BUFFER, sizeof(squareVertexData), squareVertexData, GL_STATIC_DRAW);// 从CPU内存中复制顶点数据（数组）到GPU内存

    glEnableVertexAttribArray(GLKVertexAttribPosition);// 缓存顶点数据
    glVertexAttribPointer(GLKVertexAttribPosition, 3, GL_FLOAT, GL_FALSE, sizeof(GLfloat) * 5, (GLfloat *)NULL + 0);// 设置缓冲区数据读取格式（如何读取顶点数组中的顶点数据）
    glEnableVertexAttribArray(GLKVertexAttribTexCoord0);// 缓存纹理
    glVertexAttribPointer(GLKVertexAttribTexCoord0, 2, GL_FLOAT, GL_FALSE, sizeof(GLfloat) * 5, (GLfloat *)NULL + 3);// 设置缓冲区数据读取格式（如何读取顶点数组中的纹理数据）

}

- (void)uploadTexture {
    // 根据图片资源获得纹理贴图数据
    NSData *imageData = UIImagePNGRepresentation(self.image);
    GLKTextureInfo *textureInfo = [GLKTextureLoader textureWithContentsOfData:imageData options:@{GLKTextureLoaderOriginBottomLeft: @1} error:NULL];

    // 创建着色器，将纹理数据赋值给着色器
    self.mEffect = [[GLKBaseEffect alloc] init];
    self.mEffect.texture2d0.enabled = GL_TRUE;
    self.mEffect.texture2d0.name = textureInfo.name;

}

#pragma mark - 渲染场景代码 - GLKViewDelegate

/**
 *  渲染场景代码
 */
- (void)glkView:(GLKView *)view drawInRect:(CGRect)rect {
    glClearColor(0.2f, 0.53f, 0.85f, 1.0f);
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);

    // 启动着色器
    [self.mEffect prepareToDraw];
    glDrawArrays(GL_TRIANGLES, 0, 6);
}

#pragma mark - 图片资源以及高宽数据

- (UIImage *)image {
    if (!_image) {
        _image = [UIImage imageNamed:@"sakura_bicycle"];
    }
    return _image;
}

@end
