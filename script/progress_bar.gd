extends ProgressBar

var fil_stylebox: StyleBoxFlat
const HEALTH_BAR = preload("res://Resources/health_bar/health_bar.tres")

func _ready() -> void:
	# 1. On récupère le stylebox d'origine
	var original_stylebox = get_theme_stylebox("fill")
	
	# 2. On en crée une COPIE unique pour CET ennemi précise
	fil_stylebox = original_stylebox.duplicate()
	
	# 3. On force la ProgressBar à utiliser cette copie unique
	add_theme_stylebox_override("fill", fil_stylebox)

func _on_value_changed(new_value: float) -> void:
	# Maintenant, cela ne modifiera que la copie propre à cet ennemi
	fil_stylebox.bg_color = HEALTH_BAR.gradient.sample(new_value / max_value)
