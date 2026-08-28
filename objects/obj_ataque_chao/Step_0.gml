with (obj_player) {
	if (place_meeting(x,y,other)) {
    	estado = estadoDeMorte;
    }
}



var _dist = obj_player.x - id.x
//maquina de estados do ataque
if ((_dist >= -120) && (estados == "inativo") && baixo) {
	
    id.y = lerp(y,0,.2)
    count++
    show_debug_message(count)
    if (count >= 25) {
    	id.estados = "voltando"
    }
    
}else if ( (_dist >= -120) && (estados == "inativo") && (baixo == false)) {
	id.y = lerp(y, room_height, .2)
    count++
    show_debug_message(count)
    if (count >= 25) {
    	id.estados = "voltando"
    }
}


if ( (estados == "voltando") && baixo) {
	id.y = lerp(y, room_height+128, .05)
    if (y >= room_height + 64) {
    	id.estados = "destrua"
    }
    
}else if ((estados == "voltando") && (baixo == false)) {
	id.y = lerp(y,-64,.2);
    if (y <= -10) {
    	id.estados = "destrua"
    }
}

if (estados == "destrua") {
	instance_destroy(id)
    show_debug_message("DESTRUIDO")
}
show_debug_message(_dist)