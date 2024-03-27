class_name HealthBar
extends Node2D

@onready var bar_red := load('res://assets/barHorizontal_red.png')
@onready var bar_green := load('res://assets/barHorizontal_green.png')
@onready var bar_yellow := load('res://assets/barHorizontal_yellow.png')

var healthbar: TextureProgressBar
var label: Label

func init(actor: Node) -> void:
	healthbar = $TextureProgressBar as TextureProgressBar
	label = $TextureProgressBar/Label as Label
	healthbar.max_value = actor.max_health
	_update_text(healthbar.max_value)
	actor.connect('update_health_ui', update_health)

func update_health(value: int) -> void:
	healthbar.texture_progress = bar_green
	if value < healthbar.max_value * 0.7:
		healthbar.texture_progress = bar_yellow
	if value < healthbar.max_value * 0.35:
		healthbar.texture_progress = bar_red
	healthbar.value = value
	_update_text(value)

func _update_text(value: int) -> void:
	label.text = "{} / {}".format(
		[value, healthbar.max_value], 
		'{}'
	)
