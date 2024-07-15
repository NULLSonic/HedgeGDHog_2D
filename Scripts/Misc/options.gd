extends Node2D

@export var music = preload("res://Audio/Soundtrack/10. SWD_CharacterSelect.ogg")
var selection: int = 0
var pressed = false
@onready var maxSel: int = $BG/options.get_child_count()

func _ready():
	if !Global.is_main_loaded:
		return false
	if !Global.music.is_playing():
		Global.music.stream = music
		Global.music.play()

func _process(delta: float) -> void:
	for i in maxSel:
		$BG/options.get_child(i).modulate = Color(1, 1, 1)
	$BG/options.get_child(selection).modulate = Color(1, 1, 0)

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("gm_down"):
		change_sel(1)
	if Input.is_action_just_pressed("gm_up"):
		change_sel(-1)
	if Input.is_action_just_pressed("gm_pause"):
		$confirm.play()
	if Input.is_action_just_pressed("gm_action2") and !pressed:
		$goBack.play()
		pressed = true
		Global.main.change_scene_to_file(load("res://Scene/Presentation/CharacterSelect.tscn"),"FadeOut","FadeOut",1)

func change_sel(amount: int):
	$swap.play()
	selection = wrapi(selection + amount, 0, maxSel)
