extends Control


@onready var _enable_hdr_button: CheckButton = %EnableHDRButton
@onready var _3d_max_luminance_slider: SliderControl = %"3dMaxLuminanceSlider"
@onready var _2d_max_luminance_slider: SliderControl = %"2dMaxLuminanceSlider"
@onready var _brightness_slider_control: SliderControl = %BrightnessSliderControl
@onready var _contrast_slider_control: SliderControl = %ContrastSliderControl
@onready var _world_environment: WorldEnvironment = %WorldEnvironment


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_enable_hdr_button.set_pressed_no_signal(DisplayServer.window_get_hdr_output_enabled());
	_3d_max_luminance_slider.value = DisplayServer.window_get_hdr_output_max_luminance();
	# _2d_max_luminance_slider.value = ;
	_brightness_slider_control.value = _world_environment.environment.adjustment_brightness;
	_contrast_slider_control.value = _world_environment.environment.adjustment_contrast;


func _on_enable_hdr_button_toggled(toggled_on: bool) -> void:
	DisplayServer.window_set_hdr_output_enabled(toggled_on);


func _on_3d_max_luminance_slider_value_changed(value: float) -> void:
	DisplayServer.window_set_hdr_output_max_luminance(value);


func _on_2d_max_luminance_slider_value_changed(value: float) -> void:
	pass


func _on_brightness_slider_control_value_changed(value: float) -> void:
	_world_environment.environment.adjustment_brightness = value;


func _on_contrast_slider_control_value_changed(value: float) -> void:
	_world_environment.environment.adjustment_contrast = value;
