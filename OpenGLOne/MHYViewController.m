//
//  MHYViewController.m
//  OpenGLOne
//
//  Created by jshtmhy on 2017/8/15.
//  Copyright © 2017年 jshtmhy. All rights reserved.
//

#import "MHYViewController.h"

@implementation MHYViewController
//@synthesize baseEffect;

typedef struct {
    GLKVector3  positionCoords;
}
SceneVertex;

static const SceneVertex verties[] = {
    {{-0.5f, -0.5f, 0.0}}, // 左下角
    {{ 0.5f, -0.5f, 0.0}}, // 右下角
    {{-0.5f,  0.5f, 0.0}}  // 左上角
};
static const SceneVertex colors[] = {
    {{-0.5f, -0.5f, 0.0}}, // 左下角
    {{ 0.5f, -0.5f, 0.0}}, // 右下角
    {{-0.5f,  0.5f, 0.0}}  // 左上角
};
- (void)viewDidLoad {
    [super viewDidLoad];
    // 验证的视图由自动生成的类型界面生成器故事板
    GLKView *openView = (GLKView *)self.view;
    NSAssert([openView isKindOfClass:[GLKView class]],@"View controller's view is not a GLKView");
   
    // 创建一个OpenGL ES 3.0上下文，并将其提供给视图
    openView.context = [[EAGLContext alloc]initWithAPI:kEAGLRenderingAPIOpenGLES3];
    // 设置当前上下文
    [EAGLContext setCurrentContext:openView.context];
   
    // 创建基础效果，即提供标准的OpenGL ES 2.0
    // 着色语言程序，并设置将被用于常量
    // 所有后续呈现
    self.baseEffect = [[GLKBaseEffect alloc]init];
    self.baseEffect.useConstantColor = GL_TRUE;
    self.baseEffect.constantColor = GLKVector4Make(1.0f, 1.0f, 1.0f, 1.0f);
    
    glClearColor(1.0f, 1.0f, 1.0f, 1.0f);// 设置存储在当前上下文中的背景颜色
    
    
}

- (void)glkView:(GLKView *)view drawInRect:(CGRect)rect {
    [self createTriangleVertices];
    [self createColorbuffer];
}
//绘制三角型顶点
-(void) createTriangleVertices{
    [self.baseEffect prepareToDraw];
    
    /*
     GL_COLOR_BUFFER_BIT:    当前可写的颜色缓冲
     GL_DEPTH_BUFFER_BIT:    深度缓冲
     GL_STENCIL_BUFFER_BIT:  缓冲
     */
    glClear(GL_COLOR_BUFFER_BIT); //完成了把整个窗口清除为黑色的任务
    // 生成，绑定，并初始化一个缓冲区存储在GPU存储器
    glGenBuffers(1, &vertexBufferID);
    glBindBuffer(GL_ARRAY_BUFFER, vertexBufferID);
    glBufferData(GL_ARRAY_BUFFER, sizeof(verties),verties, GL_STATIC_DRAW);
    //启动绘三角形命令命令
    glEnableVertexAttribArray(GLKVertexAttribPosition);
    // 设置指针
    /**
     * indx  指示绑定的缓存包含的是顶点位置的信息
     * size  顶点数量
     * type  数据类型
     * normalized  告诉opengl 小数点固定数据是否可以被改变
     * stride  步幅 指定每个顶点保存需要多少个字节
     * ptr  告诉opengl 可以从绑定数据的开始位置访问数据
     **/
    glVertexAttribPointer(GLKVertexAttribPosition, 3, GL_FLOAT, GL_FALSE, sizeof(SceneVertex), NULL);
    //绘图
    glDrawArrays(GL_TRIANGLES, 0, 3);

}
//创建顶点颜色渲染缓冲区
-(void) createColorbuffer{
    [self.baseEffect prepareToDraw];
    glClear(GL_COLOR_BUFFER_BIT);
    glGenBuffers(1, &_colorbuffer);
    glBindBuffer(GL_ARRAY_BUFFER, _colorbuffer);
    glBufferData(GL_ARRAY_BUFFER, sizeof(colors),colors, GL_STATIC_DRAW);
    // 启动绘制颜色命令
    glEnableVertexAttribArray(GLKVertexAttribColor);
    glVertexAttribPointer(GLKVertexAttribColor, 3, GL_FLOAT, GL_FALSE, sizeof(GLfloat), NULL);
    // 绘图
    glDrawArrays(GL_TRIANGLES, 0, 3);
}
@end
