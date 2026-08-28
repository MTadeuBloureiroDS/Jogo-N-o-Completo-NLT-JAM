/// @description esse é onde vai rodar os códigos do player
// Você pode escrever seu código neste editor

//cahamndo métodos importantes

//regiao das verificações e métodos importantes
#region IMPORTANTE


checar_chao();
pega_input();
movimento();


retorna_squash();
ativando_debug();

if (instance_exists(obj_espelho)) {
	interagircEspelho();
}



if (instance_exists(obj_bloco_desaparece) || instance_exists(obj_bloco_desaparece_2)) {
	if (obj_bloco_desaparece.colisao == true) {
	colisoes = [obj_parede,obj_bloco_desaparece, obj_porta]
    }else {
    	colisoes = [obj_parede, obj_bloco_desaparece_2, obj_porta]
    }
    
    if (obj_bloco_desaparece_2.colisao == true) {
    	colisoes = [obj_parede,obj_bloco_desaparece_2, obj_porta]
    }else {
    	colisoes = [obj_parede, obj_bloco_desaparece, obj_porta]
    }
    
}
//if (instance_exists(obj_caixa)) {
	//if (place_meeting(x,y,obj_caixa) ) {
	   //obj_caixa.x += 20
    //}
//}


if ((y > room_height + 64) && universo_atual != global.universos[4]) {
	estado = estadoDeMorte;
}


if (universo_atual == global.universos[1] ) {
	afogamento();
    y = clamp(y,32+sprite_get_height(spr_player_idle_agua)/2,room_height + 64)
}
if (universo_atual == global.universos[3]) {
	criar_luz();
}

if ((place_meeting(x,y,obj_espinho_bugado_1) && obj_espinho_bugado_1.colisao == true) || (place_meeting(x,y,obj_espinho_bugado_2) && obj_espinho_bugado_2.colisao == true)) {
	estado = estadoDeMorte;
}


#endregion

#region Métodos e verificações para misc
if (instance_exists(obj_cama)) {
	var _range_cama = (x < obj_cama.x + sprite_get_width(spr_cama)/2 ) && (x > obj_cama.x - sprite_get_width(spr_cama)/2)
    if (_range_cama) {
    	if (keyboard_check_pressed(ord("E"))) {
            estado = deitar_na_cama;
        }
    }
}

//rodando o estado do player
estado();
#endregion