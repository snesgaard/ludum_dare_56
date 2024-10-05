extends Control

var time = 0.0

@onready var label = $Label
@onready var timer_label = $Timer
@onready var game_end_label = $game_end_label

func _update_score_label(score: int) -> void:
	label.text = "Score: %d" % (score)

func _update_time_label(t: float) -> void:
	timer_label.text = "Time: %f" % (t)
	
func _is_game_done() -> bool:
	for c in get_tree().get_nodes_in_group("creature"):
		return false
	
	return true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_update_score_label(0)
	Score.on_score_updated.connect(_update_score_label)



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	time += delta
	_update_time_label(time)
	
	if _is_game_done() and not game_end_label.visible:
		game_end_label.text = "You survived: %f" % (time)
		game_end_label.visible = true
	
