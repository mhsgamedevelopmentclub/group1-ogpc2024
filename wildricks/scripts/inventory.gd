class_name Inventory
extends Control

@onready var skill_ui := preload('res://scenes/skill_slot_ui.tscn')

@onready var container := $"Background/MarginContainer/VBoxContainer/ColorRect/Skill Slot Container"

func init(_player: PlayerActor) -> void:
	# TODO: get skill resources from player as strings
	var p_skills := ["attack", "defend", "heal"]
	for skill in p_skills:
		var new_skill := skill_ui.instantiate()
		new_skill.init(skill)
		container.add_child(new_skill)
