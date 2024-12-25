extends Control


@onready var _scene_choice: OptionButton = %SceneChoice
@onready var _enable_hdr_button: CheckButton = %EnableHDRButton
@onready var _reference_luminance_slider: SliderControl = %RefLuminanceSlider


func _ready() -> void:
	_enable_hdr_button.set_pressed_no_signal(DisplayServer.window_get_hdr_output_enabled());
	_reference_luminance_slider.value = DisplayServer.window_get_hdr_output_reference_luminance();
	_scene_choice.selected = SceneSwitcher.index_for_current_scene();


func _on_enable_hdr_button_toggled(toggled_on: bool) -> void:
	DisplayServer.window_set_hdr_output_enabled(toggled_on);


func _on_reference_luminance_slider_value_changed(value: float) -> void:
	DisplayServer.window_set_hdr_output_reference_luminance(value);


func _on_scene_choice_item_selected(index: int) -> void:
	SceneSwitcher.change_scene_to_index(index);
