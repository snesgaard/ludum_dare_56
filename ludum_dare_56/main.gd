extends Node

@export var hunter_scene: PackedScene
@export var prey_scene: PackedScene
@export var number_of_hunters: int = 1
@export var number_of_prey: int = 3

var gridsize: int = 18 * 18
var spawn_grid = Array()

func valid_spawn_index(max_retry: int = 10) -> int:
	var spawn_point = randi_range(0, gridsize)
	if spawn_point in spawn_grid and max_retry > 0:
		return valid_spawn_index(max_retry-1)
	spawn_grid.push_back(spawn_point)
	return spawn_point

func get_3d_coords_from_index(index: int) -> Vector3:
	var coords = Vector3.ZERO
	coords.x = (index % 18) - 9 + randf() - 0.5
	coords.z = ( index - coords.x ) / 18 - 9 + randf() - 0.5
	return coords
	
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	# Hunter spawner
	for i in range(number_of_hunters):
		var hunter = hunter_scene.instantiate()	
		var spawn_coords = get_3d_coords_from_index(valid_spawn_index())
		hunter.initialize(spawn_coords)
		add_child(hunter)
	
	# Prey spawner
	for i in range(number_of_prey):
		var prey = prey_scene.instantiate()	
		var spawn_coords = get_3d_coords_from_index(valid_spawn_index())
		prey.initialize(spawn_coords)
		add_child(prey)
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
