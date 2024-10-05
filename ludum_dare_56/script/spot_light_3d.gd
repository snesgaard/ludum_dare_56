extends SpotLight3D

@export var min_light = 0.1
@export var max_light = 50.0

@export var min_light_range = 2.0
@export var max_light_range = 18.0

func _on_change_light(change: float) -> void:
	print("changing light energy")
	self.light_energy = clamp(self.light_energy * change, min_light, max_light)
	var hack = (change - 1) * 0.15 + 1
	self.spot_range = clamp(self.spot_range * hack, min_light_range, max_light_range)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Powerup.change_light.connect(_on_change_light)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	#self.light_energy = cos(Time.get_unix_time_from_system() * rng.randf_range(1, 2) * 0.001)
