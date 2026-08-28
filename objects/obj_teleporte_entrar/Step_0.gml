/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor
if ((instance_exists(obj_teleporte_sair)) && saida == 0) {
	saida = obj_teleporte_sair.id
    
}

if (place_meeting(x,y,obj_player) && saida != 0) {
	obj_player.x = saida.x
    obj_player.y = saida.y
}