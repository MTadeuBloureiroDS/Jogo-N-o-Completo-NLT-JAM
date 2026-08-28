var _marg = 8;
sprite_index = obj_player.sprite_index;
if (animacaoAcabou() && sprite_index != spr_player_idle) {
	image_index = image_number-1;
}
x = obj_player.x+_marg
y = obj_player.y-_marg div 3
image_xscale = -obj_player.dir
