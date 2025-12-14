extends Control


@onready var _brightness_slider_control: SliderControl = %BrightnessSliderControl
@onready var _contrast_slider_control: SliderControl = %ContrastSliderControl
@onready var _saturation_slider_control: SliderControl = %SaturationSliderControl
@onready var _world_environment: WorldEnvironment = %WorldEnvironment
@onready var _tonemap_option_button: OptionButton = %TonemapOptionButton

const _tonemappers: Dictionary[Environment.ToneMapper, String] = {
	Environment.TONE_MAPPER_LINEAR: "Linear",
	Environment.TONE_MAPPER_REINHARDT: "Reinhard",
	Environment.TONE_MAPPER_AGX: "AgX"
}


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_brightness_slider_control.value = _world_environment.environment.adjustment_brightness;
	_contrast_slider_control.value = _world_environment.environment.adjustment_contrast;
	_saturation_slider_control.value = _world_environment.environment.adjustment_saturation;
	
	_tonemap_option_button.clear();
	for idx in _tonemappers:
		var option_label := _tonemappers[idx];
		_tonemap_option_button.add_item(option_label, idx);
	
	_tonemap_option_button.select(_world_environment.environment.tonemap_mode);


func _on_brightness_slider_control_value_changed(value: float) -> void:
	_world_environment.environment.adjustment_brightness = value;


func _on_contrast_slider_control_value_changed(value: float) -> void:
	_world_environment.environment.adjustment_contrast = value;


func _on_saturation_slider_control_value_changed(value: float) -> void:
	_world_environment.environment.adjustment_saturation = value;


func _on_tonemap_option_button_item_selected(index: int) -> void:
	_world_environment.environment.tonemap_mode = index as Environment.ToneMapper;
