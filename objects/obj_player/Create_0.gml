/// @description create do player para iniciar variaveis e métodos
// Você pode escrever seu código neste editor

//iniciando coisas
inicia_efeito_squash();






#region Variaveis basicas

//variaveis de movimento
velh         = 0;
max_velh     = 4;
velv         = 0; 
max_velv     = 7;
grav         = .3;

mudou_dimensao = false

//variaveis de input
right = false;
left  = false;
jump  = false;
agacha = false;

//setando a mascara de colisão
mask_index = spr_player_idle
//variaveis gerais e importantes legais
chao = false

//direção para onde estou olhando
dir = 1

//variavel de lista das colisões



colisoes = [obj_parede, obj_porta]

//variavel para maquina de estados
estado = noone;

//variavel para verificar se morreu:
morreu = false

#endregion
#region Variaveis misc

podeDesenhar = false


#endregion
#region VARIAVEIS DE UNIVERSO

universo_atual = global.universos[0] //dimensão bugada
pode_ir_prabaixo = false;

folego = game_get_speed(gamespeed_fps) * 2

 modo_corrida = false


mudou = false


#endregion



#region métodos basicos

//métodos
pega_input = function()
{
    right =    keyboard_check(ord("D"));
    left =     keyboard_check(ord("A"));
    jump =     keyboard_check(vk_space);
    agacha =      keyboard_check_pressed(vk_shift); 
}
aplica_velocidade = function()
{
    velh = (right - left) * max_velh
    if (velh > 0) {
    	dir = 1;
    }else if(velh < 0) {
    	dir = -1;
    }

    //aplicando a gravidade
    //se eu estou tocando no chao, aplica a gravidade
    //se não estou, gravidade zerada!
    
}

aplica_gravidade = function()
{
    //separando o código de gravidade, da movimentação
     if (!chao) {
        if (velv <= 20) {
        	velv += grav
        }
    	
    }else if (chao && jump) {
    	velv = -max_velv
    }
    else if (chao && velv > -5) {
    	velv = 0
        y = round(y)
    }
    if ( velv < 0 && keyboard_check_released(jump)) {
    	velv = lerp(velv,0,.2)
    }
    
}

//separa o movimento da velocidade/inputs, para poder controlar em ocasiões especificas tipo cutscenes
movimento = function()
{
    //aplicando a velh no eixo x
    move_and_collide(velh,0,colisoes,12)
    
    //colisão no eixo y
    move_and_collide(0,velv,colisoes,12)
}

checar_chao = function() 
{
    chao = place_meeting(x,y+1,colisoes);
}




//método pra checar se a animação acabou
//retorna true


//métodos dos estados

