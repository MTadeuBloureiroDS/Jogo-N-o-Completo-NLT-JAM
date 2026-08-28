// Os recursos de script mudaram para a v2.3.0; veja
// https://help.yoyogames.com/hc/en-us/articles/360005277377 para obter mais informações


//função de screenshake
function screenshake(_treme = 0, _layer = "layer")
{
    //checando se existe a instancia do objeto shake
    if(instance_exists(obj_screenshake))
    {
        //passando pra ele o valor de tremer
        obj_screenshake.treme = _treme
    }else {
        //se não existir, cria o objeto
    	instance_create_layer(0,0,_layer, obj_screenshake )
    }
}