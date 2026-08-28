if (obj_player.x > 330) {
	hspeed = 4.5
}

with (obj_player) {
	if (place_meeting(x,y,other)) {
    	estado = estadoDeMorte;
    }
}