estadoParado = function()
{
    if (universo_atual == global.universos[0]) {
        aplica_velocidade();
        aplica_gravidade();
        
        //setando a colisão dele como maior
        mask_index = spr_player_idle
        
        
        //aqui vai ter todo o código do estado parado
        trocaSprite(spr_player_idle)
        //xor checa se eles são diferentes
        if ( (right xor left) ) {
            estado = estadoMovendo;
        }else if (velv < 0 || velv > 0) {
            if (velv < 0) {
            	instance_create_layer(x,y,"Instances",obj_particula_jump)
                efeito_squash(.5,2);
            }
            estado = estadoPulando;
        } else if (agacha) {
            estado = estadoEntrandoagacha;
        }else if (morreu) {
        	estado = estadoDeMorte;
        }
    }
    else if (universo_atual == global.universos[1]) { //se estiver no universo aquático
        
        //tudo que estiver aqui em baixo, vai rodar só no universo aquático
        var ta_livre
        //aplicando a movimentação
        aplica_velocidade();
        //setando a maskara de colisão
        mask_index = spr_player_idle;
        
        //setando a sprite
        trocaSprite(spr_player_idle_agua)
        
        
         if (!place_meeting(x,y - sprite_get_width(spr_player_idle_agua)-5,obj_parede)) {
        	ta_livre = true
        }else if (place_meeting(x,y - sprite_get_width(spr_player_idle_agua)-5,obj_parede)) {
        	ta_livre = false;
        }
        
        
        //enquanto ele não estiver no solo, a gravidade vai ser aplicada
        grav = .008
        if (!chao) {
            if (velv <= 3.5) {
            	velv += grav
            }
        }
        if (velv > 0 && chao) {
            instance_create_layer(x,y,"Instances",obj_particula_jump)
            efeito_squash(2,.5);
            velv = 0
        }
        
        //parte de troca de estado
         if((right xor left) || ta_livre == false )
        {
            estado = estadoMovendo;
        }else if (velv > 0 || velv < 0) {
            estado = estadoPulando;
        }else if (morreu) {
        	estado = estadoDeMorte;
        }else if (agacha) {
            pode_ir_prabaixo = true
        	estado = estadoagacha;
        }
    }
    else if (universo_atual == global.universos[2]) {//se estiver no universo invertido
    	//tudo daqui pra baixo vai rodar só no mundo invertido
        
        //setando os comandos invertidos
        right = keyboard_check(ord("A"))
        left = keyboard_check(ord("D"))
        jump = keyboard_check_pressed(vk_shift);
        agacha = keyboard_check_pressed(vk_space)
        
        aplica_velocidade();
        aplica_gravidade();
        
        //setando a colisão dele como maior
        mask_index = spr_player_idle
        
        //aqui vai ter todo o código do estado parado
        trocaSprite(spr_player_idle)
        //xor checa se eles são diferentes
        if (right xor left) {
            estado = estadoMovendo;
        }else if (velv < 0 || velv > 0) {
            if (velv < 0) {
            	instance_create_layer(x,y,"Instances",obj_particula_jump)
                efeito_squash(.5,2);
            }
            estado = estadoPulando;
        } else if (agacha) {
            estado = estadoEntrandoagacha;
        }else if (morreu) {
        	estado = estadoDeMorte;
        }
    }
    else if (universo_atual == global.universos[3]) { //se estiver no universo void
        
        aplica_velocidade();
        aplica_gravidade();
        
        //setando a colisão dele como maior
        mask_index = spr_player_idle
        
        //aqui vai ter todo o código do estado parado
        trocaSprite(spr_player_idle)
        //xor checa se eles são diferentes
        if ((right xor left) && x <= 330) {
            estado = estadoMovendo;
        }else if (velv < 0 || velv > 0) {
            if (velv < 0) {
            	instance_create_layer(x,y,"Instances",obj_particula_jump)
                efeito_squash(.5,2);
            }
            estado = estadoPulando;
        }else if (morreu) {
        	estado = estadoDeMorte;
        }else if ( (right xor left) && x > 330 ) {
            estado = estadoCorrendo;
        }
    }
    else if (universo_atual == global.universos[4]) {
        aplica_velocidade();
        aplica_gravidade();
        
        //setando a colisão dele como maior
        mask_index = spr_player_idle
        
        
        //aqui vai ter todo o código do estado parado
        trocaSprite(spr_player_idle)
        //xor checa se eles são diferentes
        if ( (right xor left) ) {
            estado = estadoMovendo;
        }else if (velv < 0 || velv > 0) {
            if (velv < 0) {
            	instance_create_layer(x,y,"Instances",obj_particula_jump)
                efeito_squash(.5,2);
            }
            estado = estadoPulando;
        } else if (agacha) {
            estado = estadoEntrandoagacha;
        }else if (morreu) {
        	estado = estadoDeMorte;
        }
    }
}
estadoMovendo = function()
{
    if (universo_atual == global.universos[0]) {
        //isso só vai rodar, se tiver na dimensão normal
        mask_index = spr_player_idle
        max_velh = 2
        aplica_velocidade();
        aplica_gravidade();
         //aqui vai ter todos os códigos e logica relacionada ao movimento
        trocaSprite(spr_player_move)
        if (velh == 0 || (right && left)) {
        	estado = estadoParado;
        }else if (velv < 0 || velv > 0) {
            if (velv < 0) {
            	instance_create_layer(x,y,"Instances",obj_particula_jump)
                efeito_squash(.5,2);
            }
            estado = estadoPulando;
        }else if (agacha) {
            velh = 0
        	estado = estadoEntrandoagacha;
        }else if (morreu) {
        	estado = estadoDeMorte;
        }
    }
    else if (universo_atual == global.universos[1]){
    	//isso so vai rodar, se tiver na dimensão de água
        //setando a velocidade maxima que ele alcança
        max_velh = 1.5
        //aplicando a velocidade
        aplica_velocidade()
        
        var ta_livre = false
        
        //aplicando a gravidade
        grav = .008
   
        //trocando sprite
        trocaSprite(spr_player_move_agua);
        mask_index = spr_player_move_agua_colisao;
        
        if (!place_meeting(x,y - sprite_get_width(spr_player_idle_agua)-5,obj_parede)) {
        	ta_livre = true
        }else if (place_meeting(x,y - sprite_get_width(spr_player_idle_agua)-5,obj_parede)) {
        	ta_livre = false;
        }
        
        if (place_meeting(x,y + sprite_get_width(spr_player_idle_agua)/2,obj_parede) && !place_meeting(x,y - sprite_get_width(spr_player_idle_agua)-5,obj_parede)) {
        	y -= sprite_get_width(spr_player_idle_agua)/2  - 5
            velv = 0
            grav = 0
        }
        
        if (!chao) {
            if (velv <= 3.5) {
            	velv += grav
            }
        }
        
        //trocando os estados
        if ( velv > 0 || velv < 0) {
            estado = estadoPulando;
        }else if (morreu) {
        	estado = estadoDeMorte;
        }else if (agacha) {
            pode_ir_prabaixo = true
        	estado = estadoagacha;
        } else if (  ta_livre) {
            if ((velh == 0 || (right && left))) {
            	estado = estadoParado;
            }
        }
    }
    else if (universo_atual == global.universos[2]) {
    	
        mask_index = spr_player_idle
        right = keyboard_check(ord("A"))
        left = keyboard_check(ord("D"))
        jump = keyboard_check_pressed(vk_shift);
        agacha = keyboard_check_pressed(vk_space)
        
        max_velh = 2
        aplica_velocidade();
        aplica_gravidade();
         //aqui vai ter todos os códigos e logica relacionada ao movimento
        trocaSprite(spr_player_move)
        if (velh == 0 || (right && left)) {
        	estado = estadoParado;
        }else if (velv < 0 || velv > 0) {
            if (velv < 0) {
            	instance_create_layer(x,y,"Instances",obj_particula_jump)
                efeito_squash(.5,2);
            }
            estado = estadoPulando;
        }else if (agacha) {
            velh = 0
        	estado = estadoEntrandoagacha;
        }else if (morreu) {
        	estado = estadoDeMorte;
        }
        
        
    }
    else if (universo_atual == global.universos[3]) {
    //isso só vai rodar, se tiver na dimensão do void
        mask_index = spr_player_idle
        max_velh = .5
        image_speed = .4
        aplica_velocidade();
        aplica_gravidade();
         //aqui vai ter todos os códigos e logica relacionada ao movimento
        trocaSprite(spr_player_move)
        if (velh == 0 || (right && left)) {
        	estado = estadoParado;
        }else if (velv < 0 || velv > 0) {
            if (velv < 0) {
            	instance_create_layer(x,y,"Instances",obj_particula_jump)
                efeito_squash(.5,2);
            }
            estado = estadoPulando;
        }else if (morreu) {
        	estado = estadoDeMorte;
        }else if (x > 330 ) {
            estado = estadoCorrendo;
        }
    }
    else if (universo_atual == global.universos[4]) {
        //isso só vai rodar, se tiver na dimensão bugada
        
        mask_index = spr_player_idle
        max_velh = 2
        aplica_velocidade();
        aplica_gravidade();
         //aqui vai ter todos os códigos e logica relacionada ao movimento
        trocaSprite(spr_player_move)
        if (velh == 0 || (right && left)) {
        	estado = estadoParado;
        }else if (velv < 0 || velv > 0) {
            if (velv < 0) {
            	instance_create_layer(x,y,"Instances",obj_particula_jump)
                efeito_squash(.5,2);
            }
            estado = estadoPulando;
        }else if (agacha) {
            velh = 0
        	estado = estadoEntrandoagacha;
        }else if (morreu) {
        	estado = estadoDeMorte;
        }
    }
}
estadoPulando = function()
{
    if (universo_atual == global.universos[0]) {
        //isso só vai rodar, se tiver na dimensão normal
        mask_index = spr_player_idle
        aplica_velocidade();
        aplica_gravidade();
        trocaSprite(spr_player_jump)
        
        //aqui vai ter todos os códigos e logica relacionada ao movimento
        
        sprite_index = spr_player_jump
        
        //arrumando o bug de ele continuar com a velv quando fica preso embaixo de uma parede
        if (place_meeting(x,y-1,colisoes)) {
            //se tiver uma parede em cima, ele vai cair direto
        	velv = !velv
        }
        
        //caso ele esteja caindo, vai mudar a sprite para o fall
        if (velv > 0) {
            trocaSprite(spr_player_jump_fall)
        	sprite_index = spr_player_jump_fall
            
        }else if (velv == 0 && chao) {
        	instance_create_layer(x,y,"Instances",obj_player_fall);
            efeito_squash(1.6,.7);
            estado = estadoParado;
        }else if (morreu) {
        	estado = estadoDeMorte;
        }
    }
    else if (universo_atual == global.universos[1]){
    	//isso so vai rodar, se tiver na dimensão de água
        aplica_velocidade()
        
        var ta_livre
        
        //setando valor do max_velv
        max_velv = .8
        
        //aplicando gravidade
        grav = .008
        
        //fazer o pulo dele amanha
        if (jump) {
        	velv = -max_velv
            efeito_squash(.5,1.5);
        }
        if (!chao) {
            if (velv <= 3.5) {
            	velv += grav 
            }   
        }
        
        
        
        if (!place_meeting(x,y - sprite_get_width(spr_player_idle_agua)-5,obj_parede)) {
        	ta_livre = true
        }else if (place_meeting(x,y - sprite_get_width(spr_player_idle_agua)-5,obj_parede)) {
        	ta_livre = false;
        }
            
        
        //trocando os estados
         if((right xor left) || ta_livre == false)
        {
            estado = estadoMovendo;
        }else if (morreu) {
        	estado = estadoDeMorte;
        }else if (agacha) {
            pode_ir_prabaixo = true
        	estado = estadoagacha;
        }else if (ta_livre) { 
            if (velv >= 0 || velh == 0) {
            	estado = estadoParado;
            }
        }
    }
    else if (universo_atual == global.universos[2]) {
        mask_index = spr_player_idle
        right = keyboard_check(ord("A"))
        left = keyboard_check(ord("D"))
        jump = keyboard_check(vk_shift);
        agacha = keyboard_check_pressed(vk_space);
        
        aplica_velocidade();
        aplica_gravidade();
        trocaSprite(spr_player_jump)
        
        //aqui vai ter todos os códigos e logica relacionada ao movimento
        
        sprite_index = spr_player_jump
        
        //arrumando o bug de ele continuar com a velv quando fica preso embaixo de uma parede
        if (place_meeting(x,y-1,colisoes)) {
            //se tiver uma parede em cima, ele vai cair direto
        	velv = !velv
        }
        
        //caso ele esteja caindo, vai mudar a sprite para o fall
        if (velv > 0) {
            trocaSprite(spr_player_jump_fall)
        	sprite_index = spr_player_jump_fall
            
        }else if (velv == 0 && chao) {
        	instance_create_layer(x,y,"Instances",obj_player_fall);
            efeito_squash(1.6,.7);
            estado = estadoParado;
        }else if (morreu) {
        	estado = estadoDeMorte;
        }
    }
    else if (universo_atual == global.universos[3]){
        //isso só vai rodar, se tiver na dimensão void
        mask_index = spr_player_idle
        aplica_velocidade();
        aplica_gravidade();
        trocaSprite(spr_player_jump)
        
        //aqui vai ter todos os códigos e logica relacionada ao movimento
        
        sprite_index = spr_player_jump
        
        //arrumando o bug de ele continuar com a velv quando fica preso embaixo de uma parede
        if (place_meeting(x,y-1,colisoes)) {
            //se tiver uma parede em cima, ele vai cair direto
        	velv = !velv
        }
        
        //caso ele esteja caindo, vai mudar a sprite para o fall
        if (velv > 0) {
            trocaSprite(spr_player_jump_fall)
        	sprite_index = spr_player_jump_fall
            
        }else if (velv == 0 && chao) {
        	instance_create_layer(x,y,"Instances",obj_player_fall);
            efeito_squash(1.6,.7);
            estado = estadoParado;
        }else if (morreu) {
        	estado = estadoDeMorte;
        }
    }
    else if (universo_atual == global.universos[4]) {
        //isso só vai rodar, se tiver na dimensão normal
        mask_index = spr_player_idle
        aplica_velocidade();
        aplica_gravidade();
        trocaSprite(spr_player_jump)
        
        //aqui vai ter todos os códigos e logica relacionada ao movimento
        
        sprite_index = spr_player_jump
        
        //arrumando o bug de ele continuar com a velv quando fica preso embaixo de uma parede
        if (place_meeting(x,y-1,colisoes)) {
            //se tiver uma parede em cima, ele vai cair direto
        	velv = !velv
        }
        
        //caso ele esteja caindo, vai mudar a sprite para o fall
        if (velv > 0) {
            trocaSprite(spr_player_jump_fall)
        	sprite_index = spr_player_jump_fall
            
        }else if (velv == 0 && chao) {
        	instance_create_layer(x,y,"Instances",obj_player_fall);
            efeito_squash(1.6,.7);
            estado = estadoParado;
        }else if (morreu) {
        	estado = estadoDeMorte;
        }
    }
}

