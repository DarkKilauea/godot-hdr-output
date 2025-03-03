extends Control


@onready var _open_file_dialog: FileDialog = %OpenFileDialog
@onready var _selected_file_label: Label = %SelectedFileLabel
@onready var _raw_texture_rect: TextureRect = %RawTextureRect
@onready var _raw_viewport_container: SubViewportContainer = %RawViewportContainer
@onready var _tonemapped_texture_rect: TextureRect = %TonemappedTextureRect
@onready var _tonemap_viewport_container: SubViewportContainer = %TonemapViewportContainer
@onready var _tonemap_viewport: SubViewport = %TonemapViewport

@onready var _tonemap_mode_button: OptionButton = %TonemapModeButton
@onready var _exposure_slider: SliderControl = %ExposureSlider
@onready var _whitepoint_slider: SliderControl = %WhitepointSlider
@onready var _tonemap_to_window_button: CheckButton = %TonemapToWindowButton
@onready var _world_environment: WorldEnvironment = %WorldEnvironment

var _selected_path: String = "";

func _ready() -> void:
	_set_hdr_texture(null, "");
	
	_tonemap_mode_button.selected = _world_environment.environment.tonemap_mode;
	_exposure_slider.value = _world_environment.environment.tonemap_exposure;
	_whitepoint_slider.value = _world_environment.environment.tonemap_white;
	_tonemap_to_window_button.button_pressed = _tonemap_viewport.tonemap_to_window;


func _set_hdr_texture(texture: Texture2D, path: String) -> void:
	if texture:
		_selected_path = path;
		_selected_file_label.text = path.get_file();
		
		_raw_texture_rect.texture = texture;
		_tonemapped_texture_rect.texture = texture;
		
		if texture.get_width() >= texture.get_height():
			_raw_texture_rect.expand_mode = TextureRect.EXPAND_FIT_WIDTH_PROPORTIONAL;
			_tonemapped_texture_rect.expand_mode = TextureRect.EXPAND_FIT_WIDTH_PROPORTIONAL;
		else:
			_raw_texture_rect.expand_mode = TextureRect.EXPAND_FIT_HEIGHT_PROPORTIONAL;
			_tonemapped_texture_rect.expand_mode = TextureRect.EXPAND_FIT_HEIGHT_PROPORTIONAL;
		
		_raw_viewport_container.visible = true;
		_tonemap_viewport_container.visible = true;
	else:
		_selected_path = "";
		_selected_file_label.text = "None";
		
		_raw_texture_rect.texture = null;
		_tonemapped_texture_rect.texture = null;
		
		_raw_viewport_container.visible = false;
		_tonemap_viewport_container.visible = false;


func _on_open_file_button_pressed() -> void:
	_open_file_dialog.current_path = _selected_path;
	_open_file_dialog.popup()


func _on_clear_button_pressed() -> void:
	_set_hdr_texture(null, "");


func _on_file_dialog_file_selected(path: String) -> void:
	if !path or path.is_empty():
		push_error("Blank or empty file selected");
		_set_hdr_texture(null, "");
		return;
	
	var image := Image.load_from_file(path);
	if !image:
		push_error("Image at " + path + " could not be loaded.");
		_set_hdr_texture(null, "");
		return;
	
	var texture := ImageTexture.create_from_image(image);
	if !texture:
		push_error("Could not turn image into a texture.");
		_set_hdr_texture(null, "");
		return;
	
	_set_hdr_texture(texture, path);


func _on_tonemap_mode_button_item_selected(index: int) -> void:
	_world_environment.environment.tonemap_mode = index;


func _on_exposure_slider_value_changed(value: float) -> void:
	_world_environment.environment.tonemap_exposure = value;


func _on_whitepoint_slider_value_changed(value: float) -> void:
	_world_environment.environment.tonemap_white = value;


func _on_tonemap_to_window_button_toggled(toggled_on: bool) -> void:
	_tonemap_viewport.tonemap_to_window = toggled_on;
