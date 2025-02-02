extends Control


@onready var _brightness_slider_control: SliderControl = %BrightnessSliderControl
@onready var _contrast_slider_control: SliderControl = %ContrastSliderControl
@onready var _saturation_slider_control: SliderControl = %SaturationSliderControl
@onready var _world_environment: WorldEnvironment = %WorldEnvironment


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_brightness_slider_control.value = _world_environment.environment.adjustment_brightness;
	_contrast_slider_control.value = _world_environment.environment.adjustment_contrast;
	_saturation_slider_control.value = _world_environment.environment.adjustment_saturation;


func _on_brightness_slider_control_value_changed(value: float) -> void:
	_world_environment.environment.adjustment_brightness = value;


func _on_contrast_slider_control_value_changed(value: float) -> void:
	_world_environment.environment.adjustment_contrast = value;


func _on_saturation_slider_control_value_changed(value: float) -> void:
	_world_environment.environment.adjustment_saturation = value;
