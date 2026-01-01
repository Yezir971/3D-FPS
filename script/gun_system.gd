extends Node


@export var parent : CharacterBody3D
@onready var cooldown_timer: Timer = $CooldownTimer
@onready var audio_stream_bullet_3d: AudioStreamPlayer3D = $AudioStreamBullet3D

var current_gun : Gun 


	

func shoot():
	current_gun = parent.current_gun
	if parent.can_shoot and parent.current_bullets > 0:
		var valid_bullets : Array[Dictionary] = get_bullet_raycast()
		#if current_gun.type != Gun.GunType.MELEE:
		parent.current_bullets -= 1
		
		#cooldown
		parent.can_shoot = false 
		cooldown_timer.start(current_gun.cooldown)
		
		# sound effect 
		#SoundManager.play_sfx(current_gun.firing_sound.pick_random(), parent)
		if !audio_stream_bullet_3d.is_playing():
			audio_stream_bullet_3d.stream = current_gun.firing_sound.pick_random()
			audio_stream_bullet_3d.play()
		if !valid_bullets.is_empty():
			for b in valid_bullets :
				if b.hit_target.is_in_groupe('Enemy'):
					b.hit_target.change_health(current_gun.damage * -1)
			

func get_bullet_raycast():
	current_gun = parent.current_gun
	var bullet_raycast = parent.bullet_raycast
	var valid_bullets : Array[Dictionary]
	for b in current_gun.bullet_amount:
		var spread_x : float = randf_range(current_gun.spread * -1, current_gun.spread)
		var spread_y : float = randf_range(current_gun.spread * -1, current_gun.spread)
		
		bullet_raycast.target_position = Vector3(spread_x, spread_y, -current_gun.bullet_range)
		
		bullet_raycast.force_raycast_update()
		var hit_target = bullet_raycast.get_collider()
		var collision_point = bullet_raycast.get_collision_point()
		var collision_normal = bullet_raycast.get_collision_normal()
		
		if hit_target != null:
			var valid_bullet : Dictionary = {
				"hit_target": hit_target,
				"collision_point" : collision_point,
				"collision_normal" : collision_normal,
			}
			valid_bullets.append(valid_bullet)
	return valid_bullets
