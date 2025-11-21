extends MeshInstance3D


var glow_material: StandardMaterial3D;


func _ready() -> void:
	glow_material = StandardMaterial3D.new();
	glow_material.albedo_color = Color.BLACK.linear_to_srgb();
	glow_material.emission_enabled = true;
	glow_material.emission = Color.RED.linear_to_srgb();
	glow_material.emission_energy_multiplier = DisplayServer.window_get_output_max_linear_value();
	
	material_override = glow_material;


func _process(_delta: float) -> void:
	glow_material.emission_energy_multiplier = DisplayServer.window_get_output_max_linear_value();
