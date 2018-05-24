state("GettingOverIt" , "1.583")
{	
	//beta version
	float timer : "UnityPlayer.dll", 0x00FEDCEC, 0x2C0, 0x124, 0x8, 0x44, 0x64;
	float x		: "UnityPlayer.dll", 0x00FE7474, 0x758, 0x88, 0x4AC, 0x278, 0x34;
	float y		: "UnityPlayer.dll", 0x00FE7474, 0x758, 0x88, 0x4AC, 0x278, 0x38;
}

state("GettingOverIt" , "1.581")
{	
	//beta version
	float timer : "UnityPlayer.dll", 0x00FBA7D0, 0x21C, 0x3E8, 0x8, 0xDC, 0x68;
	float x		: "UnityPlayer.dll", 0x00FD7770, 0x0, 0x8, 0x1C, 0x60, 0x60;
	float y		: "UnityPlayer.dll", 0x00FD7770, 0x0, 0x8, 0x1C, 0x60, 0x64;
}

state("GettingOverIt" , "1.58")
{	
	//beta version
	float timer : "UnityPlayer.dll", 0x00FE8810, 0x5C0, 0x260, 0x5A4, 0x44, 0xD0;
	float x		: "UnityPlayer.dll", 0x00FD7770, 0x0, 0x8, 0x1C, 0x60, 0x60;
	float y		: "UnityPlayer.dll", 0x00FD7770, 0x0, 0x8, 0x1C, 0x60, 0x64;
}

state("GettingOverIt" , "1.54")
{	
	float timer : 0x010BC834, 0x4A4;
	float x		: 0x10C3D08, 0x4C, 0x2EC, 0x0, 0x5C, 0x14C;
	float y		: 0x10C3D08, 0x4C, 0x2DC, 0x94, 0x5C, 0xB0;
}

state("GettingOverIt" , "1.52")
{	
	float timer : 0x10621A4, 0x4, 0x2E8, 0xC, 0xC, 0x94;
	float x		: 0x10621A4, 0x0, 0x4AC, 0x174, 0x20, 0x60;
	float y		: 0x10621A4, 0x0, 0x4AC, 0x174, 0x20, 0x64;
}

state("GettingOverIt" , "1.51") //works on 1.5 and 1.51
{	
	float timer : 0x105BC44, 0x10, 0x18, 0x28, 0x178, 0x8C;
	float x		: 0x10621A4, 0x0, 0x4AC, 0x174, 0x20, 0x60;
	float y		: 0x10621A4, 0x0, 0x4AC, 0x174, 0x20, 0x64;
}

state("GettingOverIt" , "1.3")
{	
	float timer : 0x105E114, 0x0, 0x360, 0x178, 0x1C, 0x80;
	float x		: 0x10BFB34, 0x0, 0x4, 0x18, 0x184, 0x20, 0x60;
	float y		: 0x10BFB34, 0x0, 0x4, 0x18, 0x184, 0x20, 0x64;
}

startup
{
	//runs once at the start
	Func<float, bool> zero = (x) => Math.Abs(x) < 1e-5;
	vars.zero = zero;
	refreshRate = 100;

}

init
{
	int size = modules.First().ModuleMemorySize;

	if (size == 1740800)
		version = "1.583";
	if (size == 19279872)
		version = "1.54";
 	if (size == 19267584 || size == 1945600) 
		version = "1.51";
	if (size == 19251200)
		version = "1.3";	
	if (version == "")
		print("Incompatible game version\nMemory size: " + size.ToString());
}



update
{	
	//always runs first, following actions only run when this doesnt return false

	if(timer.CurrentPhase == TimerPhase.Ended && current.x > -44.35 && current.x < -44.2 && current.y > -2.5 && current.y < -2.40 && current.timer < 0.1 && vars.LastValidTime > current.timer) {
		vars.tm = new TimerModel { CurrentState = timer };
		vars.tm.Reset();
	}

	if(current.timer > 0.1 && !vars.zero(current.x) && !vars.zero(current.y))
		vars.LastValidTime = current.timer;

	return true;

}

isLoading 
{
	return true;
}

gameTime
{	
	return TimeSpan.FromSeconds(System.Convert.ToDouble(vars.LastValidTime));
}

reset
{	
	//only runs if timer is running or paused
	return current.x > -44.35 && current.x < -44.2 && current.y > -2.5 && current.y < -2.40 && current.timer < 0.1 && vars.LastValidTime > current.timer;
}

split
{	
	//runs when reset doesnt return true
	if(!old.Tutorial && current.x > -12 && current.x < -8)  {
		current.Tutorial = true;
		return true;
	}
	
	if(!old.Chimney && current.x > 24 && current.y > 82)  {
		current.Chimney = true;
		return true;
	}
	
	if(!old.Slide && (current.x > 12 && current.x < 18) && (current.y > 123 && current.y < 128))  {
		current.Slide = true;
		return true;
	}
	
	if(!old.Furniture && (current.x > 4 && current.x < 6) && (current.y > 162 && current.y < 167))  {
		current.Furniture = true;
		return true;
	}
	
	if(!old.Orange && (current.x > 18 && current.x < 24) && (current.y > 216 && current.y < 222))  {
		current.Orange = true;
		return true;
	}
	
	if(!old.Anvil && (current.x > 73 && current.x < 76) && (current.y > 249 && current.y < 254))  {
		current.Anvil = true;
		return true;
	}
	
	if(!old.Bucket && (current.x > 18 && current.x < 22) && (current.y > 279 && current.y < 285))  {
		current.Bucket = true;
		return true;
	}
	
	if(!old.IceMountain && (current.x > 42 && current.x < 46) && (current.y > 317 && current.y < 323))  {
		current.IceMountain = true;
		return true;
	}
	
	if(!old.Tower && (current.y > 359 && current.y < 365))  {
		current.Tower = true;
		return true;
	}	
	
	if(!current.EnabledEnd && current.y > 473) {
		current.EnabledEnd = true;
	}
	
	if(!old.End && current.EnabledEnd && vars.zero(current.timer) && vars.zero(current.x) && vars.zero(current.y))  {
		current.End = true;
		return true;
	}
}

start
{	
	//runs when update didnt return false, and timer is not running and not paused
	current.Tutorial = false;
	current.Chimney = false;
	current.Slide = false;
	current.Furniture = false;
	current.Orange = false;
	current.Anvil = false;
	current.Bucket = false;
	current.IceMountain = false;
	current.Tower = false;
	current.End = false;
	
	current.EnabledEnd = false;
	
	vars.LastValidTime = 0.0;
	
	current.GameTime = TimeSpan.Zero;
	return current.timer > 0 && current.timer < 0.1 && current.x > -44.35 && current.x < -44.2 && current.y > -2.5 && current.y < -2.4;
}
