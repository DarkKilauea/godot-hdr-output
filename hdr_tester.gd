extends Control


@onready var _format_info: InfoLabel = %FormatInfo
@onready var _color_space_info: InfoLabel = %ColorSpaceInfo


func _physics_process(delta: float) -> void:
	var screen := get_window().current_screen;
	var device := RenderingServer.get_rendering_device();
	
	var format := device.screen_get_color_format(screen);
	var color_space := device.screen_get_color_space(screen);
	
	match format:
		RenderingDevice.DataFormat.DATA_FORMAT_B8G8R8A8_UNORM: 
			_format_info.value = "DATA_FORMAT_B8G8R8A8_UNORM";
		RenderingDevice.DataFormat.DATA_FORMAT_R8G8B8A8_UNORM: 
			_format_info.value = "DATA_FORMAT_R8G8B8A8_UNORM";
		RenderingDevice.DataFormat.DATA_FORMAT_A2B10G10R10_UNORM_PACK32: 
			_format_info.value = "DATA_FORMAT_A2B10G10R10_UNORM_PACK32";
		RenderingDevice.DataFormat.DATA_FORMAT_A2R10G10B10_UNORM_PACK32:
			_format_info.value = "DATA_FORMAT_A2R10G10B10_UNORM_PACK32";
		RenderingDevice.DataFormat.DATA_FORMAT_R16G16B16A16_SFLOAT:
			_format_info.value = "DATA_FORMAT_R16G16B16A16_SFLOAT";
		_: 
			_format_info.value = "UNKNOWN";
	
	match color_space:
		RenderingDevice.ColorSpace.COLOR_SPACE_SRGB_LINEAR:
			_color_space_info.value = "COLOR_SPACE_SRGB_LINEAR";
		RenderingDevice.ColorSpace.COLOR_SPACE_SRGB_NONLINEAR:
			_color_space_info.value = "COLOR_SPACE_SRGB_NONLINEAR";
		RenderingDevice.ColorSpace.COLOR_SPACE_HDR10_ST2084:
			_color_space_info.value = "COLOR_SPACE_HDR10_ST2084";
		_:
			_color_space_info.value = "UNKNOWN";
