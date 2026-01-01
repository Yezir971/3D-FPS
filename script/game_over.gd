extends Control

func _on_play_pressed() -> void:
	get_tree().paused = false
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	get_tree().reload_current_scene()
	hide()


func _on_exit_pressed() -> void:
	get_tree().quit()
