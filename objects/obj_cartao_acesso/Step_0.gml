count +=.1;

y+= sin(count) * .8
image_xscale = cos(count)

if (place_meeting(x,y,obj_player) && obj_player.universo_atual == global.universos[0]) {
	global.pego_cartao = true
    global.num_fase++;
    instance_destroy(id)
}