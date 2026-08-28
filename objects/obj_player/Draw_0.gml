/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor

//eu mesmo vou me desenhar
draw_sprite_ext(sprite_index, image_index, x, y, xscale * dir, yscale , image_angle, image_blend, image_alpha)

draw_set_halign(1)
draw_set_valign(1)


if (podeDesenhar) {
	draw_text(obj_espelho.x,obj_espelho.y - obj_espelho.sprite_height,"E")
}

draw_set_halign(-1)
draw_set_valign(-1)

//desenha_efeito_squash();