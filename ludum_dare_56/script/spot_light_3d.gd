extends SpotLight3D

func _on_change_light(change: float) -> void:
	print("changing light energy")
	self.light_energy -= change

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Powerup.change_light.connect(_on_change_light)

var rng = RandomNumberGenerator.new()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	#self.light_energy = cos(Time.get_unix_time_from_system() * rng.randf_range(1, 2) * 0.001)
