extends Control

var time = 0.0

@onready var label = $Label
@onready var timer_label = $Timer

func _update_score_label(score: int) -> void:
	label.text = "Score: %d" % (score)

func _update_time_label(t: float) -> void:
	timer_label.text = "Time: %f" % (t)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_update_score_label(0)
	Score.on_score_updated.connect(_update_score_label)



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	time += delta
	_update_time_label(time)
	
