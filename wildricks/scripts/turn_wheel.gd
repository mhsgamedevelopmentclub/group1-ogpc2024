class_name TurnWheel
extends Control

signal update_turn_ord(turn_list: Array[String])

@onready var button := $"Background/MarginContainer/VBoxContainer/Button"
@onready var skill_container := $"Background/MarginContainer/VBoxContainer/ColorRect/Skill Slot Container"

func init(player: PlayerActor) -> void:
	player.connect('open_change_turn', _on_open_change_turn)
	connect('update_turn_ord', player.reorder_turn)
	player.turn_ord_updater = update_turn_ord

func _ready() -> void:
	button.disabled = true

func _on_open_change_turn() -> void:
	button.disabled = false
	await button.pressed
	var turn_list: Array[String] = []
	for skill in skill_container.get_children(): 
		turn_list.append(skill.name) 
	emit_signal("update_turn_ord", turn_list)
	button.disabled = true
