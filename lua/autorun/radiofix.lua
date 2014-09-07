hook.Add( "TTTPrepareRound", "SpecCalloutOverride", function()

	LANG.AddToLanguage("english", "quick_cloak", "someone who is cloaked")

	function RADIO:GetTargetType()
		if not IsValid(LocalPlayer()) then return end
	 --local trace = LocalPlayer():GetEyeTrace(MASK_SHOT)

		local tab = util.GetPlayerTrace( LocalPlayer() )

		 tab.filter = function(ent)
										if ent:IsPlayer() and ent:IsSpec() then
												return false
										elseif ent == LocalPlayer() then
												return false
										else
											return true
										end
									end

		 local trace = util.TraceLine(tab)

		

		 if not trace or (not trace.Hit) or (not IsValid(trace.Entity)) then return end

		 local ent = trace.Entity

		 
		 if ent:IsPlayer() then
				if ent:GetNWBool("disguised", false) then
					 return "quick_disg", true
				elseif ent:GetNWBool("cloaked", false) then
					return "quick_cloak", true
				else
					 return ent, false
				end

		 elseif ent:GetClass() == "prop_ragdoll" and CORPSE.GetPlayerNick(ent, "") != "" then

				if DetectiveMode() and not CORPSE.GetFound(ent, false) then
					 return "quick_corpse", true
				else
					 return ent, false
				end
		 end
	end
end)

