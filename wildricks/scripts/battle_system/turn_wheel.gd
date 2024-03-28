class_name TurnWheel
extends Control

signal update_turn_ord(turn_list: Array[Skill])

@onready var button: Button = (
	$'Background/MarginContainer/VBoxContainer/Button' as Button)
@onready var skill_container: BoxContainer = ( 
	$'Background/MarginContainer/VBoxContainer/ColorRect/Skill Slot Container'
	as BoxContainer)

func init(player: PlayerActor) -> void:
	player.connect('start_change_turn', _on_open_change_turn)
	connect('update_turn_ord', player.reorder_turn)
	player.turn_ord_updater = update_turn_ord

func _ready() -> void:
	button.disabled = true

func _on_open_change_turn() -> void:
	button.disabled = false
	await button.pressed
	var turn_list: Array[Skill] = []
	for skill in (skill_container.get_children() as Array[SkillSlot]): 
		turn_list.append(skill.skill_ref) 
	emit_signal("update_turn_ord", turn_list)
	button.disabled = true
