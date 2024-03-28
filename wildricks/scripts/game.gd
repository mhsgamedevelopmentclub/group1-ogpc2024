class_name GameManager
extends Node2D

@onready var battle_scene := preload('res://scenes/battle_system/battle.tscn')
@onready var enemy_scene := preload('res://scenes/enemy_1.tscn')
@onready var pause_menu := $"Pause Menu"

func _process(_delta) -> void:
	if Input.is_action_just_pressed("pause_menu"):
		get_tree().paused = true
		pause_menu.visible = true
	if Input.is_action_just_pressed('spawn_enemy'):
		if get_tree().get_nodes_in_group('enemy').size() == 0:
			var new_enemy := enemy_scene.instantiate()
			new_enemy.position = Vector2(960, 571)
			add_child(new_enemy)

func start_battle() -> void:
	var new_battle := battle_scene.instantiate()
	new_battle.overworld = self
	get_tree().root.add_child(new_battle)
	get_tree().root.remove_child(self)
