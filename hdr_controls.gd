extends Control


@onready var _display_server_supports_hdr: InfoLabel = %DisplayServerSupportsHDR
@onready var _render_device_supports_hdr: InfoLabel = %RenderDeviceSupportsHDR
@onready var _screen_supports_hdr: InfoLabel = %ScreenSupportsHDR

@onready var _screen_min_luminance: InfoLabel = %MinLuminance
@onready var _screen_max_luminance: InfoLabel = %MaxLuminance
@onready var _screen_max_full_luminance: InfoLabel = %MaxFullLuminance
@onready var _screen_sdr_white_level: InfoLabel = %"SDR White Level"

@onready var _scene_choice: OptionButton = %SceneChoice

@onready var _enable_hdr_button: CheckButton = %EnableHDRButton
@onready var _high_precision_buffers: CheckButton = %HighPrecisionBuffers
@onready var _custom_reference_luminance: CheckButton = %CustomReferenceLuminance
@onready var _reference_luminance_slider: SliderControl = %ReferenceLuminanceSlider
@onready var _custom_max_luminance: CheckButton = %CustomMaxLuminance
@onready var _max_luminance_slider: SliderControl = %MaxLuminanceSlider


func _update_screen_info() -> void:
	var screen := get_window().current_screen;
	
	_display_server_supports_hdr.value = str(DisplayServer.has_feature(DisplayServer.FEATURE_HDR));
	_render_device_supports_hdr.value = str(RenderingServer.get_rendering_device().has_feature(RenderingDevice.SUPPORTS_HDR_OUTPUT));
	_screen_supports_hdr.value = str(DisplayServer.screen_is_hdr_supported(screen));
	
	_screen_min_luminance.value = "%.2f" % DisplayServer.screen_get_min_luminance(screen);
	_screen_max_luminance.value = "%.2f" % DisplayServer.screen_get_max_luminance(screen);
	_screen_max_full_luminance.value = "%.2f" % DisplayServer.screen_get_max_full_frame_luminance(screen);
	_screen_sdr_white_level.value = "%.2f" % DisplayServer.screen_get_sdr_white_level(screen);


func _update_luminance_slider_visibility() -> void:
	var custom_reference_luminance_enabled: bool = _custom_reference_luminance.button_pressed;
	var custom_max_luminance_enabled: bool = _custom_max_luminance.button_pressed;
	
	_reference_luminance_slider.visible = custom_reference_luminance_enabled;
	_max_luminance_slider.visible = custom_max_luminance_enabled;


func _ready() -> void:
	_update_screen_info();
	
	var window := get_window();
	_enable_hdr_button.set_pressed_no_signal(window.hdr_output_enabled);
	_high_precision_buffers.set_pressed_no_signal(window.hdr_output_prefer_high_precision);
	_custom_reference_luminance.set_pressed_no_signal(!window.hdr_output_auto_adjust_reference_luminance);
	_reference_luminance_slider.value = window.hdr_output_reference_luminance;
	_custom_max_luminance.set_pressed_no_signal(!window.hdr_output_auto_adjust_max_luminance);
	_max_luminance_slider.value = window.hdr_output_max_luminance;
	
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
	_update_screen_info();


func _on_scene_choice_item_selected(index: int) -> void:
	SceneSwitcher.change_scene_to_index(index);


func _on_enable_hdr_button_toggled(toggled_on: bool) -> void:
	get_window().hdr_output_enabled = toggled_on;


func _on_high_precision_buffers_toggled(toggled_on: bool) -> void:
	get_window().hdr_output_prefer_high_precision = toggled_on;


func _on_reference_luminance_slider_value_changed(value: float) -> void:
	get_window().hdr_output_reference_luminance = value;


func _on_max_luminance_slider_value_changed(value: float) -> void:
	get_window().hdr_output_max_luminance = value;


func _on_custom_reference_luminance_toggled(toggled_on: bool) -> void:
	get_window().hdr_output_auto_adjust_reference_luminance = !toggled_on;
	_reference_luminance_slider.value = get_window().hdr_output_reference_luminance;
	_update_luminance_slider_visibility();


func _on_custom_max_luminance_toggled(toggled_on: bool) -> void:
	get_window().hdr_output_auto_adjust_max_luminance = !toggled_on;
	_max_luminance_slider.value = get_window().hdr_output_max_luminance;
	_update_luminance_slider_visibility();
