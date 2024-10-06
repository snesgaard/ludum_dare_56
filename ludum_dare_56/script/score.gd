extends Node

var score: int = 0
var hit_sound = preload("res://sound/hit.wav")
var hit_player = AudioStreamPlayer.new()
var main_scene = preload("res://main.tscn")

signal on_score_updated(new_score: int)

func _set_score(s: int) -> void:
	score = s
	on_score_updated.emit(s)

func _handle_collision(item: Node, other: Node) -> void:
	if item.is_in_group("badguy") and other.is_in_group("creature"):
		_set_score(score + 1)
		hit_player.play()
		other.queue_free()
 
func handle_collision(item: Node, other: Node) -> void:
	_handle_collision(item, other)
	_handle_collision(other, item)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hit_player.stream = hit_sound
	add_child(hit_player)
	print("We have a score of:", score)

func restart_game() -> void:
	get_tree().reload_current_scene()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_restart"):
		restart_game()
	
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().quit()
