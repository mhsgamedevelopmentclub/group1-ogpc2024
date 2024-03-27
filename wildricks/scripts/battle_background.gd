class_name BattleBackground
extends ColorRect

@onready var hero_container := $"HBoxContainer/Hero Container"
@onready var enemy_container := $"HBoxContainer/Enemy Container"
@onready var health_bar: PackedScene = preload('res://scenes/health_bar.tscn')

func init(heros: Array[PlayerActor], enemies: Array[EnemyActor]) -> void:
	for hero in heros:
		hero_container.add_child(_construct_visual(hero))
	for enemy in enemies:
		enemy_container.add_child(_construct_visual(enemy))

func _construct_visual(actor: Actor) -> CenterContainer:
	var container: CenterContainer = _construct_visual_container()
	var health_ui: HealthBar = _construct_health_bar(actor)
	var sprite: Sprite2D = _construct_sprite(actor.sprite)
	sprite.add_child(health_ui)
	container.add_child(sprite)
	return container

func _construct_visual_container() -> CenterContainer:
	var container: CenterContainer = CenterContainer.new()
	container.size_flags_horizontal = SIZE_SHRINK_CENTER
	container.size_flags_vertical = SIZE_SHRINK_CENTER
	return container

func _construct_health_bar(actor: Actor) -> HealthBar:
	var health_ui: HealthBar = health_bar.instantiate() as HealthBar
	health_ui.init(actor)
	return health_ui

func _construct_sprite(texture: CompressedTexture2D) -> Sprite2D:
	var sprite: Sprite2D = Sprite2D.new()
	sprite.texture = texture
	return sprite
