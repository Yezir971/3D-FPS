extends Control


func _on_play_pressed() -> void:
	get_tree().change_scene_to_file("res://main.tscn")
	hide()
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)


func _on_exit_pressed() -> void:
	get_tree().quit()