//estado entrando na agacha
estadoEntrandoagacha = function()
{
    
    //isso só vai rodar, se tiver na dimensão normal
    
    trocaSprite(spr_player_agacha_entrar)
    if (animacaoAcabou()) {
        estado = estadoagacha;
    }else if (morreu) {
        estado = estadoDeMorte;
    }
    
}
//estado do começo da animação da agacha

//estado de agacha
estadoagacha = function()
{
    if (universo_atual == global.universos[0]) {
        //isso só vai rodar, se tiver na dimensão normal
        if (!chao) {
           if (velv <= 20) {
           	velv += grav
           }
        }
        
        trocaSprite(spr_agacha)
        
        //aplicando velocidade dele pra andar
        if (right || left) {
        	estado = estadoAgachaAnda;
        }
        mask_index = spr_agacha_colisao
        //fazendo ele andar apenas se tiver chão em baixo
        if (agacha && !place_meeting(x,y - sprite_get_width(spr_player_idle) / 2-5,obj_parede) ) {
            velh = 0;
        	estado = estadoSaindoagacha;
        }else if (morreu) {
        	estado = estadoDeMorte;
        }
    }
    else if (universo_atual == global.universos[1]){
         //isso só vai rodar se tiver a dimensão aquatica
         //aplica a velocidade
        max_velv = .8
        aplica_velocidade();
        grav = .008
        
        
        if(pode_ir_prabaixo)
        {
            velv = +max_velv *1.3
        }else {
        	velv = 0
        }
        
        if (!chao) {
            if (velv <= 3.5) {
            	velv += grav 
            }   
        }
        pode_ir_prabaixo = false
        
            
         
        if (velv >= 0 && velh == 0) {
        	estado = estadoParado;
        }else if(right xor left)
        {
            estado = estadoMovendo;
        }else if (morreu) {
        	estado = estadoDeMorte;
        } else if ( velv > 0 || velv <= 0) {
            estado = estadoPulando;
        }
    }
    else if (universo_atual == global.universos[2]) {
        right = keyboard_check(ord("A"))
        left = keyboard_check(ord("D"))
        jump = keyboard_check_pressed(vk_shift);
        agacha = keyboard_check_pressed(vk_space);
        
        if (!chao) {
           if (velv <= 20) {
           	velv += grav
           }
        }
        
        
        trocaSprite(spr_agacha)
        
        //aplicando velocidade dele pra andar
        if (right || left) {
        	estado = estadoAgachaAnda;
        }
        mask_index = spr_agacha_colisao
        //fazendo ele andar apenas se tiver chão em baixo
        if (agacha && !place_meeting(x,y - sprite_get_width(spr_player_idle) / 2 - 5,obj_parede) ) {
            velh = 0;
        	estado = estadoSaindoagacha;
        }else if (morreu) {
        	estado = estadoDeMorte;
        }
        
        
    }
    else if (universo_atual == global.universos[4]){
         //isso só vai rodar, se tiver na dimensão bugada
        if (!chao) {
           if (velv <= 20) {
           	velv += grav
           }
        }
        
        
        trocaSprite(spr_agacha)
        
        //aplicando velocidade dele pra andar
        if (right || left) {
        	estado = estadoAgachaAnda;
        }
        mask_index = spr_agacha_colisao
        //fazendo ele andar apenas se tiver chão em baixo
        if (agacha && !place_meeting(x,y - sprite_get_width(spr_player_idle) / 2 - 5,obj_parede) ) {
            velh = 0;
        	estado = estadoSaindoagacha;
        }else if (morreu) {
        	estado = estadoDeMorte;
        }
    }
}

