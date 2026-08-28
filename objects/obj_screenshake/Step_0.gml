/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor

//tremendo a tela
//alterando a posição x e y do viewport com base no valor do treme
if (treme != 0.1) {
	var _x = random_range(-treme, treme)
    var _y = random_range(-treme, treme)
    
    //alterando a posição x do viewport
    view_set_xport(view_current, _x);
    
    view_set_yport(view_current, _y);
    
}else {
	treme = 0
    
    view_set_xport(view_current, 0)
    view_set_yport(view_current, 0)
}

//parando de tremer aos poucos
treme = lerp(treme,0,.1)