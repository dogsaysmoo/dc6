# Override Control Scripts

var adjPropeller = func(chg) {
	delta = var delta = 0.33 * chg * getprop("/sim/time/delta-realtime-sec");
	setprop("controls/engines/engine/propeller-pitch",getprop("controls/engines/engine/propeller-pitch") + delta);
	setprop("controls/engines/engine[1]/propeller-pitch",getprop("controls/engines/engine[1]/propeller-pitch") + delta);
	setprop("controls/engines/engine[2]/propeller-pitch",getprop("controls/engines/engine[2]/propeller-pitch") + delta);
	setprop("controls/engines/engine[3]/propeller-pitch",getprop("controls/engines/engine[3]/propeller-pitch") + delta);
}

