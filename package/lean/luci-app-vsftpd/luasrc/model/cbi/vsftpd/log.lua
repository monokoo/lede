--[[
LuCI - Lua Configuration Interface

Copyright 2016 Weijie Gao <hackpascal@gmail.com>

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

	http://www.apache.org/licenses/LICENSE-2.0

$Id$
]]--
local s=require"nixio.fs"

m = Map("vsftpd", translate("FTP Server - Log Settings"))

sl = m:section(NamedSection, "log", "log", translate("Log Settings"))

o = sl:option(Flag, "syslog", translate("Enable syslog"))
o.default = false

o = sl:option(Flag, "xreflog", translate("Enable file log"))
o.default = true

o = sl:option(Value, "file", translate("Log file"))
o.default="/var/log/vsftpd.log"
o.readonly=true

o = sl:option(TextValue,"log")
o.rows=20
o.wrap="off"
o.readonly=true
o.cfgvalue=function(s1,s1)
return s.readfile("/var/log/vsftpd.log")or""
end
o.write=function(o,o,o)
end

return m
