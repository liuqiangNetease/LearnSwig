/* File : example.i */
%module example

%{
#include "example.h"
%}


%include "example.h"


%native(ButtonWrap_addClick) int _ButtonWrap_static_addClick( lua_State * L );
%{
    int _ButtonWrap_static_addClick( lua_State * L )
    {
        printf("addClick()\n");
        return 0;
    }
    %}

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

    #include "LuaUtil.h"
%}

%begin
%{
        //begin
    

%}

void LuaScriptAddNativeMethod( lua_State * const L , char const * const class_name, char const * const method_name , lua_CFunction fn )
{
    SWIG_Lua_get_class_registry( L ); // get the registry
    lua_pushstring( L , class_name ); // get the name
    lua_rawget( L , -2 ); // get the metatable itself
    lua_remove( L , -2 ); // tidy up (remove registry)
    
    // If the metatable is not null, add the method to the ".fn" table
    if( lua_isnil( L , -1 ) != 1 )
    {
        SWIG_Lua_get_table( L , ".fn" );
        SWIG_Lua_add_function( L , method_name , fn );
        lua_pop( L , 2 );  // tidy up (remove metatable and ".fn" table)
    }
    else
    {
        printf("LuaScriptAddNativeMethod error: \"%s\" metatable is not found. Method \"%s\" will not be added\n" , class_name , method_name );
        return;
    }
}



void LuaScriptAddNativeStaticMethod
( lua_State * const L
 , char const * const class_name
 , char const * const method_name
 , lua_CFunction fn )
{
    SWIG_Lua_get_table( L , class_name );
    if( lua_isnil( L , -1 ) == 1 )
    {
        lua_pop( L , 1 );
        
        lua_pushstring(L, class_name);
        lua_createtable( L , 0 , 0 );
        
        lua_rawset(L, -3);
        
        SWIG_Lua_get_table( L , class_name );
        
        SWIG_Lua_add_function( L , method_name , fn );
        lua_pop(L, 1);
    }
    else
    {
        SWIG_Lua_add_function( L , method_name , fn );
        lua_pop(L, 1);
    }
}




%init
%{
    
    LuaScriptAddNativeStaticMethod( L, "ButtonWrap" , "addClick" , _ButtonWrap_static_addClick );
    LuaScriptAddNativeStaticMethod( L, "Test" , "addClick" , _Test_static_addClick );
%}

// This is code to add a new function to the object's metatable
%wrapper
%{
    void LuaScriptAddNativeMethod( lua_State * const L , char const * const class_name, char const * const method_name , lua_CFunction fn )
    {
        SWIG_Lua_get_class_registry( L ); // get the registry
        lua_pushstring( L , class_name ); // get the name
        lua_rawget( L , -2 ); // get the metatable itself
        lua_remove( L , -2 ); // tidy up (remove registry)
        
        // If the metatable is not null, add the method to the ".fn" table
        if( lua_isnil( L , -1 ) != 1 )
        {
            SWIG_Lua_get_table( L , ".fn" );
            SWIG_Lua_add_function( L , method_name , fn );
            lua_pop( L , 2 );  // tidy up (remove metatable and ".fn" table)
        }
        else
        {
            printf("LuaScriptAddNativeMethod error: \"%s\" metatable is not found. Method \"%s\" will not be added\n" , class_name , method_name );
            return;
        }
    }
    %}

%wrapper
%{
    
    void LuaScriptAddNativeStaticMethod
    ( lua_State * const L
     , char const * const class_name
     , char const * const method_name
     , lua_CFunction fn )
    {

        // find or register the namespace
        SWIG_Lua_get_table( L , class_name );
        //wrap_world::Module::DumpStack( L );
        if( lua_isnil( L , -1 ) == 1 )
        {
            lua_pop( L , 1 );
            lua_createtable( L , 0 , 0 );
            lua_setglobal( L , class_name );
            lua_getglobal(L, class_name);
        }
        
//        // find or register the class
//        lua_pushstring( L , class_name );
//        lua_gettable( L , -2 );
//        if( lua_isnil( L , -1 ) == 1 )
//        {
//            lua_pop( L , 1 );
//            lua_pushstring( L , class_name );
//            lua_createtable( L , 0 , 0 );
//            lua_settable( L , -3 );
//            lua_pushstring( L , class_name );
//            lua_gettable( L , -2 );
//        }
        
      
        SWIG_Lua_add_function( L , method_name , fn );
        lua_pop( L , 2 );

    }
    %}

%luacode{
    Global = example
}



