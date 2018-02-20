//
//  main.c
//  LuaLanuage
//
//  Created by 刘强 on 2018/2/16.
//  Copyright © 2018年 刘强. All rights reserved.
//

#include <stdio.h>


extern "C"
{

#include <lua-5.3.4/src/lualib.h>
#include <lua-5.3.4/src/lauxlib.h>
}


extern "C"
{
    void luaopen_example(lua_State * L);
}

int main (int argc, char **argv) {
    lua_State * L = luaL_newstate();
    luaopen_base( L );
    luaL_openlibs(L);

    luaopen_example(L);
    
    //luaL_dofile(L, "main.lua");
    luaL_dofile(L, "runme.lua");
    
    lua_close(L);
    
    return 0;
}
