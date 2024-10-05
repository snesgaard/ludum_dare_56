extends Node

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

func check_spawngrid():
	spawn_grid.clear()
	var entities = get_tree().get_nodes_in_group("entities")
	for entity in entities:
		var grid_index = round(entity.position.x) + 9 + ( (round(entity.position.x) + 9) * 18 )
		spawn_grid.push_back(grid_index)
	
