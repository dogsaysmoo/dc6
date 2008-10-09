var Vvolume = props.globals.getNode("sim/sound/view-volume",1);

setlistener("/sim/signals/fdm-initialized", func {
    Vvolume.setDoubleValue(0.1);
    update();
});

setlistener("/sim/signals/reinit", func(rset) {
    if(rset.getValue()==0){
    }
},1,0);

setlistener("/sim/current-view/name", func(vw){
    var ViewName= vw.getValue();
    if(ViewName =="Cockpit View"){
    Vvolume.setDoubleValue(0.1);
    }else{
    Vvolume.setDoubleValue(0.8);
    }
},1,0);

setlistener("/sim/model/autostart", func(idle){
    var run= idle.getBoolValue();
    if(run){
    Startup();
    }else{
    Shutdown();
    }
},0,0);


var Startup = func{
setprop("controls/electric/engine[0]/generator",1);
setprop("controls/electric/engine[1]/generator",1);
setprop("controls/electric/engine[2]/generator",1);
setprop("controls/electric/engine[3]/generator",1);
setprop("controls/electric/battery-switch",1);
setprop("controls/lighting/instrument-lights",1);
setprop("controls/lighting/nav-lights",1);
setprop("controls/lighting/beacon",1);
setprop("controls/engines/engine[0]/magnetos",3);
setprop("controls/engines/engine[0]/fuel-pump",1);
setprop("controls/engines/engine[0]/propeller-pitch",1);
setprop("controls/engines/engine[0]/mixture",1);
setprop("engines/engine[0]/rpm",1000);
setprop("controls/engines/engine[1]/magnetos",3);
setprop("controls/engines/engine[1]/fuel-pump",1);
setprop("controls/engines/engine[1]/propeller-pitch",1);
setprop("controls/engines/engine[1]/mixture",1);
setprop("engines/engine[1]/rpm",1000);
setprop("controls/engines/engine[2]/magnetos",3);
setprop("controls/engines/engine[2]/fuel-pump",1);
setprop("controls/engines/engine[2]/propeller-pitch",1);
setprop("controls/engines/engine[2]/mixture",1);
setprop("engines/engine[2]/rpm",1000);
setprop("controls/engines/engine[3]/magnetos",3);
setprop("controls/engines/engine[3]/fuel-pump",1);
setprop("controls/engines/engine[3]/propeller-pitch",1);
setprop("controls/engines/engine[3]/mixture",1);
setprop("engines/engine[3]/rpm",1000);
setprop("fdm/jsbsim/propulsion/set-running",1);
}

var Shutdown = func{
setprop("controls/electric/engine[0]/generator",0);
setprop("controls/electric/battery-switch",0);
setprop("controls/lighting/instrument-lights",0);
setprop("controls/lighting/nav-lights",0);
setprop("controls/lighting/beacon",0);
setprop("controls/engines/engine[0]/magnetos",0);
setprop("controls/engines/engine[0]/fuel-pump",0);
setprop("controls/engines/engine[1]/magnetos",0);
setprop("controls/engines/engine[1]/fuel-pump",0);
setprop("controls/engines/engine[2]/magnetos",0);
setprop("controls/engines/engine[2]/fuel-pump",0);
setprop("controls/engines/engine[3]/magnetos",0);
setprop("controls/engines/engine[3]/fuel-pump",0);
setprop("fdm/jsbsim/propulsion/set-running",0);
}

var update = func {
		updateBMEP();
    settimer(update,0);
}

var updateBMEP = func {
	var hp=0;
	var rpm=0;
	var bmep=0;
	for(var engine=0; engine< 4; engine+=1)
	{
		rpm=getprop("engines/engine["~engine~"]/rpm");
		hp=getprop("fdm/jsbsim/propulsion/engine["~engine~"]/power_hp");
#print("Engine: ", engine);
#print("Horsepower: ", hp);
#print("RPM: ", rpm);

		if(rpm)
		{
			bmep=hp*285/rpm;
		} else {
			bmep=0;
		}
#		print("BMEP: ", bmep);
		setprop("engines/engine["~engine~"]/bmep", bmep);
	}
}
