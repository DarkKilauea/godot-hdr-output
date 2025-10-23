extends Control


@onready var _display_server_supports_hdr: InfoLabel = %DisplayServerSupportsHDR
@onready var _render_device_supports_hdr: InfoLabel = %RenderDeviceSupportsHDR
@onready var _window_supports_hdr: InfoLabel = %WindowSupportsHDR
@onready var _window_current_reference_luminance: InfoLabel = %WindowCurrentReferenceLuminance
@onready var _window_current_max_luminance: InfoLabel = %WindowCurrentMaxLuminance
@onready var _max_value: InfoLabel = %MaxValue

@onready var _scene_choice: OptionButton = %SceneChoice

@onready var _enable_hdr_button: CheckButton = %EnableHDRButton
@onready var _custom_reference_luminance: CheckButton = %CustomReferenceLuminance
@onready var _reference_luminance_slider: SliderControl = %ReferenceLuminanceSlider
@onready var _custom_max_luminance: CheckButton = %CustomMaxLuminance
@onready var _max_luminance_slider: SliderControl = %MaxLuminanceSlider


func _update_hdr_info() -> void:
	_display_server_supports_hdr.value = str(DisplayServer.has_feature(DisplayServer.FEATURE_HDR));
	_render_device_supports_hdr.value = str(RenderingServer.get_rendering_device().has_feature(RenderingDevice.SUPPORTS_HDR_OUTPUT));
	
	_window_supports_hdr.value = str(DisplayServer.window_is_hdr_output_supported());
	_window_current_reference_luminance.value = "%.2f" % DisplayServer.window_get_hdr_output_current_reference_luminance();
	_window_current_max_luminance.value = "%.2f" % DisplayServer.window_get_hdr_output_current_max_luminance();


func _update_luminance_slider_visibility() -> void:
	var custom_reference_luminance_enabled: bool = _custom_reference_luminance.button_pressed;
	var custom_max_luminance_enabled: bool = _custom_max_luminance.button_pressed;
	
	_reference_luminance_slider.visible = custom_reference_luminance_enabled;
	_max_luminance_slider.visible = custom_max_luminance_enabled;


func _update_max_value() -> void:
	_max_value.value = "%.2f" % get_window().get_output_max_value();

func _ready() -> void:
	_update_hdr_info();
	
	_enable_hdr_button.set_pressed_no_signal(DisplayServer.window_is_hdr_output_requested());
	_custom_reference_luminance.set_pressed_no_signal(DisplayServer.window_get_hdr_output_reference_luminance() >= 0.0);
	_reference_luminance_slider.value = DisplayServer.window_get_hdr_output_reference_luminance();
	_custom_max_luminance.set_pressed_no_signal(DisplayServer.window_get_hdr_output_max_luminance() >= 0.0);
	_max_luminance_slider.value = DisplayServer.window_get_hdr_output_max_luminance();
	
	_update_max_value();
	_update_luminance_slider_visibility();
	
	# HACK: Need to set the step here in order to avoid the wrong step being used at runtime.
	_reference_luminance_slider.step = 1.0;
	_max_luminance_slider.step = 1.0;
	
	# Populate scene menu
	for i in range(SceneSwitcher.scene_count()):
		_scene_choice.add_item(SceneSwitcher.name_for_index(i), i);
	
	# Select the scene we are currently on
	_scene_choice.selected = SceneSwitcher.index_for_current_scene();
	
	# Initialize focus so gamepads and keyboard nav work
	_enable_hdr_button.grab_focus();


func _physics_process(_delta: float) -> void:
	_update_hdr_info();


func _on_scene_choice_item_selected(index: int) -> void:
	SceneSwitcher.change_scene_to_index(index);


func _on_enable_hdr_button_toggled(toggled_on: bool) -> void:
	get_window().hdr_output_requested = toggled_on;
	_update_max_value();


func _on_reference_luminance_slider_value_changed(value: float) -> void:
	DisplayServer.window_set_hdr_output_reference_luminance(value);
	_update_max_value();


func _on_max_luminance_slider_value_changed(value: float) -> void:
	DisplayServer.window_set_hdr_output_max_luminance(value);
	_update_max_value();


func _on_custom_reference_luminance_toggled(toggled_on: bool) -> void:
	if (toggled_on):
		_reference_luminance_slider.value = DisplayServer.window_get_hdr_output_current_reference_luminance();
		DisplayServer.window_set_hdr_output_reference_luminance(_reference_luminance_slider.value);
	else:
		DisplayServer.window_set_hdr_output_reference_luminance(-1);
	
	_update_max_value();
	_update_luminance_slider_visibility();


func _on_custom_max_luminance_toggled(toggled_on: bool) -> void:
	if (toggled_on):
		_max_luminance_slider.value = DisplayServer.window_get_hdr_output_current_max_luminance();
		DisplayServer.window_set_hdr_output_max_luminance(_max_luminance_slider.value);
	else:
		DisplayServer.window_set_hdr_output_max_luminance(-1);
	
	_update_max_value();
	_update_luminance_slider_visibility();
