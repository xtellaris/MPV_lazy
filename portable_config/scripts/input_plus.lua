--[[

快捷指令增强

input.conf 示例：

Alt+p              script-binding input_plus/playlist_shuffle   # 播放列表的洗牌与撤销
CLOSE_WIN          script-binding input_plus/quit_real          # 对执行退出命令前的确认（防止误触）
q                  script-binding input_plus/quit_wait          # 延后退出命令的执行（执行前再次触发可取消）
Alt+LEFT           script-binding input_plus/seek_auto_back     # 后退至上句字幕的时间点或上一关键帧
Alt+RIGHT          script-binding input_plus/seek_auto_next     # 前进至下...
Shift+Ctrl+LEFT    script-binding input_plus/seek_skip_back     # 向后大跳（精确帧）
Shift+Ctrl+RIGHT   script-binding input_plus/seek_skip_next     # 向前...
SPACE              script-binding input_plus/speed_auto         # 按下两倍速，松开一倍速
BS                 script-binding input_plus/speed_recover      # 仿Pot的速度重置与恢复
1                  script-binding input_plus/trackA_back        # 上一个音频轨道（自动跳过无轨道）
2                  script-binding input_plus/trackA_next        # 下...
3                  script-binding input_plus/trackS_back        # 上一个字幕轨道...
4                  script-binding input_plus/trackS_next        # 下...
5                  script-binding input_plus/trackV_back        # 上一个视频轨道...
6                  script-binding input_plus/trackV_next        # 下...

--]]


local shuffled = false
function playlist_shuffle()
	if mp.get_property_number("playlist-count") <= 2 then
		mp.osd_message("播放列表中的条目数量不足", 1)
		return
	end
	if not shuffled then
		mp.command("playlist-shuffle")
		mp.osd_message(mp.command_native({"expand-text", "${playlist}"}), 2)
		shuffled = true
	else
		mp.command("playlist-unshuffle")
		mp.osd_message(mp.command_native({"expand-text", "${playlist}"}), 2)
		shuffled = false
	end
end

local pre_quit = false
function quit_real()
	if pre_quit then
		mp.command("quit")
	else
		mp.osd_message("再次执行以确认退出", 1)
		pre_quit = true
		mp.add_timeout(1, function()
			pre_quit = false
			mp.msg.verbose("检测到误触退出键")
		end)
	end
end
function quit_wait()
	if pre_quit then
		pre_quit = false
		return
	else
		pre_quit = true
		mp.osd_message("即将退出，再次执行以取消", 3)
		mp.add_timeout(3, function()
			if pre_quit then
				mp.command("quit")
			else
				mp.osd_message("已取消退出", 0.5)
				return
			end
		end)
	end
end

function seek_auto_back()
	local current_sid = mp.get_property_number("sid") or 0
	if current_sid == 0 then
		mp.command("seek " .. -0.1 .. " keyframes")
	else
		mp.command("sub-seek " .. -1 .. "primary")
	end
end
function seek_auto_next()
	local current_sid = mp.get_property_number("sid") or 0
	if current_sid == 0 then
		mp.command("seek " .. 0.1 .. " keyframes")
	else
		mp.command("sub-seek " .. 1 .. "primary")
	end
end
function seek_skip_back()
	local duration_div_chapters = mp.get_property_number("duration", 1) / mp.get_property_number("chapter-list/count", 1)
	if duration_div_chapters >= 240 then
		mp.command("seek " .. -10 .. " relative-percent+exact")
	elseif duration_div_chapters == 1 then
		mp.command("seek " .. -60 .. " exact")
	else
		mp.commandv("add", "chapter", -1)
		mp.command("show-progress")
	end
end
function seek_skip_next()
	local duration_div_chapters = mp.get_property_number("duration", 1) / mp.get_property_number("chapter-list/count", 1)
	if duration_div_chapters >= 240 then
		mp.command("seek " .. 10 .. " relative-percent+exact")
	elseif duration_div_chapters == 1 then
		mp.command("seek " .. 60 .. " exact")
	else
		mp.commandv("add", "chapter", 1)
		mp.command("show-progress")
	end
end

local bak_speed = nil
function speed_auto(tab)
	if tab.event == "up" then
		mp.commandv("set", "speed", 1)
		mp.msg.verbose("已恢复常速")
	elseif tab.event == "down" then
		mp.commandv("set", "speed", 2)
		mp.msg.verbose("加速播放中")
	end
end
function speed_recover()
	if mp.get_property_number("speed") ~= 1 then
		bak_speed = mp.get_property_number("speed")
		mp.command("set speed 1")
	else
		if bak_speed == nil then
			bak_speed = 1
		end
		mp.command("set speed " .. bak_speed)
	end
end

function trackA_back()
	mp.command("add aid -1")
	if mp.get_property_number("aid", 0) == 0 then
		mp.command("add aid -1")
		if mp.get_property_number("aid", 0) == 0 then
			mp.osd_message("无音频轨", 1)
		end
	end
end
function trackA_next()
	mp.command("add aid 1")
	if mp.get_property_number("aid", 0) == 0 then
		mp.command("add aid 1")
		if mp.get_property_number("aid", 0) == 0 then
			mp.osd_message("无音频轨", 1)
		end
	end
end
function trackS_back()
	mp.command("add sid -1")
	if mp.get_property_number("sid", 0) == 0 then
		mp.command("add sid -1")
		if mp.get_property_number("sid", 0) == 0 then
			mp.osd_message("无字幕轨", 1)
		end
	end
end
function trackS_next()
	mp.command("add sid 1")
	if mp.get_property_number("sid", 0) == 0 then
		mp.command("add sid 1")
		if mp.get_property_number("sid", 0) == 0 then
			mp.osd_message("无字幕轨", 1)
		end
	end
end
function trackV_back()
	mp.command("add vid -1")
	if mp.get_property_number("vid", 0) == 0 then
		mp.command("add vid -1")
		if mp.get_property_number("vid", 0) == 0 then
			mp.osd_message("无视频轨", 1)
		end
	end
end
function trackV_next()
	mp.command("add vid 1")
	if mp.get_property_number("vid", 0) == 0 then
		mp.command("add vid 1")
		if mp.get_property_number("vid", 0) == 0 then
			mp.osd_message("无视频轨", 1)
		end
	end
end


-- 键位绑定

mp.add_key_binding(nil, "playlist_shuffle", playlist_shuffle)

mp.add_key_binding(nil, "quit_real", quit_real)
mp.add_key_binding(nil, "quit_wait", quit_wait)

mp.add_key_binding(nil, "seek_auto_back", seek_auto_back, {repeatable = true})
mp.add_key_binding(nil, "seek_auto_next", seek_auto_next, {repeatable = true})
mp.add_key_binding(nil, "seek_skip_back", seek_skip_back)
mp.add_key_binding(nil, "seek_skip_next", seek_skip_next)

mp.add_key_binding(nil, "speed_auto", speed_auto, {complex = true})
mp.add_key_binding(nil, "speed_recover", speed_recover)

mp.add_key_binding(nil, "trackA_back", trackA_back)
mp.add_key_binding(nil, "trackA_next", trackA_next)
mp.add_key_binding(nil, "trackS_back", trackS_back)
mp.add_key_binding(nil, "trackS_next", trackS_next)
mp.add_key_binding(nil, "trackV_back", trackV_back)
mp.add_key_binding(nil, "trackV_next", trackV_next)
