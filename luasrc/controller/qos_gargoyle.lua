--[[
luci for Gargoyle QoS
Based on GuoGuo's luci-app-qos-guoguo
Copyright (c) 2017 Xingwang Liao <kuoruan@gmail.com>
]]--

module("luci.controller.qos_gargoyle", package.seeall)

function index()
	if not nixio.fs.access("/etc/config/qos_gargoyle") then
		return
	end

	entry({"admin", "network", "qos_gargoyle"},
		alias("admin", "network", "qos_gargoyle", "global"),
		_("Gargoyle QoS"), 60)

	entry({"admin", "network", "qos_gargoyle", "global"},
		cbi("qos_gargoyle/global"), _("Global Settings"), 20)

	entry({"admin", "network", "qos_gargoyle", "upload"},
		cbi("qos_gargoyle/upload"), _("Upload Settings"), 30)

	entry({"admin", "network", "qos_gargoyle", "upload", "class"},
		cbi("qos_gargoyle/upload_class")).leaf = true

	entry({"admin", "network", "qos_gargoyle", "upload", "rule"},
		cbi("qos_gargoyle/upload_rule")).leaf = true

	entry({"admin", "network", "qos_gargoyle", "download"},
		cbi("qos_gargoyle/download"), _("Download Settings"), 40)

	entry({"admin", "network", "qos_gargoyle", "download", "class"},
		cbi("qos_gargoyle/download_class")).leaf = true

	entry({"admin", "network", "qos_gargoyle", "download", "rule"},
		cbi("qos_gargoyle/download_rule")).leaf = true
end

function has_ndpi()
	return luci.sys.call("lsmod | cut -d ' ' -f1 | grep -q xt_ndpi") == 0
end
