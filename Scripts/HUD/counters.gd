@tool
@icon("res://icon.png")
class_name HUDCounters
extends Control

var focusPlayer = 0

# counter elements pointers
@onready var scoreText = $Score/ScoreNumber
@onready var timeText = $Time/TimeNumbers
@onready var ringText = $Rings/RingCount
@onready var lifeText = $LifeCounter/LifeText

# used for flashing ui elements (rings, time)
var flashTimer = 0

@export_group("Counters Config")
@export_subgroup("Score Counter")
@export var score_pos: Vector2 = Vector2(0, 0)
@export var score_num_pos: Vector2 = Vector2(56, 0)
@export var score_num_align: String = "%6d"
@export_subgroup("Time Counter")
@export var time_pos: Vector2 = Vector2(0, 16)
@export var time_num_pos: Vector2 = Vector2(56, 0)
@export var time_num_align: String = "%2d"
@export_subgroup("Ring Counter")
@export var ring_pos: Vector2 = Vector2(0, 32)
@export var ring_num_pos: Vector2 = Vector2(56, 0)
@export var ring_num_align: String = "%6d"
@export_subgroup("Life Counter")
@export var life_pos: Vector2 = Vector2(8, 216)
@export var life_num_pos: Vector2 = Vector2(8, 0)
@export var life_num_align: String = "%2d"

func _ready() -> void:
	if !Engine.is_editor_hint():
		# Set character Icon
		$LifeCounter.frame = Global.PlayerChar1-1

func _process(delta: float) -> void:
	# set score string to match global score with leading 0s
	set_pos()
	if !Engine.is_editor_hint():
		scoreText.text = score_num_align % Global.score

		# clamp time so that it won't go to 10 minutes
		var timeClamp = min(Global.levelTime,Global.maxTime-1)

		# set time text, format it to have a leadin 0 so that it's always 2 digits
		#timeText.text = time_num_align % floor(timeClamp/60) + ":" + str(fmod(floor(timeClamp),60)).pad_zeros(2)
		# uncomment below (and remove above line) for mili seconds
		timeText.text = time_num_align % floor(timeClamp/60) + ":" + str(fmod(floor(timeClamp),60)).pad_zeros(2) + ":" + str(fmod(floor(timeClamp*100),100)).pad_zeros(2)

		# check that there's player, if there is then track the focus players ring count
		if (Global.players.size() > 0):
			ringText.text = ring_num_align % Global.players[focusPlayer].rings

		# HUD flashing text
		if flashTimer < 0:
			flashTimer = 0.1
			if Global.players.size() > 0:
				# if ring count at zero, flash rings
				if Global.players[focusPlayer].rings <= 0:
					$Rings/Red.visible = !$Rings/Red.visible
				else:
					$Rings/Red.visible = false
			# if minutes up to 9 then flash time
			if Global.levelTime >= 60*9:
				$Time/Red.visible = !$Time/Red.visible
			else:
				$Time/Red.visible = false
		elif !get_tree().paused:
			flashTimer -= delta

		# track lives with leading 0s
		lifeText.text = life_num_align % Global.lives

func set_pos():
	$Score.position = score_pos
	scoreText.position = score_num_pos

	$Time.position = time_pos
	timeText.position = time_num_pos

	$Rings.position = ring_pos
	ringText.position = ring_num_pos

	$LifeCounter.position = life_pos
	lifeText.position = life_num_pos
