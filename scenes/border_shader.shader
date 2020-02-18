shader_type canvas_item;
uniform vec2 ampiezza = vec2(15.0,1.0);
//Manipolazione vertici dell'immagine
void vertex(){
	VERTEX.x += cos(TIME + VERTEX.x + VERTEX.y)*ampiezza.x;
	VERTEX.y += sin(TIME + VERTEX.x + VERTEX.y)*ampiezza.y;
	
}