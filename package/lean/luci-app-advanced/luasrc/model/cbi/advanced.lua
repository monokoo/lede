local e=require"nixio.fs"
local t=require"luci.sys"
local uci=luci.model.uci.cursor()
m=Map("advanced",translate("高级设置"),translate("各类服务配置文档的直接编辑,除非你知道自己在干什么,否则请不要轻易修改这些配置文档，配置不正确可能会导致不能开机等严重错误。"))
m.apply_on_parse=true
s=m:section(TypedSection,"advanced")
s.anonymous=true
if nixio.fs.access("/etc/dnsmasq.conf")then
s:tab("dnsmasqconf",translate("配置dnsmasq"),translate("本页是配置/etc/dnsmasq.conf的文档内容。编辑后点击重启按钮后生效"))

	o=s:taboption("dnsmasqconf",Button,"_drestart")
	o.inputtitle=translate("重启dnsmasq")
	o.inputstyle="apply"
	
	function o.write(e,e)
	luci.sys.exec("/etc/init.d/dnsmasq restart >/dev/null")
	end

conf=s:taboption("dnsmasqconf",Value,"dnsmasqconf",nil,translate("开头的数字符号（＃）或分号的每一行（;）被视为注释；删除（;）启用指定选项。"))
conf.template="cbi/tvalue"
conf.rows=20
conf.wrap="off"
conf.cfgvalue=function(t,t)
return e.readfile("/etc/dnsmasq.conf")or""
end
conf.write=function(a,a,t)
if t then
t=t:gsub("\r\n?","\n")
e.writefile("/tmp/dnsmasq.conf",t)
if(luci.sys.call("cmp -s /tmp/dnsmasq.conf /etc/dnsmasq.conf")==1)then
e.writefile("/etc/dnsmasq.conf",t)
end
e.remove("/tmp/dnsmasq.conf")
end
end
end
if nixio.fs.access("/etc/config/network")then
s:tab("netwrokconf",translate("配置网络"),translate("本页是配置/etc/config/network的文档内容。编辑后点击重启按钮后生效"))
	o=s:taboption("netwrokconf",Button,"_nrestart")
	o.inputtitle=translate("重启网络")
	o.inputstyle="apply"
	
	function o.write(e,e)
	luci.sys.exec("/etc/init.d/network restart & >/dev/null")
	end
conf=s:taboption("netwrokconf",Value,"netwrokconf",nil,translate("开头的数字符号（＃）或分号的每一行（;）被视为注释；删除（;）启用指定选项。"))
conf.template="cbi/tvalue"
conf.rows=30
conf.wrap="off"
conf.cfgvalue=function(t,t)
return e.readfile("/etc/config/network")or""
end
conf.write=function(a,a,t)
if t then
t=t:gsub("\r\n?","\n")
e.writefile("/tmp/network",t)
if(luci.sys.call("cmp -s /tmp/network /etc/config/network")==1)then
e.writefile("/etc/config/network",t)
end
e.remove("/tmp/network")
end
end
end
if nixio.fs.access("/etc/hosts")then
s:tab("hostsconf",translate("配置hosts"),translate("本页是配置/etc/hosts的文档内容。编辑后点击重启按钮后生效"))
	o=s:taboption("hostsconf",Button,"_hrestart")
	o.inputtitle=translate("重启dnsmasq")
	o.inputstyle="apply"
	
	function o.write(e,e)
	luci.sys.exec("/etc/init.d/dnsmasq restart >/dev/null")
	end
	
conf=s:taboption("hostsconf",Value,"hostsconf",nil,translate("开头的数字符号（＃）或分号的每一行（;）被视为注释；删除（;）启用指定选项。"))
conf.template="cbi/tvalue"
conf.rows=30
conf.wrap="off"
conf.cfgvalue=function(t,t)
return e.readfile("/etc/hosts")or""
end
conf.write=function(a,a,t)
if t then
t=t:gsub("\r\n?","\n")
e.writefile("/tmp/hosts.tmp",t)
if(luci.sys.call("cmp -s /tmp/hosts.tmp /etc/hosts")==1)then
e.writefile("/etc/hosts",t)
end
e.remove("/tmp/hosts.tmp")
end
end
end
if nixio.fs.access("/etc/config/dhcp")then
s:tab("dhcpconf",translate("配置DHCP"),translate("本页是配置/etc/config/DHCP的文档内容。编辑后点击重启按钮后生效"))

	o=s:taboption("dhcpconf",Button,"_drestart")
	o.inputtitle=translate("重启网络")
	o.inputstyle="apply"
	
	function o.write(e,e)
	luci.sys.call("/etc/init.d/network restart & >/dev/null")
	end

