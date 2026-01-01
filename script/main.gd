extends Node3D
@onready var player: CharacterBody3D = $ProtoController




# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	get_tree().call_group("enemies", "target_position", player.global_transform.origin)
