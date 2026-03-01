extends Button

@onready var question_line = %LineEdit
@onready var answer_line = %LineEdit2
@onready var group_option = %OptionButton
var saved_all_flashcards
signal created_flashcard

func _ready() -> void:
	saved_all_flashcards = ResourceLoader.load("user://awesome_saves.tres")

func _on_pressed() -> void:
	if question_line.text != "" and answer_line.text != "" and group_option.selected != -1:
		var new_flashcard = flashcard.new()
		new_flashcard.question = question_line.text
		new_flashcard.answer = answer_line.text
		new_flashcard.group = group_option.get_item_text(group_option.selected)
		if saved_all_flashcards.groups.has(new_flashcard.group):
			saved_all_flashcards.groups[new_flashcard.group].append(new_flashcard)
		else:
			saved_all_flashcards.groups[new_flashcard.group] = [new_flashcard]
		ResourceSaver.save(saved_all_flashcards, "user://awesome_saves.tres")
		question_line.text = ""
		answer_line.text = ""
		created_flashcard.emit()




func _on_delete_pressed() -> void:
	saved_all_flashcards.groups[%"group options".get_item_text(%"group options".selected)].erase(%"group options".picked)
	ResourceSaver.save(saved_all_flashcards, "user://awesome_saves.tres")
	%"group options".change_flashcard()
