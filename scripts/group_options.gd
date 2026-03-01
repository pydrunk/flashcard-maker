extends OptionButton

@onready var groups_container = %"create group"
@onready var flashcard_display = %"flashcard label"
var current_group : String
enum showing {question, answer}
var currently_showing : showing = showing.question
var picked : flashcard
var all_groups = []
func _ready():
	%"question or answer label".text = "showing: question"
	update_groups()
	current_group = get_item_text(selected)
	change_flashcard()

func update_groups():
	for I in range(item_count):
		remove_item(0)
	for group in groups_container.groups:
		add_item(group)
		all_groups.append(group)
	if item_count == 1:
		_on_item_selected(0)
	change_flashcard()

func _on_create_group_added_group() -> void:
	update_groups()


func _on_item_selected(index: int) -> void:
	current_group = get_item_text(index)
	picked = null
	%"flashcard label".text = ""
	change_flashcard()
	
func change_flashcard():
	flashcard_display.text = ""
	if current_group:
		var all_saved_flashcards : Dictionary = %"create flashcard".saved_all_flashcards.groups
		if all_saved_flashcards.has(current_group) and all_saved_flashcards[current_group].size() > 0:
			var groups_flashcards : Array = all_saved_flashcards[current_group]
			var prev_picked = picked
			picked = groups_flashcards.pick_random()
			while picked == prev_picked and all_saved_flashcards[current_group].size() > 1:
				picked = groups_flashcards.pick_random()
			if picked:
				
				flashcard_display.text = picked.question
				currently_showing = showing.question
				%"question or answer label".text = "showing: question"

func _on_swap_pressed() -> void:
	var all_saved_flashcards : Dictionary = %"create flashcard".saved_all_flashcards.groups
	if not picked or not all_saved_flashcards.has(current_group):
		return
	match currently_showing:
		showing.question:
			flashcard_display.text = picked.answer
			currently_showing = showing.answer
			%"question or answer label".text = "showing: answer"
		showing.answer:
			flashcard_display.text = picked.question
			currently_showing = showing.question
			%"question or answer label".text = "showing: question"


func _on_next_pressed() -> void:
	change_flashcard()


func _on_create_flashcard_created_flashcard() -> void:
	change_flashcard()
