/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor

var _dist = obj_player.x - id.x

show_debug_message(_dist)
if (_dist >= -600 && Estados = "inativo") {
	Estados = "ativo"
}

if (Estados == "ativo") {
	var _max_y = 256
    var _vel = 4
    id.y-=5;
    id.y = clamp(y,256, 384);
    id.x-= _vel ;
    
    if (x <= -64) {
    	Estados = "destruido"
    }
}

if (Estados == "destruido") {
	instance_destroy(id)
}

if (place_meeting(x,y,obj_player)) {
	obj_player.estado = obj_player.estadoDeMorte;
}