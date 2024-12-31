@tool
extends Control


@export_range(0.0, 10.0, 0.1) var min_value: float = 0.0:
	set(value):
		min_value = value;
		queue_redraw();


@export_range(0.0, 10.0, 0.1) var max_value: float = 1.0:
	set(value):
		max_value = value;
		queue_redraw();


func _get_minimum_size() -> Vector2:
	return Vector2(32, 32);


func _draw() -> void:
	var points := PackedVector2Array([
		Vector2(0, 0),
		Vector2(size.x, 0),
		Vector2(size.x, size.y),
		Vector2(0, size.y)
	]);
	var colors := PackedColorArray([
		Color(min_value, min_value, min_value),
		Color(max_value, max_value, max_value),
		Color(max_value, max_value, max_value),
		Color(min_value, min_value, min_value)
	]);
	var uvs := PackedVector2Array([
		Vector2(min_value, min_value),
		Vector2(max_value, min_value),
		Vector2(max_value, max_value),
		Vector2(min_value, max_value)
	]);
	
	draw_polygon(points, colors, uvs);
