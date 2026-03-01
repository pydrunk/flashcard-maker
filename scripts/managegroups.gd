extends OptionButton

@onready var groups_container = %"create group"
signal deleted_group

func _ready() -> void:
	update_groups()

func update_groups():
	for I in range(item_count):
		remove_item(0)
	for group in groups_container.groups:
		add_item(group)

func _on_create_group_added_group() -> void:
	update_groups()


func _on_button_pressed() -> void:
	if selected != -1:
		var group_to_delete = get_item_text(selected)
		var saved_flashcards = ResourceLoader.load("user://awesome_saves.tres")

		saved_flashcards.groups.erase(group_to_delete)
		ResourceSaver.save(saved_flashcards, "user://awesome_saves.tres")
		deleted_group.emit()
		%"create group".remove_group(group_to_delete)
