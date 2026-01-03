extends Node3D

@export var hp_health : int = 10


func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.has_method("health"):
		if not is_inside_tree(): 
			return
		if body.life_player - body.hp_player.value == 0: 
			body.health(0)
			return
		if body.life_player - body.hp_player.value >= hp_health:     
			body.health(hp_health)
			queue_free()
		if body.life_player - body.hp_player.value < hp_health:
			var dif_life = body.life_player - body.life_player
			body.health(dif_life)
			queue_free()
			
