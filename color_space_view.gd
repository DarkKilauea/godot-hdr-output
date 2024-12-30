@tool
extends Control

const TRIANGLE_SIZE = 128.0;

@export_group("White Point", "whitepoint_")
@export_range(0.001, 1.0, 0.001) var whitepoint_x: float = 0.3127:
	set(value):
		whitepoint_x = value;
		queue_redraw();
@export_range(0.001, 1.0, 0.001) var whitepoint_y: float = 0.3290:
	set(value):
		whitepoint_y = value;
		queue_redraw();

@export_group("Red", "red_")
@export_range(0.001, 1.0, 0.001) var red_x: float = 0.64:
	set(value):
		red_x = value;
		queue_redraw();
@export_range(0.001, 1.0, 0.001) var red_y: float = 0.33:
	set(value):
		red_y = value;
		queue_redraw();

@export_group("Green", "green_")
@export_range(0.001, 1.0, 0.001) var green_x: float = 0.30:
	set(value):
		green_x = value;
		queue_redraw();
@export_range(0.001, 1.0, 0.001) var green_y: float = 0.60:
	set(value):
		green_y = value;
		queue_redraw();

@export_group("Blue", "blue_")
@export_range(0.001, 1.0, 0.001) var blue_x: float = 0.15:
	set(value):
		blue_x = value;
		queue_redraw();
@export_range(0.001, 1.0, 0.001) var blue_y: float = 0.06:
	set(value):
		blue_y = value;
		queue_redraw();


func _get_minimum_size() -> Vector2:
	return Vector2(TRIANGLE_SIZE, TRIANGLE_SIZE);


func _draw() -> void:
	var multiplier := floorf(minf(size.x, size.y));
	
	var points := PackedVector2Array([
		Vector2(red_x * multiplier, size.y - red_y * multiplier),
		Vector2(green_x * multiplier, size.y - green_y * multiplier),
		Vector2(blue_x * multiplier, size.y - blue_y * multiplier)
	]);
	var colors := PackedColorArray([
		Color.RED,
		Color.GREEN,
		Color.BLUE
	]);
	var uvs := PackedVector2Array([
		Vector2(red_x, red_y),
		Vector2(green_x, green_y),
		Vector2(blue_x, blue_y)
	]);
	
	draw_polygon(points, colors, uvs);
