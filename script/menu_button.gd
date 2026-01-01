
extends TextureButton
@onready var rich_label = $HBoxContainer/Label
@onready var texture_left = $HBoxContainer/TextureRect2
@onready var texture_right = $HBoxContainer/TextureRect


@export_group("Params")
@export var text = "Text Button"
@export var arrow_margin_from_center = 100

	
func _ready() -> void:
	setup_text()


func setup_text():
	rich_label.text = text



func _on_h_box_container_mouse_entered() -> void:
	texture_left.visible = true
	texture_right.visible = true


func _on_h_box_container_mouse_exited() -> void:
	texture_left.visible = false
	texture_right.visible = false
	
