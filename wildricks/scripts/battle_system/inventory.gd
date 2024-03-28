class_name Inventory
extends Control

@onready var container: BoxContainer = (
	$'Background/MarginContainer/VBoxContainer/ColorRect/Skill Slot Container'
	as BoxContainer)
@onready var skill_ui: PackedScene = preload('res://scenes/battle_system/skill_slot_ui.tscn')

func init(player: PlayerActor) -> void:
	var inventory: Array[Skill] = player.inventory
	for skill in inventory:
		var new_skill: SkillSlot = skill_ui.instantiate() as SkillSlot
		new_skill.init(skill)
		container.add_child(new_skill)
