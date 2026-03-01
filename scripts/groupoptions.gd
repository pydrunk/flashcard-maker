extends OptionButton

@onready var group_container = %"create group"


func _ready() -> void:
	update_groups()

func _on_create_group_added_group() -> void:
	update_groups()

func update_groups():
	for i in range(item_count):
		remove_item(0)
	var groups = group_container.groups
	for group in groups:
		add_item(group)
