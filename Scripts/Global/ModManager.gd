extends Node

var dir = DirAccess.open("user://")
var file_path = "user://mods/readme.txt"

func _ready() -> void:
	dir.make_dir_recursive("mods")

	if !FileAccess.file_exists(file_path):
		var f = FileAccess.open(file_path, FileAccess.WRITE)
		f.store_string("You can create mods and put them in here.\nGo check out https://github.com/NULLSonic/HedgeGDHog_2D/wiki to learn on how to make mods.")

	ProjectSettings.load_resource_pack("user://mods/mod.pck")
