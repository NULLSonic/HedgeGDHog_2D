extends Node2D

@export var music = preload("res://Audio/Soundtrack/10. SWD_CharacterSelect.ogg")
var selection: int = 0
var pressed = false
var curCat = 0
@onready var maxSel: int = $BG/options/options.get_child_count()

func _ready():
	if !Global.is_main_loaded:
		return false
	if !Global.music.is_playing():
		Global.music.stream = music
		Global.music.play()

	for i in maxSel:
		$BG/options/options.get_child(i).modulate = Color(1, 1, 1)
	$BG/options/options.get_child(selection).modulate = Color(1, 1, 0)

func _process(delta: float) -> void:
	$BG/options/ControllerMenu.visible = true
	$BG/options/ControllerMenu/Title.visible = false

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("gm_down") and !pressed:
		change_sel(1)
	if Input.is_action_just_pressed("gm_up") and !pressed:
		change_sel(-1)
	if Input.is_action_just_pressed("gm_pause") and !pressed:
		$confirm.play()
		pressed = true
		match (selection):
			3:
				$BG/swap.play('main2ctrl')
				curCat = selection
	if Input.is_action_just_pressed("gm_action2"):
		$goBack.play()
		if !pressed:
			pressed = true
			Global.main.change_scene_to_file(load("res://Scene/Presentation/CharacterSelect.tscn"),"FadeOut","FadeOut",1)
		else:
			pressed = false
			curCat = 0
			$BG/swap.play_backwards('main2ctrl')

func change_sel(amount: int):
	$swap.play()
	selection = wrapi(selection + amount, 0, maxSel)
	for i in maxSel:
		$BG/options/options.get_child(i).modulate = Color(1, 1, 1)
	$BG/options/options.get_child(selection).modulate = Color(1, 1, 0)

func _on_confirm_pressed() -> void:
	$goBack.play()
	pressed = false
	curCat = 0
	$BG/swap.play_backwards('main2ctrl')
