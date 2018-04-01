//
//  LuaUtil.cpp
//  LuaSwig
//
//  Created by 刘强 on 2018/4/1.
//  Copyright © 2018年 刘强. All rights reserved.
//

#include "LuaUtil.h"

#define WRAP_LOG printf
void LuaUtil::PrintTable(lua_State *L, int index)
{
    printf("Begin Table:\n");
    // Push another reference to the table on top of the stack (so we know
    // where it is, and this function can work for negative, positive and
    // pseudo indices
    lua_pushvalue(L, index);
    // stack now contains: -1 => table
    lua_pushnil(L);
    // stack now contains: -1 => nil; -2 => table
    while (lua_next(L, -2))
    {
        // stack now contains: -1 => value; -2 => key; -3 => table
        // copy the key so that lua_tostring does not modify the original
        lua_pushvalue(L, -2);
        // stack now contains: -1 => key; -2 => value; -3 => key; -4 => table
        printf("%s => %s\n", lua_tostring(L, -1), lua_tostring(L, -2));
        // pop value + copy of key, leaving original key
        lua_pop(L, 2);
        // stack now contains: -1 => key; -2 => table
    }
    // stack now contains: -1 => table (when lua_next returns 0 it pops the key
    // but does not push anything.)
    // Pop table
    lua_pop(L, 1);
    printf("end Table: \n");
    // Stack is now the same as it was on entry to this function
}

void LuaUtil::DumpStack( lua_State * const state )
{
    
    WRAP_LOG( "--begin dump lua stack--\n" );
    int i = 0;
    int top = lua_gettop( state );
    for( i = top; i >= 1; --i )
    {
        DumpValue( state , i );
    }
    WRAP_LOG( "--end dump lua stack--\n" );
}

void LuaUtil::DumpTable( lua_State * const state )
{
    WRAP_LOG( "begin dump lua table\n" );
    
    int it = lua_gettop( state );
    lua_pushnil( state );
    
    while( lua_next( state , it ) )
    {
        DumpValue( state , -1 );
        lua_pop( state , 1 );
    }
    
    WRAP_LOG( "end dump lua table\n\n" );
}

void LuaUtil::DumpValue( lua_State * const state , int const idx )
{
    int t = lua_type( state , idx );
    switch( t )
    {
        case LUA_TNONE:
            WRAP_LOG( "LUA_TNONE: \n" );
            break;
        case LUA_TNIL:
            WRAP_LOG( "LUA_TNIL: \n" );
            break;
        case LUA_TBOOLEAN:
            WRAP_LOG( "LUA_TBOOLEAN: %s\n" , lua_toboolean( state , idx ) ? "true " : "false ");
            break;
        case LUA_TLIGHTUSERDATA:
            WRAP_LOG( "LUA_TLIGHTUSERDATA: \n" );
            break;
        case LUA_TNUMBER:
            WRAP_LOG( "LUA_TNUMBER: %g\n", lua_tonumber( state , idx ) );
            break;
        case LUA_TSTRING:
            WRAP_LOG( "LUA_TSTRING: '%s'\n" , lua_tostring( state , idx ) );
            break;
        case LUA_TTABLE:
            WRAP_LOG( "LUA_TTABLE:\n" );
            break;
        case LUA_TFUNCTION:
            WRAP_LOG( "LUA_TFUNCTION:\n" );
            break;
        case LUA_TUSERDATA:
            WRAP_LOG( "LUA_TUSERDATA:\n" );
            break;
        case LUA_TTHREAD:
            WRAP_LOG( "LUA_TTHREAD:\n" );
            break;
        default:
            WRAP_LOG( "%s\n", lua_typename( state , idx ) );
            break;
    }
}

void LuaUtil::PrintStack( lua_State * const state
                        , char const * const file , int const line )
{
    WRAP_LOG( "stack size is %d\n\t(%s | %d)\r\n"
             , lua_gettop( state )
             , file , line );
}

