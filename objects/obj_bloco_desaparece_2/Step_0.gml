/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor
if (colisao) {
	image_alpha = 1
}else {
	image_alpha = .5
}
if (place_meeting(x,y,obj_player) && colisao) {
	obj_player.x -= sprite_get_width(spr_parede)/2
}