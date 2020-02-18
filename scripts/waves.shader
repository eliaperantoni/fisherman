shader_type canvas_item;

uniform vec2 ampiezza = vec2(5.0,2.0);
//Metodo che manipola i vertici dello sprite
void vertex(){
	VERTEX.x += cos(TIME + VERTEX.x + VERTEX.y) * ampiezza.x;
	VERTEX.y += sin(TIME + VERTEX.x + VERTEX.y) * ampiezza.y;
}