conf=s:taboption("dhcpconf",Value,"dhcpconf",nil,translate("开头的数字符号（＃）或分号的每一行（;）被视为注释；删除（;）启用指定选项。"))
conf.template="cbi/tvalue"
conf.rows=30
conf.wrap="off"
conf.cfgvalue=function(t,t)
return e.readfile("/etc/config/dhcp")or""
end
conf.write=function(a,a,t)
if t then
t=t:gsub("\r\n?","\n")
e.writefile("/tmp/dhcp",t)
if(luci.sys.call("cmp -s /tmp/dhcp /etc/config/dhcp")==1)then
e.writefile("/etc/config/dhcp",t)
end
e.remove("/tmp/dhcp")
end
end
end
if nixio.fs.access("/etc/config/firewall")then
s:tab("firewallconf",translate("配置防火墙"),translate("本页是配置/etc/config/firewall的文档内容。编辑后点击重启按钮后生效"))
	o=s:taboption("firewallconf",Button,"_frestart")
	o.inputtitle=translate("重启防火墙")
	o.inputstyle="apply"
	
	function o.write(e,e)
	luci.sys.exec("/etc/init.d/firewall restart >/dev/null")
	end
conf=s:taboption("firewallconf",Value,"firewallconf",nil,translate("开头的数字符号（＃）或分号的每一行（;）被视为注释；删除（;）启用指定选项。"))
conf.template="cbi/tvalue"
conf.rows=30
conf.wrap="off"
conf.cfgvalue=function(t,t)
return e.readfile("/etc/config/firewall")or""
end
conf.write=function(a,a,t)
if t then
t=t:gsub("\r\n?","\n")
e.writefile("/tmp/firewall",t)
if(luci.sys.call("cmp -s /tmp/firewall /etc/config/firewall")==1)then
e.writefile("/etc/config/firewall",t)
end
e.remove("/tmp/firewall")
end
end
end
if nixio.fs.access("/etc/config/smartdns")then
s:tab("smartdnsconf",translate("配置smartdns"),translate("本页是配置/etc/config/smartdns的文档内容。编辑后点击重启按钮后生效"))
	o=s:taboption("smartdnsconf",Button,"_drestart")
	o.inputtitle=translate("重启smartdns")
	o.inputstyle="apply"
	
	function o.write(e,e)
	luci.sys.call("/etc/init.d/smartdns restart >/dev/null")
	end

conf=s:taboption("smartdnsconf",Value,"smartdnsconf",nil,translate("开头的数字符号（＃）或分号的每一行（;）被视为注释；删除（;）启用指定选项。"))
conf.template="cbi/tvalue"
conf.rows=30
conf.wrap="off"
conf.cfgvalue=function(t,t)
return e.readfile("/etc/config/smartdns")or""
end
conf.write=function(a,a,t)
if t then
t=t:gsub("\r\n?","\n")
e.writefile("/tmp/smartdns",t)
if(luci.sys.call("cmp -s /tmp/smartdns /etc/config/smartdns")==1)then
e.writefile("/etc/config/smartdns",t)
end
e.remove("/tmp/smartdns")
end
end
end
if nixio.fs.access("/etc/config/openclash")then
s:tab("openclashconf",translate("配置openclash"),translate("本页是配置/etc/config/openclash的文档内容。编辑后点击重启按钮后生效"))
	o=s:taboption("openclashconf",Button,"_drestart")
	o.inputtitle=translate("重启openclash")
	o.inputstyle="apply"
	
	function o.write(e,e)
	luci.sys.call("/etc/init.d/openclash restart >/dev/null")
	end


