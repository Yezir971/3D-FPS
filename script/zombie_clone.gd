extends Node3D
@onready var progress_bar: ProgressBar = $CharacterBody3DZombie/zombie/SubViewport/ProgressBar
@onready var area_3d: Area3D = $CharacterBody3DZombie/zombie/Area3D
@onready var animation_player: AnimationPlayer = $CharacterBody3DZombie/zombie/AnimationPlayer

@export var hp : int = 100
var is_dead = false 

func _ready() -> void:
	progress_bar.value = hp


func _on_area_3d_area_entered(area: Area3D) -> void:
	if is_dead : return
	if area.is_in_group("bullet_player"):
		animation_player.play("zombie_jump/jump")
		if progress_bar.value <= 0:
			death()
			
func death():
	animation_player.play("zombie_idle/Idle")
	is_dead = true
	await get_tree().create_timer(5).timeout
	queue_free()
	
func take_damage(damage : int):
	progress_bar.value -= damage
	
