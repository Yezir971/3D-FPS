extends CharacterBody3D



var state_machine
var is_dead = false
@onready var animation_tree: AnimationTree = $skeleton_mage/AnimationTree
@onready var collision_shape_3d: CollisionShape3D = $CollisionShape3D
var lootSpawn = [ "", "Health", "Amo" ]

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
	if not is_inside_tree():
		return
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
			
			animation_tree.set("parameters/conditions/Attack", target_in_range())
			velocity.x = 0
			velocity.z = 0
			animation_tree.set("parameters/conditions/Run", !target_in_range())
		"Death":
			if is_dead:
				collision_shape_3d.disabled = true
				await get_tree().create_timer(2).timeout
				#insrance de l'objet de loot 
				var spawn_above = global_position + Vector3(0, 0.2, 0)
				match lootSpawn.pick_random():
					"":
						#const SKELETONS_CHARACTER_BODY_3D = preload("res://scenes/ennemies/skeletons/skeletons_character_body_3d.tscn")
						#var instance_loot = SKELETONS_CHARACTER_BODY_3D.instantiate()
						#instance_loot.global_position = global_position
						#get_parent().add_child(instance_loot)
						pass
					"Health":
						spawn_item("res://scenes/loot/loot_life.tscn", spawn_above)
					"Amo":
						spawn_item("res://scenes/loot/loot_life.tscn", spawn_above)
				queue_free()
				
		"Hit":
			animation_tree.set('parameters/conditions/Hit', progress_bar.value <= 0)
			velocity = Vector3.ZERO
			animation_tree.set('parameters/conditions/Hit', false)
	move_and_slide()
	
func spawn_item(path: String, pos: Vector3):
	var scene = load(path)
	if scene:
		var instance = scene.instantiate()
		instance.global_position = pos
		# Utiliser call_deferred est plus sûr pour éviter les erreurs d'arborescence
		get_parent().call_deferred("add_child", instance)
		
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
