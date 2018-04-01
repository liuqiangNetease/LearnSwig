//
//  LuaUtil.h
//  LuaSwig
//
//  Created by 刘强 on 2018/4/1.
//  Copyright © 2018年 刘强. All rights reserved.
//

#ifndef LuaUtil_h
#define LuaUtil_h
extern "C"
{
    
#include "lualib.h"
#include "../LuaSwig/lua-5.3.4/src/lauxlib.h"
}

class LuaUtil
{
public:
    static void DumpStack( lua_State * const state );
    static void DumpTable( lua_State * const state );
    static void DumpValue( lua_State * const state , int const idx );
    static void PrintStack( lua_State * const state , char const * const file , int const line );
    static void PrintTable(lua_State *L, int index);
};

#endif /* LuaUtil_h */