estadoAgachaAnda = function()
{
    if (universo_atual == global.universos[0]) {
        //isso só vai rodar, se tiver na dimensão normal
        max_velh = 1;
        aplica_velocidade();
        if (!chao) {
           if (velv <= 20) {
           	velv += grav
           }
        }
        
        trocaSprite(spr_agacha_anda)
        mask_index = spr_agacha_colisao
        
        
        
        if (agacha && !place_meeting(x,y - sprite_get_width(spr_player_idle) / 2- 5,obj_parede)) {
            velh = 0;
            estado = estadoSaindoagacha;
        }else if( velh = 0){
            estado = estadoagacha;
        }else if (morreu) {
        	estado = estadoDeMorte;
        }
    }
    else if (universo_atual == global.universos[2]) {
        right = keyboard_check(ord("A"))
        left = keyboard_check(ord("D"))
        jump = keyboard_check_pressed(vk_shift);
        agacha = keyboard_check_pressed(vk_space);
        
        
        max_velh = 1;
        aplica_velocidade();
        if (!chao) {
           if (velv <= 20) {
           	velv += grav
           }
        }
        
        trocaSprite(spr_agacha_anda)
        mask_index = spr_agacha_colisao
        
        
        if (agacha && !place_meeting(x,y - sprite_get_width(spr_player_idle) / 2 -5,obj_parede)) {
            velh = 0;
            estado = estadoSaindoagacha;
        }else if( velh = 0){
            estado = estadoagacha;
        }else if (morreu) {
        	estado = estadoDeMorte;
        }
    }
    else if (universo_atual == global.universos[4]) {
        //isso só vai rodar, se tiver na dimensão normal
        max_velh = 1;
        aplica_velocidade();
        if (!chao) {
           if (velv <= 20) {
           	velv += grav
           }
        }
        
        trocaSprite(spr_agacha_anda)
        mask_index = spr_agacha_colisao
        
        
        
        if (agacha && !place_meeting(x,y - sprite_get_width(spr_player_idle) / 2 - 5,obj_parede)) {
            velh = 0;
            estado = estadoSaindoagacha;
        }else if( velh = 0){
            estado = estadoagacha;
        }else if (morreu) {
        	estado = estadoDeMorte;
        }
    }
}

