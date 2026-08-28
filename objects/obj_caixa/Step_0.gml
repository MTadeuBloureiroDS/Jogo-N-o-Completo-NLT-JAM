/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor
if (keyboard_check(ord("E"))&&(place_meeting(x-5,y,obj_player) || place_meeting(x+ 5,y,obj_player))) {
	if(place_meeting(x-5,y,obj_player))
	{ 
        move_and_collide(abs(obj_player.velh), obj_player.velv,colisao);
	}else if (place_meeting(x+ 5,y,obj_player))
	{
		move_and_collide(obj_player.velh* !obj_player.dir, obj_player.velv,colisao)
	}
}
else if (!keyboard_check(ord("E"))){
	if(place_meeting(x-5,y,obj_player))
	{ 
        obj_player.x-=2
	}else if (place_meeting(x+ 5,y,obj_player))
	{
        obj_player.x+=2
	}
	obj_player.colisoes[@ array_length(obj_player.colisoes)] = obj_caixa
	if(!place_meeting(x,y+1,colisao))
	{
		velv +=  obj_player.grav;
			move_and_collide(0, velv,colisao)
	}else
	{
		velv = 0
	}
}
