extends Node

func _ready() -> void:
	DiscordRPC.app_id = 1262102606197690493

	DiscordRPC.refresh()

func set_text(detail: String, state: String):
	DiscordRPC.details = detail
	DiscordRPC.state = state

	DiscordRPC.refresh()

func set_large_img(img: String, text: String):
	DiscordRPC.large_image = img
	DiscordRPC.large_image_text = text

	DiscordRPC.refresh()

func set_small_img(img: String, text: String):
	DiscordRPC.small_image = img
	DiscordRPC.small_image_text = text

	DiscordRPC.refresh()
