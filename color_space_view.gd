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
		xyYToRec709(Vector2(red_x, red_y)),
		xyYToRec709(Vector2(green_x, green_y)),
		xyYToRec709(Vector2(blue_x, blue_y)),
	]);
	var uvs := PackedVector2Array([
		Vector2(red_x, red_y),
		Vector2(green_x, green_y),
		Vector2(blue_x, blue_y)
	]);
	
	draw_polygon(points, colors, uvs);


func xyYToRec709(xy: Vector2, Y: float = 1.0) -> Color:
	# https://github.com/ampas/aces-dev/blob/v1.0.3/transforms/ctl/README-MATRIX.md
	const XYZtoRGB := Basis(
		Vector3(3.2409699419, -0.9692436363, 0.0556300797),
		Vector3(-1.5373831776, 1.8759675015, -0.2039769589),
		Vector3(-0.4986107603, 0.0415550574, 1.0569715142)
	);
	
	var XYZ: Vector3 = Y * Vector3(xy.x / xy.y, 1.0, (1.0 - xy.x - xy.y) / xy.y);
	var RGB: Vector3 = XYZtoRGB * XYZ;
	var maxChannel: float = maxf(RGB.x, maxf(RGB.y, RGB.z));
	var final: Vector3 = RGB / maxf(maxChannel, 1.0);
	return Color(final.x, final.y, final.z);
