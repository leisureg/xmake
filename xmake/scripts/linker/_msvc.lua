--!The Automatic Cross-platform Build Tool
-- 
-- XMake is free software; you can redistribute it and/or modify
-- it under the terms of the GNU Lesser General Public License as published by
-- the Free Software Foundation; either version 2.1 of the License, or
-- (at your option) any later version.
-- 
-- XMake is distributed in the hope that it will be useful,
-- but WITHOUT ANY WARRANTY; without even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-- GNU Lesser General Public License for more details.
-- 
-- You should have received a copy of the GNU Lesser General Public License
-- along with XMake; 
-- If not, see <a href="http://www.gnu.org/licenses/"> http://www.gnu.org/licenses/</a>
-- 
-- Copyright (C) 2009 - 2015, ruki All rights reserved.
--
-- @author      ruki
-- @file        _msvc.lua
--

-- define module: _msvc
local _msvc = _msvc or {}

-- load modules
local rule      = require("base/rule")
local utils     = require("base/utils")
local string    = require("base/string")
local config    = require("base/config")

-- init the linker
function _msvc._init(configs)

    -- the architecture
    local arch = config.get("arch")
    assert(arch)

    -- init flags for architecture
    local flags_arch = ""
    if arch == "x86" then flags_arch = "-machine:x86"
    elseif arch == "x64" then flags_arch = "-machine:x86_64"
    end

    -- init ldflags
    configs.ldflags = "-nologo -dynamicbase -nxcompat -manifest -manifestuac:\"level='asInvoker' uiAccess='false'\" " .. flags_arch

    -- init arflags
    configs.arflags = "-lib -nologo " .. flags_arch

    -- init shflags
    configs.shflags = "-dll -nologo " .. flags_arch

end

-- make the command
function _msvc._make(configs, objfiles, targetfile, flags)

    -- make it
    return string.format("%s %s -out:%s %s", configs.name, flags, targetfile, objfiles)
end

-- make the link flag
function _msvc._make_link(configs, link)

    -- make it
    return link .. ".lib"
end

-- make the linkdir flag
function _msvc._make_linkdir(configs, linkdir)

    -- make it
    return "-libpath:" .. linkdir
end

-- map gcc flag to the current linker flag
function _msvc._mapflag(configs, flag)

    -- ok
    return flag
end

-- return module: _msvc
return _msvc