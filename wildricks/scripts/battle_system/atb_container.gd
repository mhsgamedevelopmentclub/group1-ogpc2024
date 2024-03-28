class_name ATBContainer
extends Control

@onready var container: VBoxContainer = $VBoxContainer
@onready var atb_bar: PackedScene = preload('res://scenes/battle_system/atb_bar.tscn')

func init(heros: Array[PlayerActor], enemies: Array[EnemyActor]) -> void:
	for actor in (heros+enemies as Array[Actor]):
		var bar := _gen_bar(actor)
		container.add_child(bar)
		actor.connect('start_change_turn', _toggle_timers)
		actor.connect('finish_change_turn', _toggle_timers)

func _gen_bar(actor: Actor) -> ATBBar:
	var new_bar: ATBBar = atb_bar.instantiate() as ATBBar
	new_bar.init(actor)
	return new_bar

func _toggle_timers() -> void:
	# PLEASE never write code like this
	# this is lazy af
	# TODO: Fix this pls
	var timers: Array[Timer] = []
	timers.assign(get_tree().get_nodes_in_group('battle_timer'))
	for timer in timers:
		timer.paused = !timer.paused
