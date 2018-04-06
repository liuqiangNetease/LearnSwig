/* File : example.c */

#include "example.h"
#include <stdio.h>

#define M_PI 3.14159265358979323846


    namespace base
    {
        
        /* Move the shape to a new location */
        void Shape::move(double dx, double dy) {
            x += dx;
            y += dy;
        }
        
        int Shape::nshapes = 0;
        
    }

