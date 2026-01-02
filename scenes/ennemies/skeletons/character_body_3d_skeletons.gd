extends CharacterBody3D


const SPEED = 1
const ATTAK_RANGE = 2
var gravity = 9.8
@onready var navigation_agent_3d: NavigationAgent3D = $skeleton_mage/NavigationAgent3D
@onready var animation_player: AnimationPlayer = $skeleton_mage/AnimationPlayer
@onready var skeletons: Node3D = $".."
@onready var ray_cast_3d: RayCast3D = $RayCast3D

var is_detected = false
var player = null
var is_attacking = false 
var can_attack = true
@export var player_path : NodePath

func _ready() -> void:
	player = get_node(player_path)

func _physics_process(delta: float) -> void:
	if skeletons.is_dead or is_attacking:
		velocity.x = 0
		velocity.z = 0
		move_and_slide()
		return
	#les ennemy se mettent a bouger que si le joueur passe devant eux 
	if ray_cast_3d.is_colliding():
		var obj = ray_cast_3d.get_collider()
		if obj.is_in_group("player"):
			is_detected = true



	if not is_on_floor(): 	
		velocity.y -= gravity * delta
	else:
		velocity.y = -0.1 # Petite pression vers le bas pour rester collé au sol
	
	if target_in_range() and is_detected:
			# On lance l'attaque une seule fois
		start_attack()
	elif not navigation_agent_3d.is_navigation_finished() and is_detected:
		
		var next_location = navigation_agent_3d.get_next_path_position()
		var direction = (next_location - global_position).normalized()
		look_at(next_location, Vector3.UP, true)
		
		animation_player.play("Running_A")
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = 0
		velocity.z = 0
		animation_player.play("Idle")
		
	move_and_slide()

func start_attack():
	is_attacking = true
	can_attack = false 
	animation_player.play("1H_Melee_Attack_Stab")
	await get_tree().create_timer(0.4).timeout
	player.hit(5)

# Connecte ce signal depuis l'onglet "Nœud" de ton AnimationPlayer
func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "1H_Melee_Attack_Stab":
		is_attacking = false
		can_attack = true
func target_position(target):
	navigation_agent_3d.target_position = target

func target_in_range():
	return global_position.distance_to(player.global_position) < ATTAK_RANGE
