'''
Class for representing "Actors" in a battle scene
extends class:`Node2D`

This class is responsible for handling the actors turn
during a turn queue, as well as all of the actors stats
during battle and necessary signals to communicate with
the turn queue and HUD
'''
class_name Actor
extends Node2D

signal do_damage(damage: int)
signal update_health_ui(value: int)
signal update_atb_timer_ui(value: int)
signal start_change_turn
signal finish_change_turn
signal death

@onready var sprite: CompressedTexture2D = preload('res://assets/OGPC MC Front Facing Pixel.png')

@export var max_health: int = 100
@export var inventory: Array[Skill]

var turn_cycle: Array[Skill]
var cur_health: int = max_health
var cur_idx: int = 0
var barrier: int = 0
var changing_time: bool = false

func play_turn() -> void:
	'''
	Plays out the actor's full turn in the battle system
	'''
	if changing_time or turn_cycle.size() == 0:
		print("shuffling...")
		# TODO: make code better so we don't need this
		@warning_ignore("redundant_await")
		await _change_moves()
		changing_time = false
		cur_idx = 0
	print("current health: ", cur_health)
	print("current action: ", turn_cycle[cur_idx])
	barrier = 0
	await _use_skill(turn_cycle[cur_idx])
	cur_idx = (cur_idx + 1) % turn_cycle.size()
	print("Turn complete")

func _use_skill(skill: Skill) -> void:
	'''
	Executes necessary attack, defend, and heal functions
	based on the values of the passed in skill
	
	:param skill: the skill to execute
	:type skill: class:`Skill`
	'''
	print(name+' used '+skill.name)
	if skill.damage > 0:
		_attack(skill.damage)
	if skill.shield > 0:
		_defend(skill.shield)
	if skill.heal > 0:
		_heal(skill.heal)
	# Simulate attack animation
	await get_tree().create_timer(3).timeout

func _attack(damage: int) -> void:
	'''
	Deals damage to opposing actor
	
	:param damage: damage to be dealt
	:type damage: int
	'''
	emit_signal('do_damage', damage)
	print('dealt '+str(damage)+' damage')

func _defend(shield: int) -> void:
	'''
	Sets the actor's shield value to the value passed in
	
	:param shield: shield strength to be set
	:type shield: int
	'''
	barrier = shield
	print('erected a shield of '+str(shield)+' strength')

func _heal(health: int) -> void:
	'''
	Restores actor's health by the value passed in
	(can't go over max health). also updates the
	connected health UI
	
	:param health: health to restore
	:type health: int
	'''
	cur_health += health
	if cur_health > max_health:
		cur_health = max_health
	emit_signal('update_health_ui', cur_health)
	print('healed '+str(health)+' damage')

func _on_damage_recived(damage: int) -> void:
	'''
	Subtracts damage recieved from an opposing actor
	from the actor's current health
	
	:param damage: damage to deplete from health
	:type damage: int
	'''
	if barrier > 0:
		damage -= barrier
	if damage > 0:
		cur_health -= damage
	if cur_health <= 0:
		emit_signal('death')
	emit_signal('update_health_ui', cur_health)

func _on_atb_timer_timeout() -> void:
	'''
	Sets changing_time to true when signal is recieved
	'''
	changing_time = true

func _change_moves() -> void:
	'''
	Implemented solely by child classes
	'''
	pass
