extends Control

func _ready() -> void:
	if not ResourceLoader.exists("user://awesome_saves.tres"):
		var new_all_flashcards = all_flashcards.new()
		ResourceSaver.save(new_all_flashcards, "user://awesome_saves.tres")
