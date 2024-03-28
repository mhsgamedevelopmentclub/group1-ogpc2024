class_name SkillSlot
extends ColorRect

var skill_ref: Skill

func init(skill: Skill) -> void:
	skill_ref = skill
	color = skill.color
	name = skill.name
	($Label as Label).text = skill.name

func _get_drag_data(_at_position: Vector2) -> SkillSlot:
	set_drag_preview(make_preview())
	return self

func make_preview() -> ColorRect:
	var preview: ColorRect = ColorRect.new()
	preview.size = size
	preview.color = color
	preview.color.a = 0.5
	return preview