//estado de morte
estadoDeMorte = function()
{
    room_goto(rm_introducao);
    
    
}


//saindo da agacha ele volta pro parado
estadoSaindoagacha = function()
{
    //isso só vai rodar, se tiver na dimensão normal
    trocaSprite(spr_player_agacha_sair)
    if (animacaoAcabou()) {
        mask_index = spr_player_idle
        estado = estadoParado;
    }else if (morreu) {
        estado = estadoDeMorte;
    }

}

//estado de correndo
estadoCorrendo = function()
{
     max_velh = 5
    aplica_velocidade();
    aplica_gravidade();
    //aqui vai ter todos os códigos e logica relacionada ao movimento
    trocaSprite(spr_player_corre)
    
    
    if (velh == 0 || (right && left)) {
        estado = estadoParado;
    }else if (velv < 0 || velv > 0) {
        if (velv < 0 && chao) {
            instance_create_layer(x,y,"Instances",obj_particula_jump)
            efeito_squash(.5,2);
        }
        estado = estadoPulando;
    }else if (morreu) {
        estado = estadoDeMorte;
    }
}

#endregion

#region métodos misc


//fazendo o efeito de reflexo
interagircEspelho = function()
{
    //pegando a proximidade dele com o espelho   
    var _perto = place_meeting(x + sprite_get_width(spr_espelho)/2 - 10,y,obj_espelho);
    var _marg = 10;
    
    var _range_espelho = _perto || place_meeting(x - sprite_get_width(spr_espelho)/2,y,obj_espelho)
    
    if (_perto) {
        if (!instance_exists(obj_playerReflexo)) {
        	 var _reflexo = instance_create_layer(20,20,"reflexo",obj_playerReflexo)
        }
        //setando o range para interagir com o E
        
    }else {
    	if (instance_exists(obj_playerReflexo)) {
        	instance_destroy(obj_playerReflexo)
        }
        
        if (!_perto || place_meeting(x - sprite_get_width(spr_espelho)/2,y,obj_espelho) ) {
        	
        }
    }
    
    if ( x < obj_espelho.x + sprite_get_width(spr_espelho)/2 ) && (x > obj_espelho.x - sprite_get_width(spr_espelho)/2) {
        	podeDesenhar = true
            if (keyboard_check_pressed(ord("E")) && (global.usou_espelho == false)) {
            	show_debug_message("INTERAGIDO, PAEZÃO")
                room_goto(obj_espelho.destino)
                if (global.ativou_espelho == false) {
                	   global.ativou_espelho = true
                }else if (global.ativou_espelho == true) {
                	global.ativou_espelho = false;
                    global.usou_espelho = true
                }
            }
        }else {
        	podeDesenhar = false
        }
}

