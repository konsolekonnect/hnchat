hnchat = hnchat or {}

hnchat.net = {}
	hnchat.net.local_send = util.AddNetworkString( "hnchat_local_send" )
	hnchat.net.local_receive = util.AddNetworkString( "hnchat_local_receive" )
	hnchat.net.local_send_sv = net.Receive( "hnchat_local_send", function( len, ply )
		local plys = net.ReadTable()
		local txt = net.ReadString()

		gamemode.Call( "PlayerSay", ply, txt, false)

		net.Start( "hnchat_local_receive", false )
			net.WriteEntity(ply)
			net.WriteString(txt)
		net.Send(plys)
	end)

	hnchat.net.say_send = util.AddNetworkString( "hnchat_say" )
	hnchat.net.say_sv = net.Receive( "hnchat_say", function( len, ply )
		local txt = net.ReadString()
		local team = net.ReadBool()
		gamemode.Call( "PlayerSay", ply, txt, team )
	end)

	hnchat.net.dm_send = util.AddNetworkString("hnchat_dm_send")
	hnchat.net.dm_receive = util.AddNetworkString("hnchat_dm_receive")
	hnchat.net.dm_send_sv = net.Receive("hnchat_dm_send",function(len, ply)
		local target = net.ReadEntity()
		local txt = net.ReadString()

		--for k, v in next, plys do
			if not target:IsPlayer() then return end--table.remove(plys, k) end
		--end

		net.Start( "hnchat_dm_receive", false )
			net.WriteEntity(ply)
			net.WriteString(txt)
		net.Send(target)
	end)