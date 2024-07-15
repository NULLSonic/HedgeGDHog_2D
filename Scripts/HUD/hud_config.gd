extends Node2D

func _ready():
	# debuging
	if !Global.is_main_loaded:
		return false
