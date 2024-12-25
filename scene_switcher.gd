extends Node


var main_scene: PackedScene = preload("res://main.tscn");
var hdr_tester_scene: PackedScene = preload("res://hdr_tester.tscn");


func index_for_current_scene() -> int:
	match get_tree().current_scene.scene_file_path:
		main_scene.resource_path: return 0;
		hdr_tester_scene.resource_path: return 1;
		_: return -1;


func scene_for_index(index: int) -> PackedScene:
	match index:
		0: return main_scene;
		1: return hdr_tester_scene;
		_: return null;


func change_scene_to_index(index: int) -> void:
	var scene := scene_for_index(index);
	if scene:
		get_tree().change_scene_to_packed(scene);
