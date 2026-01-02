@tool
extends Node3D
@onready var fire_sound: AudioStreamPlayer3D = $fireSound
@onready var reload_sound: AudioStreamPlayer3D = $reloadSound
@onready var empty_amo_sound: AudioStreamPlayer3D = $EmptyAmo
@onready var animation_shoot: AnimationPlayer = $AnimationShoot
@onready var marker_3d: Marker3D = $Marker3D

@onready var amoun_amo_hud: Label = $"HudWeapon/Control/AmounAmo"
@onready var name_wapon_hud: Label = $HudWeapon/Control/NameWapon

@onready var hud_weapon_1: MarginContainer = $"HudWeapon/Control/HBoxContainer/1/MarginContainer/MarginContainer"
@onready var hud_weapon_2: MarginContainer = $"HudWeapon/Control/HBoxContainer/2/MarginContainer/MarginContainer"
@onready var hud_weapon_3: MarginContainer = $"HudWeapon/Control/HBoxContainer/3/MarginContainer/MarginContainer"




var bullet = preload("res://scenes/guns/bullet.tscn")
var instance
var can_shoot = false
var current_amo : int 
var current_mag :int
var current_dammage :int 
var current_coldown : float

@export var DATA_GUN: Gun: 
	set(value):
		DATA_GUN = value

		update_weapon()
func _ready():
	update_weapon()


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("gun_slot_1"):
		DATA_GUN = preload("res://Resources/Guns/sniper.tres")
		update_weapon()
		showHud()
		updateHud()
		can_shoot = true
		
		hud_weapon_2.add_theme_constant_override("margin_left", 10)
		hud_weapon_2.add_theme_constant_override("margin_top", 8)
		hud_weapon_2.add_theme_constant_override("margin_right", 10)
		hud_weapon_2.add_theme_constant_override("margin_bottom", 8)
		
		hud_weapon_3.add_theme_constant_override("margin_left", 10)
		hud_weapon_3.add_theme_constant_override("margin_top", 8)
		hud_weapon_3.add_theme_constant_override("margin_right", 10)
		hud_weapon_3.add_theme_constant_override("margin_bottom", 8)
		
		
		hud_weapon_1.add_theme_constant_override("margin_left", 24)
		hud_weapon_1.add_theme_constant_override("margin_top", 16)
		hud_weapon_1.add_theme_constant_override("margin_right", 24)
		hud_weapon_1.add_theme_constant_override("margin_bottom", 16)
		
	if event.is_action_pressed("gun_slot_2"):
		DATA_GUN = preload("res://Resources/Guns/shot_gun.tres")
		update_weapon()
		showHud()
		updateHud()
		can_shoot = true
		
		hud_weapon_1.add_theme_constant_override("margin_left", 10)
		hud_weapon_1.add_theme_constant_override("margin_top", 8)
		hud_weapon_1.add_theme_constant_override("margin_right", 10)
		hud_weapon_1.add_theme_constant_override("margin_bottom", 8)
		
		hud_weapon_3.add_theme_constant_override("margin_left", 10)
		hud_weapon_3.add_theme_constant_override("margin_top", 8)
		hud_weapon_3.add_theme_constant_override("margin_right", 10)
		hud_weapon_3.add_theme_constant_override("margin_bottom", 8)
		
		hud_weapon_2.add_theme_constant_override("margin_left", 24)
		hud_weapon_2.add_theme_constant_override("margin_top", 16)
		hud_weapon_2.add_theme_constant_override("margin_right", 24)
		hud_weapon_2.add_theme_constant_override("margin_bottom", 16)
		
	if event.is_action_pressed("gun_slot_3"):
		DATA_GUN =  preload("res://Resources/Guns/pm.tres")
		update_weapon()
		showHud()
		updateHud()
		can_shoot = true
		
		hud_weapon_1.add_theme_constant_override("margin_left", 10)
		hud_weapon_1.add_theme_constant_override("margin_top", 8)
		hud_weapon_1.add_theme_constant_override("margin_right", 10)
		hud_weapon_1.add_theme_constant_override("margin_bottom", 8)
		
		hud_weapon_2.add_theme_constant_override("margin_left", 10)
		hud_weapon_2.add_theme_constant_override("margin_top", 8)
		hud_weapon_2.add_theme_constant_override("margin_right", 10)
		hud_weapon_2.add_theme_constant_override("margin_bottom", 8)
		
		hud_weapon_3.add_theme_constant_override("margin_left", 24)
		hud_weapon_3.add_theme_constant_override("margin_top", 16)
		hud_weapon_3.add_theme_constant_override("margin_right", 24)
		hud_weapon_3.add_theme_constant_override("margin_bottom", 16)

	if event.is_action_pressed("shoot") and can_shoot:
		if not animation_shoot.is_playing() and current_amo > 0:
			fire_sound.play()
			animation_shoot.play("shoot")
			
			instance =  bullet.instantiate()
			instance.damage = DATA_GUN.damage
			instance.global_transform = marker_3d.global_transform
			get_tree().root.add_child(instance)
			if not DATA_GUN.max_mag_infinit :
				current_amo -= 1
				updateHud()
		if not animation_shoot.is_playing() and current_amo == 0:
			empty_amo_sound.play()
			
			
	
	if event.is_action_pressed("reload") and can_shoot:
		if current_mag > 0:
			reload_sound.play()
			current_amo = DATA_GUN.bullet_amount
			current_mag -=1
			updateHud()
func update_weapon():
	if DATA_GUN != null and has_node("WeaponMesh"):
		
		current_amo = DATA_GUN.bullet_amount
		current_mag = DATA_GUN.max_mag
		current_dammage = DATA_GUN.damage
		current_coldown = DATA_GUN.cooldown
		
		$WeaponMesh.mesh = DATA_GUN.mesh
		fire_sound.stream = DATA_GUN.firing_sound.pick_random()
		reload_sound.stream = DATA_GUN.reload_sound
		empty_amo_sound.stream = DATA_GUN.dry_audio_sound
		
func updateHud():
	amoun_amo_hud.text = str(current_amo) + " / " + str(current_mag)
	name_wapon_hud.text = str(DATA_GUN.ammo)
func showHud():
	amoun_amo_hud.visible = true
	name_wapon_hud.visible = true
