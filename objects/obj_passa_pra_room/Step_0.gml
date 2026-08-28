/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor
if (place_meeting(x,y,obj_player)) {
    if (global.num_fase == 0) {
    	room_goto(rm_fase_1_normal)
        global.pimeira_vez = true
        if (global.pimeira_vez == true) {
        	global.pego_cartao = false
            global.usou_espelho = false
            global.ativou_espelho = false
            global.pimeira_vez = false
        }
        
    }else if (global.num_fase == 1) {
    	room_goto(rm_fase_2_normal)
        global.pimeira_vez = true
        if (global.pimeira_vez == true) {
        	global.pego_cartao = false
            global.usou_espelho = false
            global.ativou_espelho = false
            global.pimeira_vez = false
        }
        
    }else if(global.num_fase == 2)
	{
		room_goto(rm_fase_3_normal)
        global.pimeira_vez = true
		  if (global.pimeira_vez == true) {
        	global.pego_cartao = false
            global.usou_espelho = false
            global.ativou_espelho = false
            global.pimeira_vez = false
        }
	}else if(global.num_fase == 3)
	{
		room_goto(rm_fase_4_normal)
        global.pimeira_vez = true
		  if (global.pimeira_vez == true) {
        	global.pego_cartao = false
            global.usou_espelho = false
            global.ativou_espelho = false
            global.pimeira_vez = false
        }
	}
	
}