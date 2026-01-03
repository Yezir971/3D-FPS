extends Node3D

#@export var amo_reload : int = 10
var is_empty_bullet = true
var is_empty_mag = true
func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.has_method("boxe_reload") and is_instance_valid(body.weapon.DATA_GUN):
		if body.weapon.current_amo == body.weapon.DATA_GUN.bullet_amount :
			is_empty_bullet = false
		if body.weapon.current_mag == body.weapon.DATA_GUN.max_mag:
			is_empty_mag= false 
		if not is_empty_bullet and not is_empty_mag : 
			return
		if not is_inside_tree(): 
			return
		body.boxe_reload()
		queue_free()
	else : 
		return
