extends Timer

var available_powerups = [preload("res://scene/speed_powerup.tscn")]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func get_random_powerup_type():
	return available_powerups[randi_range(0, available_powerups.size()-1)]

func _on_timeout() -> void:
	SpawnLogicSingleton.check_spawngrid()
	var powerup_scene = get_random_powerup_type()
	var powerup = powerup_scene.instantiate()	
	var spawn_coords = SpawnLogicSingleton.get_3d_coords_from_index(SpawnLogicSingleton.valid_spawn_index())
	powerup.initialize(spawn_coords)
	add_child(powerup)
