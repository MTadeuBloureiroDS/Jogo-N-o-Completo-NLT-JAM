/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor
        var _distancia = pai.x - obj_player.x;
    	
        
        //fazendo mudar o alpha com base na distancia
        if(_distancia > 530)
        {
            
            id.image_alpha = .1
        }else if (_distancia > 310) {
        	id.image_alpha = lerp(id.image_alpha,.2,.1)
        }else if (_distancia > 165) {
        	id.image_alpha = lerp(id.image_alpha,.3,.1)
        }else if (_distancia > 60) {
        	id.image_alpha = lerp(id.image_alpha,.4,.1)
        }else if (_distancia > 0) {
        	id.image_alpha = lerp(id.image_alpha,.5,.1)
        }else if (_distancia < -100) {
        	id.image_alpha = lerp(id.image_alpha,0,.1)
        }