conf=s:taboption("openclashconf",Value,"openclashconf",nil,translate("开头的数字符号（＃）或分号的每一行（;）被视为注释；删除（;）启用指定选项。"))
conf.template="cbi/tvalue"
conf.rows=30
conf.wrap="off"
conf.cfgvalue=function(t,t)
return e.readfile("/etc/config/openclash")or""
end
conf.write=function(a,a,t)
if t then
t=t:gsub("\r\n?","\n")
e.writefile("/tmp/openclash",t)
if(luci.sys.call("cmp -s /tmp/openclash /etc/config/openclash")==1)then
e.writefile("/etc/config/openclash",t)
end
e.remove("/tmp/openclash")
end
end
end
if nixio.fs.access("/etc/config/AdGuardHome")then
s:tab("AdGuardHomeconf",translate("配置AdGuardHome"),translate("本页是配置/etc/config/AdGuardHome的文档内容。编辑后点击重启按钮后生效"))
	o=s:taboption("AdGuardHomeconf",Button,"_drestart")
	o.inputtitle=translate("重启AdGuardHome")
	o.inputstyle="apply"
	
	function o.write(e,e)
	luci.sys.call("/etc/init.d/AdGuardHome restart >/dev/null")
	end


conf=s:taboption("AdGuardHomeconf",Value,"AdGuardHomeconf",nil,translate("开头的数字符号（＃）或分号的每一行（;）被视为注释；删除（;）启用指定选项。"))
conf.template="cbi/tvalue"
conf.rows=30
conf.wrap="off"
conf.cfgvalue=function(t,t)
return e.readfile("/etc/config/AdGuardHome")or""
end
conf.write=function(a,a,t)
if t then
t=t:gsub("\r\n?","\n")
e.writefile("/tmp/AdGuardHome",t)
if(luci.sys.call("cmp -s /tmp/AdGuardHome /etc/config/AdGuardHome")==1)then
e.writefile("/etc/config/AdGuardHome",t)
end
e.remove("/tmp/AdGuardHome")
end
end
end
if nixio.fs.access("/etc/pcap-dnsproxy/Config.conf")then
s:tab("pcapconf",translate("配置pcap-dnsproxy"),translate("本页是配置/etc/pcap-dnsproxy/Config.conf的文档内容。编辑后点击重启按钮后生效"))
	o=s:taboption("pcapconf",Button,"_drestart")
	o.inputtitle=translate("重启pcap-dnsproxy")
	o.inputstyle="apply"
	
	function o.write(e,e)
	luci.sys.call("/etc/init.d/pcap-dnsproxy restart >/dev/null")
	end

conf=s:taboption("pcapconf",Value,"pcapconf",nil,translate("开头的数字符号（＃）或分号的每一行（;）被视为注释；删除（;）启用指定选项。"))
conf.template="cbi/tvalue"
conf.rows=30
conf.wrap="off"
conf.cfgvalue=function(t,t)
return e.readfile("/etc/pcap-dnsproxy/Config.conf")or""
end
conf.write=function(a,a,t)
if t then
t=t:gsub("\r\n?","\n")
e.writefile("/tmp/Config.conf",t)
if(luci.sys.call("cmp -s /tmp/Config.conf /etc/pcap-dnsproxy/Config.conf")==1)then
e.writefile("/etc/pcap-dnsproxy/Config.conf",t)
end
e.remove("/tmp/Config.conf")
end
end
end
if nixio.fs.access("/etc/config/mwan3")then
s:tab("mwan3conf",translate("配置mwan3"),translate("本页是配置/etc/config/mwan3的文档内容。编辑后点击重启按钮后生效"))
o=s:taboption("mwan3conf",Button,"_mwan3restart")
o.inputtitle=translate("重启mwan3")
o.inputstyle="apply"
function o.write(e,e)
luci.sys.exec("/etc/init.d/mwan3 restart >/dev/null")
end
conf=s:taboption("mwan3conf",Value,"mwan3conf",nil,translate("开头的数字符号（＃）或分号的每一行（;）被视为注释；删除（;）启用指定选项。"))
conf.template="cbi/tvalue"
conf.rows=50
conf.wrap="off"
conf.cfgvalue=function(t,t)
return e.readfile("/etc/config/mwan3")or""
end
conf.write=function(a,a,t)
if t then
t=t:gsub("\r\n?","\n")
e.writefile("/tmp/mwan3",t)
if(luci.sys.call("cmp -s /tmp/mwan3 /etc/config/mwan3")==1)then
e.writefile("/etc/config/mwan3",t)
end
e.remove("/tmp/mwan3")
end
end
end
return m
