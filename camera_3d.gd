extends Camera3D


@export var player:Node3D

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	
	var target_position = player.global_position + Vector3(2,2,2)
		
	global_position = lerp(global_position, target_position, delta * 2)
	look_at(player.global_position)
	
	pass
