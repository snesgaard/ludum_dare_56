extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$VBoxContainer/HBoxContainer/score.text = "%d" % Score.score
	$VBoxContainer/HBoxContainer4/timer.text = "%.3fs" % Score.timer


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_retry_button_pressed() -> void:
	Score.restart_game()


func _on_exit_button_pressed() -> void:
	get_tree().quit()


func _on_main_menu_button_pressed() -> void:
	get_tree().change_scene_to_file("res://main_menu.tscn")
