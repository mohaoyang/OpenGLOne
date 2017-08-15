//
//  MHYViewController.h
//  OpenGLOne
//
//  Created by jshtmhy on 2017/8/15.
//  Copyright © 2017年 jshtmhy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GLKit/GLKit.h>
#import <OpenGLES/ES3/gl.h>
#import <OpenGLES/ES3//glext.h>
@interface MHYViewController : GLKViewController {
    GLuint vertexBufferID;
    GLuint _colorbuffer; // 顶点对应的颜色渲染缓冲区标示
}

@property (nonatomic,strong) GLKBaseEffect *baseEffect;

@end
