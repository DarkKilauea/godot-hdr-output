@tool
class_name SliderControl
extends Control


signal value_changed(value);


@export var min_value: float:
	set(v):
		if is_equal_approx(_min_value, v):
			return;
		
		_min_value = v;
		
		if value_slider:
			value_slider.min_value = v;
	get():
		return _min_value;

@export var max_value: float:
	set(v):
		if is_equal_approx(_max_value, v):
			return;
		
		_max_value = v;
		
		if value_slider:
			value_slider.max_value = v;
	get():
		return _max_value;

@export var step: float = 1.0:
	set(v):
		if is_equal_approx(_step, v):
			return;
		
		_step = v;
		
		if value_slider:
			value_slider.step = v;
	get():
		return _step;

@export var title: String:
	set(v):
		if _title == v:
			return;
		
		_title = v;
		
		if title_label:
			title_label.text = _title;
	get():
		return _title;

@export var value: float:
	set(v):
		if is_equal_approx(_value, v):
			return;
		
		_value = v;
		if value_label:
			value_label.text = "%.2f" % v;
		if value_slider:
			value_slider.set_value_no_signal(v);
	get():
		return _value;


@onready var title_label: Label = $HBoxContainer/TitleLabel
@onready var value_label: Label = $HBoxContainer/ValueLabel
@onready var value_slider: HSlider = $ValueSlider


var _min_value: float;
var _max_value: float;
var _step: float;
var _title: String;
var _value: float;


func _ready() -> void:
	title_label.text = _title;
	value_label.text = "%.2f" % _value;
	value_slider.set_value_no_signal(_value);
	value_slider.max_value = _max_value;
	value_slider.min_value = _min_value;
	value_slider.step = _step;


func _on_value_slider_value_changed(v: float) -> void:
	_value = v;
	value_label.text = "%.2f" % v;
	
	value_changed.emit(v);
