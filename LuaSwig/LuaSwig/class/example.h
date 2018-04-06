/* File : example.h */
#include <vector>


    namespace  base
    {
        class Test
        {
        public:
            int Add(int a, int b) {return a+b;}
            
//            static void addClick()
//            {
//                printf("Test::addClick() \n");
//            }
            
        };
        class Shape {
        public:
            Shape() {
                nshapes++;
                x=1;
                y=0;
            }
            virtual ~Shape() {
                nshapes--;
            }
            double  x, y;
            void    move(double dx, double dy);
            
            static  int nshapes;
        };
}
    



