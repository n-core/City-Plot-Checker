--------------------------------------------------------------
function OnFloatingText(text)
	print("CPC_FloatingMessage"..", Text = "..text);
end
LuaEvents.CPC_FloatingMessage.Add(OnFloatingText)
