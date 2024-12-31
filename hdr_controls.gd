extends Control


@onready var _scene_choice: OptionButton = %SceneChoice
@onready var _enable_hdr_button: CheckButton = %EnableHDRButton
@onready var _reference_luminance_slider: SliderControl = %RefLuminanceSlider


func _ready() -> void:
	_enable_hdr_button.set_pressed_no_signal(DisplayServer.window_get_hdr_output_enabled());
	_reference_luminance_slider.value = DisplayServer.window_get_hdr_output_reference_luminance();
	
	# Populate scene menu
	for i in range(SceneSwitcher.scene_count()):
		_scene_choice.add_item(SceneSwitcher.name_for_index(i), i);
	
	# Select the scene we are currently on
	_scene_choice.selected = SceneSwitcher.index_for_current_scene();
	
	# Initialize focus so gamepads and keyboard nav work
	_enable_hdr_button.grab_focus();


func _on_enable_hdr_button_toggled(toggled_on: bool) -> void:
	DisplayServer.window_set_hdr_output_enabled(toggled_on);


func _on_reference_luminance_slider_value_changed(value: float) -> void:
	DisplayServer.window_set_hdr_output_reference_luminance(value);


func _on_scene_choice_item_selected(index: int) -> void:
	SceneSwitcher.change_scene_to_index(index);
