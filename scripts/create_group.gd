extends VBoxContainer

var groups : Array[String] = []
signal added_group

func _ready() -> void:
	var all_saved_flashcards = ResourceLoader.load("user://awesome_saves.tres")
	for group in all_saved_flashcards.groups:
		groups.append(group)

func _on_button_pressed() -> void:
	var new_group = $TextEdit.text
	if not new_group in groups:
		groups.append(new_group)
		added_group.emit()
	$TextEdit.text = ""


func remove_group(group):
	groups.erase(group)
	added_group.emit()
