var run_tyresmoke0 = 0;
var run_tyresmoke1 = 0;
var run_tyresmoke2 = 0;

var tyresmoke_0 = aircraft.tyresmoke.new(0);
var tyresmoke_1 = aircraft.tyresmoke.new(1);
var tyresmoke_2 = aircraft.tyresmoke.new(2);



setlistener("/sim/signals/fdm-initialized", func {
    setprop("sim/sound/view-volume",0.1);
    update();
});

############ EFFECTS ############
setlistener("gear/gear[0]/position-norm", func(g1) {
    if(g1.getValue()){
        run_tyresmoke0 = 1;
    }else{
        run_tyresmoke0 = 0;
    }
},1,0);

setlistener("gear/gear[1]/position-norm", func(g2) {
    if(g2.getValue()){
        run_tyresmoke1 = 1;
    }else{
        run_tyresmoke1 = 0;
    }
},1,0);

setlistener("gear/gear[2]/position-norm", func(g3) {
    if(g3.getValue()){
        run_tyresmoke2 = 1;
    }else{
        run_tyresmoke2 = 0;
    }
},1,0);




setlistener("/sim/signals/reinit", func(rset) {
    if(rset.getValue()==0){
    }
},1,0);

setlistener("/sim/current-view/internal", func(vw){
    var vlm=0.1;
    if(vw.getBoolValue()){
    vlm=0.1;
    }else{
    vlm=0.8;
    }
    setprop("sim/sound/view-volume",vlm);
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
        hp=getprop("fdm/jsbsim/propulsion/engine["~engine~"]/power-hp");
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

var tyresmoke = func {
print ("run_tyresmoke ",run_tyresmoke0);
    if (run_tyresmoke0)
        tyresmoke_0.update();
    if (run_tyresmoke1)
        tyresmoke_1.update();
    if (run_tyresmoke2)
        tyresmoke_2.update();
    settimer(tyresmoke, 0);
}

tyresmoke();
