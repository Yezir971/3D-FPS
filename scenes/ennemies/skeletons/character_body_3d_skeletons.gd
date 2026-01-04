extends CharacterBody3D



var state_machine
var is_dead = false
@onready var animation_tree: AnimationTree = $skeleton_mage/AnimationTree
@onready var collision_shape_3d: CollisionShape3D = $CollisionShape3D
var lootSpawn = [ "", "Health", "Amo" ]
var attack_in_progress = false
var gravity = 9.8
@onready var navigation_agent_3d: NavigationAgent3D = $skeleton_mage/NavigationAgent3D
@onready var animation_player: AnimationPlayer = $skeleton_mage/AnimationPlayer
@onready var skeletons: Node3D = $".."
@onready var ray_cast_3d: RayCast3D = $RayCast3D
@onready var progress_bar: ProgressBar = $skeleton_mage/SubViewport/ProgressBar

var is_detected = false
var player = null
var is_attacking = false 
var can_attack = true
@export var player_path : NodePath
@export var speed = 1
@export var attack_range = 3
@export var pv : int = 100
@export var damage_hit : int = 5
func _ready() -> void:
	player = get_node(player_path)
	state_machine = animation_tree.get("parameters/playback")
	progress_bar.max_value = pv
	progress_bar.value = pv
	


func _physics_process(delta: float) -> void:
	if progress_bar.value <= 0 :
		animation_tree.set('parameters/conditions/Death', true)
		is_dead = true
	if not is_on_floor(): 
		velocity.y -= gravity * delta
	else:
		velocity.y = -0.1 
	match state_machine.get_current_node():
		"Idle":
			
			velocity.x = 0
			velocity.z = 0
			if ray_cast_3d.is_colliding():
				var obj = ray_cast_3d.get_collider()
				if obj.is_in_group("player"):
					is_detected = true
			if is_detected:
				animation_tree.set("parameters/conditions/Run", true)
		"Run":
			if target_in_range():
				animation_tree.set("parameters/conditions/Attack", target_in_range())
			else:
				navigation_agent_3d.target_position = player.global_position
				var next_location = navigation_agent_3d.get_next_path_position()
				var direction = (next_location - global_position).normalized()
				look_at(next_location, Vector3.UP, true)
				velocity.x = direction.x * speed
				velocity.z = direction.z * speed
		"Attack":
			if not attack_in_progress:
				animation_tree.set("parameters/conditions/Attack", target_in_range())
				animation_tree.set("parameters/conditions/Run", !target_in_range())
			velocity = Vector3.ZERO
		"Death":
			velocity = Vector3.ZERO
		"Hit":
			animation_tree.set('parameters/conditions/Hit', progress_bar.value <= 0)
			velocity = Vector3.ZERO
			animation_tree.set('parameters/conditions/Hit', false)
	move_and_slide()


	
func spawn_item():
	if not is_inside_tree():
		return


	var current_pos = global_position 

	var path_name_loot: String = ""
	match lootSpawn.pick_random():
		"": return
		"Health":
			path_name_loot = "res://scenes/loot/loot_life.tscn"
		"Amo":
			path_name_loot = "res://scenes/loot/loot_amo.tscn"
			
	var scene = load(path_name_loot)
	if scene:
		var instance = scene.instantiate()
		
		var parent = get_parent()
		if parent and parent.is_inside_tree():

			
			parent.call_deferred("add_child", instance)
			#instance.global_position = current_pos + Vector3(0, 0.2, 0)
			instance.transform.origin = current_pos + Vector3(0, 0.2, 0)
			#instance.set_deferred("global_position", current_pos + Vector3(0, 0.2, 0))
func death_body():
	collision_shape_3d.disabled = true
	queue_free()

func take_damage(damage : int):
	if is_dead : return
	progress_bar.value -= damage
	is_detected = true
	animation_tree.set('parameters/conditions/Hit', true)
	

func hit_player():
	if target_in_range():
		player.hit(damage_hit)

func target_position(target):
	navigation_agent_3d.target_position = target

func target_in_range():
	return global_position.distance_to(player.global_position) < attack_range
