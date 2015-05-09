# A controller for the fuel tanks / pumps / x-feeds

var fuel_init = func {
	setprop("controls/fuel/selector",0);
	setprop("controls/fuel/selector[1]",0);
	setprop("controls/fuel/selector[2]",0);
	setprop("controls/fuel/selector[3]",0);

	setprop("controls/fuel/x-feed",0);
	setprop("controls/fuel/x-feed[1]",0);

	setprop("consumables/fuel/tank/selected",0);
	setprop("consumables/fuel/tank[1]/selected",0);
	setprop("consumables/fuel/tank[2]/selected",0);
	setprop("consumables/fuel/tank[3]/selected",0);
	setprop("consumables/fuel/tank[4]/selected",0);
	setprop("consumables/fuel/tank[5]/selected",0);
	setprop("consumables/fuel/tank[6]/selected",0);
	setprop("consumables/fuel/tank[7]/selected",0);
}
fuel_init();


var fuel_select = func(knob,chg) {
	var pos = props.globals.getNode("controls/fuel/selector[" ~ knob ~ "]",1);
	if ((pos.getValue() + chg) > 1) {
	    pos.setValue(1);
	} elsif ((pos.getValue() + chg) < (-1)) {
	    pos.setValue(-1);
	} else {
	    pos.setValue(pos.getValue() + chg);
	}
	
	var m = 0;
	var a = 2;
	var this = 0;
	var that = 1;
	
	if (knob == 0) {
	    m = 0;
	    a = 2;
	    this = 0;
	    that = 1;
	}
	if (knob == 1) {
	    m = 1;
	    a = 3;
	    this = 0;
	    that = 1;
	}
	if (knob == 2) {
	    m = 6;
	    a = 4;
	    this = 1;
	    that = 0;
	}
	if (knob == 3) {
	    m = 7;
	    a = 5;
	    this = 1;
	    that = 0;
	}
	
	var main = props.globals.getNode("consumables/fuel/tank[" ~ m ~ "]/selected",1);
	var altr = props.globals.getNode("consumables/fuel/tank[" ~ a ~ "]/selected",1);
	var xfeed_thisside = getprop("controls/fuel/x-feed[" ~ this ~ "]");
	var xfeed_thatside = getprop("controls/fuel/x-feed[" ~ that ~ "]");
	
	if (pos.getValue() == 0) {
	    main.setBoolValue(0);
	    altr.setBoolValue(0);
	}
	if (pos.getValue() == 1) {
	    main.setBoolValue(1);
	    altr.setBoolValue(0);
	    if (xfeed_thatside and !xfeed_thisside) main.setBoolValue(0);
	}
	if (pos.getValue() == -1) {
	    main.setBoolValue(0);
	    altr.setBoolValue(1);
	    if (xfeed_thatside and !xfeed_thisside) altr.setBoolValue(0);
	}

	if ((knob == 0 or knob == 3) and xfeed_thisside) {
	    main.setBoolValue(0);
	    altr.setBoolValue(0);
	}
}

setlistener("consumables/fuel/tank/selected", func {
	fuel_select(0,0);
},0,0);
setlistener("consumables/fuel/tank[1]/selected", func {
	fuel_select(1,0);
},0,0);
setlistener("consumables/fuel/tank[2]/selected", func {
	fuel_select(0,0);
},0,0);
setlistener("consumables/fuel/tank[3]/selected", func {
	fuel_select(1,0);
},0,0);
setlistener("consumables/fuel/tank[4]/selected", func {
	fuel_select(2,0);
},0,0);
setlistener("consumables/fuel/tank[5]/selected", func {
	fuel_select(3,0);
},0,0);
setlistener("consumables/fuel/tank[6]/selected", func {
	fuel_select(2,0);
},0,0);
setlistener("consumables/fuel/tank[7]/selected", func {
	fuel_select(3,0);
},0,0);


var fuel_xfeed = func(xfeed) {
	var knob = props.globals.getNode("controls/fuel/x-feed[" ~ xfeed ~ "]",1);
	if (knob.getBoolValue()) {
	    knob.setBoolValue(0);
	} else {
	    knob.setBoolValue(1);
	}
	fuel_select(0,0);
	fuel_select(1,0);
	fuel_select(2,0);
	fuel_select(3,0);
}

