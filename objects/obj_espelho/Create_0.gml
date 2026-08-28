/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor
randomise();

if (room != rm_introducao) {
	if(global.ativou_espelho == false){
       if (global.num_fase == 0) {
       	chance_menos = choose(rm_void_test,rm_fase_1_aquatica,rm_fase_1_invertida,rm_fase_1_glitched)
           destino = choose(rm_fase_1_aquatica,rm_fase_1_invertida,rm_fase_1_glitched,chance_menos)
       }else if (global.num_fase == 1) {
       	chance_menos = choose(rm_void_test,rm_fase_2_aquatica,rm_fase_2_invertido,rm_fase_2_glitched)
           destino = choose(rm_fase_2_aquatica,rm_fase_2_invertido,rm_fase_2_glitched,chance_menos)
       }else if(global.num_fase == 2)
	   {
		  chance_menos = choose(rm_void_test,rm_fase_3_aquatica,rm_fase_3_invertida,rm_fase_3_glitched)
           destino = choose(rm_fase_3_aquatica,rm_fase_3_invertida,rm_fase_3_glitched,chance_menos)
	   }else if (global.num_fase == 3) {
    	  chance_menos = choose(rm_void_test,rm_fase_4_aquatica,rm_fase_4_invertido,rm_fase_4_glitched)
           destino = choose(rm_fase_4_aquatica,rm_fase_4_invertido,rm_fase_4_glitched,chance_menos)
        show_debug_message("TA SELECIONADO")
    }
   }else if(global.ativou_espelho == true){
       destino = global.salas_inicio[global.num_fase]
   }
}

    