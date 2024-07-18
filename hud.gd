extends Control


@onready var enable_hdr_button: CheckButton = %EnableHDRButton
@onready var max_luminance_value: Label = %MaxLuminanceValue
@onready var max_luminance_slider: HSlider = %MaxLuminanceSlider


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	enable_hdr_button.set_pressed_no_signal(DisplayServer.window_get_hdr_output_enabled());
	max_luminance_slider.set_value_no_signal(DisplayServer.window_get_hdr_output_max_luminance());
	max_luminance_value.text = "%d" % max_luminance_slider.value;


func _on_enable_hdr_button_toggled(toggled_on: bool) -> void:
	DisplayServer.window_set_hdr_output_enabled(toggled_on);


func _on_max_luminance_slider_value_changed(value: float) -> void:
	DisplayServer.window_set_hdr_output_max_luminance(value);
	max_luminance_value.text = "%d" % value;
