extends SpotLight3D

@export var min_light = 1.0
@export var max_light = 500.0

func _on_change_light(change: float) -> void:
	print("changing light energy")
	self.light_energy = clamp(self.light_energy - change, min_light, max_light)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Powerup.change_light.connect(_on_change_light)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	#self.light_energy = cos(Time.get_unix_time_from_system() * rng.randf_range(1, 2) * 0.001)
