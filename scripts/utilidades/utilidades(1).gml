// Os recursos de script mudaram para a v2.3.0; veja
// https://help.yoyogames.com/hc/en-us/articles/360005277377 para obter mais informações

//controlar o debug por meio de uma variavel global

#macro DEBUG_MODE 1 
#macro modo_normal:DEBUG_MODE 0
#macro modo_debug:DEBUG_MODE 1  

#macro FPS game_get_speed(gamespeed_fps) 

global.debug = false

//variavel global de universos e enum
global.universos = ["normal","aquatico","inverso","void","bugado"];



//funções


//função de ver se a animação acabou
function animacaoAcabou() 
{
    var _spd = sprite_get_speed(sprite_index) / FPS;
    return image_index + _spd >= image_number
}

//função para trocar a sprite
//metódo para troca de sprite
function trocaSprite(_sprite)
{
    //se a sprite x for diferente da sprite do estado atual
     if(sprite_index != _sprite)
    {
        //vai trocar a sprite atual pela certa
        sprite_index = _sprite
        //e vai zerar a anmiação
        image_index = 0
    }
}