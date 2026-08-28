/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor
if (place_meeting(x,y,obj_player) && obj_player.universo_atual == global.universos[1]) {
	obj_player.estado = obj_player.estadoDeMorte()
    instance_destroy(id)
}
count-=.1;

y+= sin(count) *.3