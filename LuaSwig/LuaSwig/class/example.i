/* File : example.i */
%module example

%{
#include "example.h"
%}


//%nspace LQEngine::base::ShapeOwner;
//%nspace LQEngine::base::Shape;
//%nspace LQEngine::base::Circle;
//%nspace LQEngine::base::Square;
// before we grab the header file, we must warn SWIG about some of these functions.

//// these functions create data, so must be managed
//%newobject createCircle;
//%newobject createSquare;
//
//// this method returns as pointer which must be managed
//%newobject LQEngine::ShapeOwner::remove;
//
//// you cannot use %delobject on ShapeOwner::add()
//// as this disowns the ShapeOwner, not the Shape (oops)
////%delobject ShapeOwner::add(Shape*); DO NOT USE
//
//// either you can use a new function (such as this)
///*%delobject add_Shape;
//%inline %{
//void add_Shape(Shape* s,ShapeOwner* own){own->add(s);}
//%}*/
//
//// or a better solution is a typemap
//%apply SWIGTYPE *DISOWN {LQEngine::Shape* ptr};

// now we can grab the header file
%include "example.h"



%native(Test_addClick) int _Test_static_addClick( lua_State * L );
%{
    int _Test_static_addClick( lua_State * L )
    {
        printf("addClick()\n");
        return 0;
    }
%}

%header
%{
    //header
//    #undef SWIG_LUA_MODULE_GLOBAL
%}

%begin
%{
        //begin
    

%}

%wrapper
%{
    static int _wrap_new_Test(lua_State* L) {
        return 1;
    }
    
    
    static void swig_delete_Test(void *obj) {
       
    }
    static int _proxy__wrap_new_Test(lua_State *L) {
        assert(lua_istable(L,1));
        lua_pushcfunction(L,_wrap_new_Test);
        assert(!lua_isnil(L,-1));
        lua_replace(L,1); /* replace our table with real constructor */
        lua_call(L,lua_gettop(L)-1,1);
        return 1;
    }
%}

%init
%{
    static swig_lua_attribute swig_Test_attributes[] = {
        {0,0,0}
    };
    static swig_lua_method swig_Test_methods[]= {
        {0,0}
    };
    static swig_lua_method swig_Test_meta[] = {
        {0,0}
    };
    
    static swig_lua_attribute swig_Test_Sf_SwigStatic_attributes[] = {
        {0,0,0}
    };
    static swig_lua_const_info swig_Test_Sf_SwigStatic_constants[]= {
        {0,0,0,0,0,0}
    };
    static swig_lua_method swig_Test_Sf_SwigStatic_methods[]= {
        {"add", _Test_static_addClick},
        {0,0}
    };
    static swig_lua_class* swig_Test_Sf_SwigStatic_classes[]= {
        0
    };
    
    static swig_lua_namespace swig_Test_Sf_SwigStatic = {
        "Test",
        swig_Test_Sf_SwigStatic_methods,
        swig_Test_Sf_SwigStatic_attributes,
        swig_Test_Sf_SwigStatic_constants,
        swig_Test_Sf_SwigStatic_classes,
        0
    };
    static swig_lua_class *swig_Test_bases[] = {0};
    static const char *swig_Test_base_names[] = {0};
    static swig_lua_class _wrap_class_Test = { "Test", "Test", nullptr,_proxy__wrap_new_Test, swig_delete_Test, swig_Test_methods, swig_Test_attributes, &swig_Test_Sf_SwigStatic, swig_Test_meta, swig_Test_bases, swig_Test_base_names };

    SWIG_Lua_namespace_register(L, &swig_Test_Sf_SwigStatic, 1);

    
    /* exec Lua code if applicable */
    SWIG_Lua_dostring(L,SWIG_LUACODE);
%}

%luacode{
    Global = example
}



