---
layout: post
title: "Draw the Flag of Bangladesh with OpenGL"
date: 2015-01-03 00:21:00
categories: opengl
---
Recently I became interested with OpenGL again. Here is a flag of Bangladesh
which was drawn using OpenGL with exact ratio (10:6).

This OpenGL code uses ModelView projection.

```cpp
#include <GL/glut.h>

void render(void)
{
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
    glLoadIdentity();
    glTranslatef(0, 0, -30);

    // red circle
    glPushMatrix();
    glColor3ub(244, 42, 65);
    glTranslatef(-1, 0, 10);
    glutSolidSphere(5, 50, 50);
    glPopMatrix();

    // green rect
    glColor3ub(0, 106, 77);
    glutSolidCube(25);

    glFlush();
    glutSwapBuffers();
}

void init(void)
{
    glClearColor( 1, 1, 1, 1);
    glClearDepth( 1.0 );
    glEnable(GL_DEPTH_TEST);
    glShadeModel(GL_SMOOTH);
    glEnable(GL_COLOR_MATERIAL);
}

void reshape(int w, int h)
{
    float aspectRatio = (float)w/(float)h;
    glMatrixMode(GL_PROJECTION);
    glLoadIdentity();
    gluPerspective(45, aspectRatio, 1.0, 100.0);
    glMatrixMode(GL_MODELVIEW);
}

int main(int argc, char** argv)
{
    glutInit(&argc,argv);
    glutInitDisplayMode(GLUT_DOUBLE | GLUT_RGB | GLUT_DEPTH );
    glutInitWindowSize(500, 300);
    glutCreateWindow("Flag of Bangladesh");
    init();
    glutReshapeFunc(reshape);
    glutDisplayFunc(render);
    glutMainLoop();
    return 0;
}
```

Here is how it looks.

![BD Flag OpenGL](http://i.imgur.com/DEVMwEr.png)
