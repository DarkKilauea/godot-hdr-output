@tool
class_name InfoLabel
extends Control

@export var title: String:
	set(v):
		if v == _title:
			return;
		
		_title = v;
		
		if title_label:
			title_label.text = _title;
	get():
		return _title;

@export var value: String:
	set(v):
		if v == _value:
			return;
		
		_value = v;
		
		if value_label:
			value_label.text = _value;
	get():
		return _value;


@onready var title_label: Label = %TitleLabel
@onready var value_label: Label = %ValueLabel


var _title: String;
var _value: String;


func _ready() -> void:
	title_label.text = _title;
	value_label.text = _value;
