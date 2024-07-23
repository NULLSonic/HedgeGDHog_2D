extends Node

var file = ConfigFile.new()

func _ready():
	if not FileAccess.file_exists("user://SaveData.cfg"):
		file.set_value("Unlocked", "Spin Dash", true)
		file.set_value("Abilities Enabled", "Spin Dash", true)

		file.set_value("Unlocked", "Peelout", true)
		file.set_value("Abilities Enabled", "Peelout", true)

		file.set_value("Unlocked", "Peelout Rework", false)
		file.set_value("Abilities Enabled", "Peelout Rework", false)

		file.set_value("Unlocked", "Drop Dash", true)
		file.set_value("Abilities Enabled", "Drop Dash", true)

		file.set_value("Unlocked", "Drop Dash Rework", false)
		file.set_value("Abilities Enabled", "Drop Dash Rework", false)

		file.set_value("Unlocked", "Insta Shield", true)
		file.set_value("Abilities Enabled", "Insta Shield", true)

		file.set_value("Unlocked", "Insta Dash", false)
		file.set_value("Abilities Enabled", "Insta Dash", false)

		file.set_value("Unlocked", "Air Curl", true)
		file.set_value("Abilities Enabled", "Air Curl", true)

		file.set_value("Unlocked", "Uncurl", true)
		file.set_value("Abilities Enabled", "Uncurl", true)

		file.set_value("Unlocked", "Cancel Super", true)
		file.set_value("Abilities Enabled", "Cancel Super", true)

		file.set_value("Unlocked", "Homing Attack", false)
		file.set_value("Abilities Enabled", "Homing Attack", false)

		file.set_value("Unlocked", "Stomp", false)
		file.set_value("Abilities Enabled", "Stomp", false)

		file.set_value("Unlocked", "Light Speed Dash", false)
		file.set_value("Abilities Enabled", "Light Speed Dash", false)

		file.set_value("Unlocked", "Flight Cancel", true)
		file.set_value("Abilities Enabled", "Flight Cancel", true)

		file.set_value("Unlocked", "Flight Burst", false)
		file.set_value("Abilities Enabled", "Flight Burst", false)

		file.set_value("Unlocked", "Drill Fists", false)
		file.set_value("Abilities Enabled", "Drill Fists", false)

		file.save("user://SaveData.cfg")

func save_data(section: String, key: String, value, path: String = "user://SaveData.cfg"): # Use SaveData.save_data() to easily save stuff.
	file.set_value(section, key, value)
	file.save(path)

func load_data(section: String, key: String, path: String = "user://SaveData.cfg"): # Use SaveData.load_data() to easily load save data.
	var err = file.load(path)
	if err != OK:
		return null
	if file.has_section_key(section, key):
		return file.get_value(section, key)
	else:
		return null

func is_true(key: String, path: String = "user://SaveData.cfg"): # Used to check if both keys are true or false
	var unlocked: bool
	var enabled: bool
	var final_value: bool

	unlocked = load_data("Unlocked", key, path)
	enabled = load_data("Abilities Enabled", key, path)

	final_value = bool(int(unlocked) * int(enabled))
	return final_value