deitar_na_cama = function()
{
    dir = 1
    velv = 0
    velh = 0
    sprite_index = spr_player_deitado
    if (global.morreu_deitar == true) {
    	image_index = image_number -1
    }
    x = obj_cama.x - sprite_get_width(spr_cama)/2 + 17
    y = obj_cama.y -5
    if (animacaoAcabou()) {
    	image_index = image_number - 1
    }
    if (jump) {
    	estado = estadoPulando;
    }
}







#endregion
#region métodos universo


afogamento = function()
{
    //faze com que a frequencia do lerp aumente
    if ((folego < 80 && folego >= 60)){
        retorna_squash(.2)
        
    }else if ((folego < 60 && folego >= 40)) {
        retorna_squash(.3)
        
        
    }else if ((folego < 40 && folego >= 20)) {
        retorna_squash(.4)
        
    }else if ((folego < 20 && folego > 0)) {
        
        retorna_squash(.5)
    }
    
    //fazer efeito de afogamento
    if (!place_meeting(x,y,obj_ar)) {
    	folego -= .1
        if (folego >= 100 && (xscale = 1 && yscale = 1)) {
        	//inicia o efeito na proxima
        }else if ((folego < 100 && folego >= 80) && (xscale = 1 && yscale = 1)) {
        	efeito_squash(1.2,1.2)
            
        }else if ((folego < 80 && folego >= 60) && (xscale = 1 && yscale = 1)) {
        	
            efeito_squash(1.4,1.4)
            
        }else if ((folego < 60 && folego >= 40) && (xscale = 1 && yscale = 1)) {
        	retorna_squash(.3)
            efeito_squash(1.6,1.6)
            
        }else if ((folego < 40 && folego >= 20) && (xscale = 1 && yscale = 1)) {
        	efeito_squash(1.8,1.8)
            
        }else if ((folego < 20 && folego > 0) && (xscale = 1 && yscale = 1)) {
        	efeito_squash(2,2)
            retorna_squash(.5)
        }else if ((folego <= 0) && (xscale = 1 && yscale = 1)) {
        	estado = estadoDeMorte;
            folego = 0;
        }
        show_debug_message(folego)
    }else {
    	folego = game_get_speed(gamespeed_fps) * 2
    }
}

