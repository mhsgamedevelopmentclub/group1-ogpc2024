extends VBoxContainer

signal slot_changed(skill_slot_ui)
@onready var skill_slot_ui: PackedScene = preload('res://scenes/battle_system/skill_slot_ui.tscn')

func _ready():
	var containers := get_tree().get_nodes_in_group("drag_container")
	for container in containers:
		container.connect('slot_changed', on_data_dropped)

func _can_drop_data(_at_position: Vector2, data: Variant) -> bool:
	return data is Node and data.is_in_group('draggable')

func _drop_data(_at_position: Vector2, data):
	emit_signal('slot_changed', data)
	var ui_copy: SkillSlot = skill_slot_ui.instantiate() as SkillSlot
	ui_copy.init(data.skill_ref)
	add_child(ui_copy)

func on_data_dropped(dropped_item):
	if dropped_item in get_children():
		remove_child(dropped_item)
		dropped_item.queue_free()
