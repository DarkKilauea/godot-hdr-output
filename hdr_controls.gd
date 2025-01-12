extends Control


@onready var _screen_hdr_available: InfoLabel = %HDRAvailable
@onready var _screen_min_luminance: InfoLabel = %MinLuminance
@onready var _screen_max_luminance: InfoLabel = %MaxLuminance
@onready var _screen_max_full_luminance: InfoLabel = %MaxFullLuminance
@onready var _screen_sdr_white_level: InfoLabel = %"SDR White Level"

@onready var _scene_choice: OptionButton = %SceneChoice

@onready var _enable_hdr_button: CheckButton = %EnableHDRButton
@onready var _high_precision_buffers: CheckButton = %HighPrecisionBuffers
@onready var _reference_luminance_slider: SliderControl = %ReferenceLuminanceSlider
@onready var _min_luminance_slider: SliderControl = %MinLuminanceSlider
@onready var _max_luminance_slider: SliderControl = %MaxLuminanceSlider


func _ready() -> void:
	_screen_hdr_available.value = str(DisplayServer.screen_is_hdr_supported());
	_screen_min_luminance.value = "%.2f" % DisplayServer.screen_get_min_luminance();
	_screen_max_luminance.value = "%.2f" % DisplayServer.screen_get_max_luminance();
	_screen_max_full_luminance.value = "%.2f" % DisplayServer.screen_get_max_average_luminance();
	_screen_sdr_white_level.value = "%.2f" % DisplayServer.screen_get_sdr_white_level();
	
	_enable_hdr_button.set_pressed_no_signal(DisplayServer.window_is_hdr_output_enabled());
	_high_precision_buffers.set_pressed_no_signal(DisplayServer.window_is_hdr_output_preferring_high_precision());
	_reference_luminance_slider.value = DisplayServer.window_get_hdr_output_reference_luminance();
	_min_luminance_slider.value = DisplayServer.window_get_hdr_output_min_luminance();
	_max_luminance_slider.value = DisplayServer.window_get_hdr_output_max_luminance();
	
	# HACK: Need to set the step here in order to avoid the wrong step being used at runtime.
	_reference_luminance_slider.step = 1.0;
	_min_luminance_slider.step = 1.0;
	_max_luminance_slider.step = 1.0;
	
	# Populate scene menu
	for i in range(SceneSwitcher.scene_count()):
		_scene_choice.add_item(SceneSwitcher.name_for_index(i), i);
	
	# Select the scene we are currently on
	_scene_choice.selected = SceneSwitcher.index_for_current_scene();
	
	# Initialize focus so gamepads and keyboard nav work
	_enable_hdr_button.grab_focus();


func _on_scene_choice_item_selected(index: int) -> void:
	SceneSwitcher.change_scene_to_index(index);


func _on_enable_hdr_button_toggled(toggled_on: bool) -> void:
	DisplayServer.window_set_hdr_output_enabled(toggled_on);


func _on_high_precision_buffers_toggled(toggled_on: bool) -> void:
	DisplayServer.window_set_hdr_output_prefer_high_precision(toggled_on);


func _on_reference_luminance_slider_value_changed(value: float) -> void:
	DisplayServer.window_set_hdr_output_reference_luminance(value);


func _on_min_luminance_slider_value_changed(value: float) -> void:
	DisplayServer.window_set_hdr_output_min_luminance(value);


func _on_max_luminance_slider_value_changed(value: float) -> void:
	DisplayServer.window_set_hdr_output_max_luminance(value);
