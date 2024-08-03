@tool
extends Control
class_name ModItem

@export_group("Mod Item")
@export var mod_title: String = "Mod Title"
@export var mod_icon: Texture2D
@export var mod_author: String = "Mod Author"
@export_multiline var mod_description: String = "Mod Description"

@onready var title: Label = $Panel/Title
@onready var icon: TextureRect = $Panel/Icon
@onready var author: Label = $Panel/Author
@onready var description: Label = $Panel/Description


func _process(delta: float) -> void:
	set_text()

func set_text():
	title.text = mod_title
	icon.texture = mod_icon
	author.text = mod_author
	description.text = mod_description
