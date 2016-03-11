---
layout: post
title: "OpenGL Write Bitmap Text with Color"
date: 2015-01-02 21:43:00
categories: OpenGL
---
OpenGL does not provide support for fonts, and hence does not provide support
for "text". But GLUT supports bitmap text with a limited number of fonts. The
function glutBitmapCharacter is used to print a bitmap character at a 3D
position inside the model. A series of characters can be printer using
glutBitmapCharacter which makes a string like functionality.


This small snippet will print a text.

```cpp
// The character array to hole the string
char text[] = "The text I want to print";
// The color, red for me
glColor3f(1, 0, 0);
// Position of the text to be printer
glRasterPos3f(x, y, z);
for(int i = 0; text[i] != '\0'; i++)
    glutBitmapCharacter(GLUT_BITMAP_HELVETICA_18, text[i]);
```
Let's test this with an example. I wrote a code that rotates a blue cube by
keystrokes. I will print the rotation value of X and Y axis on the screen. So,
I used sprintf() to print the rotation value into the character array.
Basically the arrangement looks like this.

```cpp
void text()
{
    char text[32];
    sprintf(text, "X:%.0f Y:%.0f", xrot, yrot);
    glColor3f(1, 1, 0);
    glRasterPos3f( -25 , 20 , zoom);
    for(int i = 0; text[i] != '\0'; i++)
        glutBitmapCharacter(GLUT_BITMAP_HELVETICA_18, text[i]);
}
```

Now I am going to call the function text from my render function of OpenGL. My
code to draw the whole scene is,

```cpp
#include <GL/gl.h>
#include <GL/glu.h>
#include <GL/glut.h>
#include <cstdio>

float xrot = 0.00, yrot = 0.00, zoom = -30;

void text()
{
    char text[32];
    sprintf(text, "X:%.0f Y:%.0f", xrot, yrot);
    glColor3f(0, 0, 0);
    glRasterPos3f( -25 , 20 , zoom);
    for(int i = 0; text[i] != '\0'; i++)
        glutBitmapCharacter(GLUT_BITMAP_HELVETICA_18, text[i]);
}

void render(void)
{
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
    glLoadIdentity();

    glTranslatef(0, 0, zoom);

    // Write the text before any transformation or rotation
    // Or the text will change its position with the models
    text();

    glRotatef(xrot, 1, 0, 0);
    glRotatef(yrot, 0, 1, 0);

    // Blue Cube
    glColor3f(0.0, 0.5, 0.9);
    glutSolidCube(10);

    glFlush();
    glutSwapBuffers();
}

void init(void)
{
    glClearColor( 1, 1, 1, 1);
    glClearDepth( 1.0 );
    glEnable(GL_DEPTH_TEST);
    glEnable(GL_LIGHTING);
    glShadeModel(GL_SMOOTH);
    glEnable(GL_COLOR_MATERIAL);
    glColorMaterial(GL_FRONT, GL_AMBIENT_AND_DIFFUSE);
    glEnable(GL_LIGHT0);
}

void reshape(int w, int h)
{
    float aspectRatio = (float)w/(float)h;
    glMatrixMode(GL_PROJECTION);
    glLoadIdentity();
    gluPerspective(45, aspectRatio, 1.0, 100.0);
    glMatrixMode(GL_MODELVIEW);
}

void keyboard(unsigned char key, int x, int y)
{
    switch(key)
    {
    case 's':
        xrot -= 1.0;
        break;
    case 'a':
        yrot -= 1.0;
        break;
    case 'w':
        xrot += 1.0;
        break;
    case 'd':
        yrot += 1.0;
        break;
    case 27:
        exit(0);
    }
    glutPostRedisplay();
}

int main(int argc, char** argv)
{
    glutInit(&argc,argv);
    glutInitDisplayMode(GLUT_DOUBLE | GLUT_RGB | GLUT_DEPTH );
    glutInitWindowSize(400, 300);
    glutCreateWindow("Bitmap Text Example");
    init();
    glutKeyboardFunc(keyboard);
    glutReshapeFunc(reshape);
    glutDisplayFunc(render);
    glutMainLoop();
    return 0;
}
```

Now save and run the code with appropriate linkers. Mine looks like this.

[![GLUT Bitmap Text](http://i.imgur.com/GhQQN7N.png)](http://i.imgur.com/GhQQN7N.png) You see the black text at top-left corner of the screen? Why I rotate the cube with W/A/S/D, the values of X and Y changes and that is printed. I used raster point (-25,20) which makes it top-left aligned. You can use custom color, position etc.

If this post does not work for you, let me know.

