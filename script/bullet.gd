extends Node3D


const SPEED = 40
var damage : int = 0
@onready var mesh_instance_3d: MeshInstance3D = $MeshInstance3D
@onready var ray_cast_3d: RayCast3D = $RayCast3D
@onready var timer: Timer = $Timer
@onready var particles: GPUParticles3D = $GPUParticles3D
@onready var area_3d: Area3D = $Area3D


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	position += transform.basis * Vector3(0, 0, -SPEED) * delta
	if ray_cast_3d.is_colliding():
		mesh_instance_3d.visible = false
		particles.emitting = true
		area_3d.monitorable = false
		area_3d.monitoring = false
		await get_tree().create_timer(0.9).timeout
		queue_free()


func _on_timer_timeout() -> void:
	queue_free()


func _on_area_3d_area_entered(area: Area3D) -> void:
	if area.owner.has_method("take_damage"):
		area.owner.take_damage(damage)
