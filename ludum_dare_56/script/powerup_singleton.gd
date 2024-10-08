extends Node

var cat_scene = preload("res://scene/cat.tscn")
var rat_scene = preload("res://scene/creature.tscn")

var powerup_sound = preload("res://sound/powerup.wav")
var powerdown_sound = preload("res://sound/powerdown.wav")

var powerup_player = AudioStreamPlayer.new()
var powerdown_player = AudioStreamPlayer.new()

signal bad_guy_force_change(change: float)
signal change_light(change: float)
signal spawn_more_entity(pos: Vector3, spawn_enemy: bool)

func _on_bad_guy_force_change(change: float) -> void:
	if change > 75:
		powerdown_player.play()
	else:
		powerup_player.play()

func _on_light_change(change: float) -> void:
	if change > 1:
		powerup_player.play()
	else:
		powerdown_player.play()
	
func _spawn_more_entity(pos: Vector3, spawn_enemy: bool) -> void:
	if spawn_enemy:
		powerdown_player.play()
		var cat = cat_scene.instantiate()
		cat.position = pos
		var r = get_tree().root.find_child("PowerUpSpawner", true, false)
		r.add_child(cat)
	else:
		var rat = rat_scene.instantiate()
		rat.position = pos
		var r = get_tree().root.find_child("PowerUpSpawner", true, false)
		r.add_child(rat)
		powerup_player.play()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print(get_tree().root.find_child("PowerUpSpawner", true, false))
	powerup_player.stream = powerup_sound
	powerdown_player.stream = powerdown_sound
	add_child(powerup_player)
	add_child(powerdown_player)
	
	bad_guy_force_change.connect(_on_bad_guy_force_change)
	change_light.connect(_on_light_change)
	spawn_more_entity.connect(_spawn_more_entity)
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