//método para criar luz
criar_luz = function()
{
    //controlando o objeto poste
    with (obj_poste) {
        if (criei == false) {
        	var _luz = instance_create_layer(x,y,"luz", obj_luz)
            criei = true
            _luz.pai = id
        }
    }
}



#endregion

#region Debug

view_player = noone

//método de debug do jogo

roda_debug = function()
{
    
    show_debug_overlay(1)
    
    //criando um view pro debug
    view_player = dbg_view("View_player ",1, 40, 100, 300, 400)
    
    //variaveis para hospedar as variaveis reais e exibir no debug overlayer
    var _velv = ref_create(id, "velv");
    var _velh = ref_create(id, "velh");
    var _grav = ref_create(id, "grav");
    var _max_velv = ref_create(id, "max_velv");
    var _max_velh = ref_create(id, "max_velh");
    
    //dbg_watch serve para observar o valor de alguma variavel
    dbg_watch(_velv,"Velocidade Vertical");
    dbg_watch(_velh,"Velocidade Horizontal");
    
    //dbg_slider serve para testar deversos valores dentro do jogo mesmo
    dbg_slider(_max_velv,0,10,"Velocidade Máxima Vertical", .1);
    dbg_slider(_grav,0,2,"Gravidade", .01);
    dbg_slider(_max_velh,0,20,"Velocidade horizontal", 1);
    
}    

ativando_debug = function()
{
    if (DEBUG_MODE == 0)return;
    
    if(keyboard_check_pressed(vk_tab))
    {
        global.debug = !global.debug
        //fazendo ele ativar o debug caso seja true
        if(global.debug)
        {
            roda_debug();
        }   
        else 
        {
            //desativo o debug overlay
            show_debug_overlay(0)
            //desativando a janela do view
            if (dbg_view_exists(view_player)) 
                {
                	dbg_view_delete(view_player)
                }	
        }
    }
}



#endregion


//AS ultimas coisas que eu faço no create
//definir o estado do player

//fazendo isso, estamos salvando o código do estadoParado dentro da variavel estado
//como se fosse uma macro
//sem parenteses ele salva o conteudo, com parenteses ele salva o retorno
estado = estadoParado;