extends Control


@onready var open_file_dialog: FileDialog = %OpenFileDialog
@onready var raw_texture_rect: TextureRect = %RawTextureRect
@onready var tonemapped_texture_rect: TextureRect = %TonemappedTextureRect
@onready var world_environment: WorldEnvironment = %WorldEnvironment


func _set_hdr_texture(texture: Texture2D) -> void:
	if texture:
		raw_texture_rect.texture = texture;
		tonemapped_texture_rect.texture = texture;
		
		if texture.get_width() >= texture.get_height():
			raw_texture_rect.expand_mode = TextureRect.EXPAND_FIT_WIDTH_PROPORTIONAL;
			tonemapped_texture_rect.expand_mode = TextureRect.EXPAND_FIT_WIDTH_PROPORTIONAL;
		else:
			raw_texture_rect.expand_mode = TextureRect.EXPAND_FIT_HEIGHT_PROPORTIONAL;
			tonemapped_texture_rect.expand_mode = TextureRect.EXPAND_FIT_HEIGHT_PROPORTIONAL;
		
		raw_texture_rect.visible = true;
		tonemapped_texture_rect.visible = true;
	else:
		raw_texture_rect.texture = null;
		raw_texture_rect.visible = false;
		tonemapped_texture_rect.texture = null;
		tonemapped_texture_rect.visible = false;


func _on_open_file_button_pressed() -> void:
	open_file_dialog.popup()


func _on_clear_button_pressed() -> void:
	_set_hdr_texture(null);


func _on_file_dialog_file_selected(path: String) -> void:
	if !path or path.is_empty():
		push_error("Blank or empty file selected");
		_set_hdr_texture(null);
		return;
	
	var image := Image.load_from_file(path);
	if !image:
		push_error("Image at " + path + " could not be loaded.");
		_set_hdr_texture(null);
		return;
	
	var texture := ImageTexture.create_from_image(image);
	if !texture:
		push_error("Could not turn image into a texture.");
		_set_hdr_texture(null);
		return;
	
	_set_hdr_texture(texture);
