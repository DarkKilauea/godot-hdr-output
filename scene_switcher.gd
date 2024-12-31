extends Node


var main_scene: PackedScene = preload("res://main.tscn");
var hdr_tester_scene: PackedScene = preload("res://hdr_tester.tscn");

var scenes := [
	hdr_tester_scene,
	main_scene
];
var scene_names := [
	"HDR Tester",
	"Sponza"
];


func index_for_current_scene() -> int:
	var index := 0;
	var current_scene_path := get_tree().current_scene.scene_file_path;
	
	for scene: PackedScene in scenes:
		if scene.resource_path == current_scene_path:
			return index;
		
		index += 1;
	
	return -1;


func scene_count() -> int:
	return scenes.size();


func scene_for_index(index: int) -> PackedScene:
	if index < 0 or index >= scenes.size():
		return null;
	
	return scenes[index];


func name_for_index(index: int) -> String:
	if index < 0 or index >= scene_names.size():
		return "";
	
	return scene_names[index];


func change_scene_to_index(index: int) -> void:
	var scene := scene_for_index(index);
	if scene:
		get_tree().change_scene_to_packed(scene);
