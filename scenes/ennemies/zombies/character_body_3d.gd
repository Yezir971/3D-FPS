extends CharacterBody3D


const SPEED = 1
var gravity = 9.8
@onready var navigation_agent_3d: NavigationAgent3D = $NavigationAgent3D
@onready var animation_player: AnimationPlayer = $zombie/AnimationPlayer
@onready var zombie: Node3D = $".."

var is_detected = true



func _physics_process(delta: float) -> void:
	if zombie.is_dead:
		velocity.x = 0
		velocity.z = 0
		move_and_slide()
		return 
	if not is_on_floor(): 	
		velocity.y -= gravity * delta
	else:
		velocity.y = -0.1 # Petite pression vers le bas pour rester collé au sol
	
		# On récupère le chemin
	var next_location = navigation_agent_3d.get_next_path_position()
	var direction = (next_location - global_position).normalized()
	#forcer l'enemi a regarder dans la direction du joueur 
	if not navigation_agent_3d.is_navigation_finished() and global_position.distance_to(next_location) > 0.1 and is_detected:
		look_at(next_location, Vector3(0,1,0),true )
	
		# On ne bouge horizontalement que si on n'est pas déjà arrivé
		#if not navigation_agent_3d.is_navigation_finished():
		animation_player.play("zombie_run/Run")
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
		
		
	else:
		velocity.x = 0
		velocity.z = 0
		animation_player.play("zombie_idle/Idle")
		
	move_and_slide()



func target_position(target):
	navigation_agent_3d.target_position = target
