--------------------------------------------------------------
function CPC_OnFloatingText(text)
	print("CPC_FloatingMessage"..", Text = "..text);
end
LuaEvents.CPC_FloatingMessage.Add(CPC_OnFloatingText)
