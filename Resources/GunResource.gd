extends Resource

class_name Gun

enum GunType {
	REVOLVER,
	GUN,
	SNIPER,
	SHOTGUN,
	AMG,
	UZI,
	GRENADE,
	SMOKE,
}
@export var Type: GunType
@export var ammo : String
@export var mesh : ArrayMesh
@export var cooldown : float = 0.2 #time in seconds 
@export var swaay : float = 0.15
@export var automatic : bool = false 

@export_category("Sounds")
@export var firing_sound : Array[AudioStream]
@export var reload_sound : AudioStream
@export var dry_audio_sound : AudioStream = preload("res://Resources/sound_guns/metalLatch.ogg")

@export_category("Bullet Stat")
@export var damage : int
@export var spread : float
@export var max_mag : int
@export var max_mag_infinit : bool = false
@export var bullet_amount : int = 1 #amount of bullet project 
@export var bullet_range : int = 40

 
