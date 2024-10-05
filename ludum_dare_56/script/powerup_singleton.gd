extends Node

var powerup_sound = preload("res://sound/powerup.wav")
var powerdown_sound = preload("res://sound/powerdown.wav")

var powerup_player = AudioStreamPlayer.new()
var powerdown_player = AudioStreamPlayer.new()

signal bad_guy_force_change(change: float)

func _on_bad_guy_force_change(change: float) -> void:
	if change > 0:
		powerdown_player.play()
	else:
		powerup_player.play()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	powerup_player.stream = powerup_sound
	powerdown_player.stream = powerdown_sound
	add_child(powerup_player)
	add_child(powerdown_player)
	
	bad_guy_force_change.connect(_on_bad_guy_force_change)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
