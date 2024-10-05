extends Node

@export var hunter_scene: PackedScene
@export var prey_scene: PackedScene
@export var number_of_hunters: int = 1
@export var number_of_prey: int = 3

	
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	# Hunter spawner
	for i in range(number_of_hunters):
		var hunter = hunter_scene.instantiate()	
		var spawn_coords = SpawnLogicSingleton.get_3d_coords_from_index(SpawnLogicSingleton.valid_spawn_index())
		hunter.initialize(spawn_coords)
		add_child(hunter)
	
	# Prey spawner
	for i in range(number_of_prey):
		var prey = prey_scene.instantiate()	
		var spawn_coords = SpawnLogicSingleton.get_3d_coords_from_index(SpawnLogicSingleton.valid_spawn_index())
		prey.initialize(spawn_coords)
		add_child(prey)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
