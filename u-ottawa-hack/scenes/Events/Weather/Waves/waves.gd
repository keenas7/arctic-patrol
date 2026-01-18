extends Area2D
class_name Waves

var collision : CollisionShape2D
var sprite : Sprite2D
var timer: Timer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	global_position = Vector2(randi() % 1000, randi() % 1000) #Spawns the wave randomly
	set_deferred("Size", Vector2(randi() % 500, randi() % 500))
	timer.start(15)
	timer.timeout.connect(_generate_waves)
	
	
func _generate_waves():
	queue_free()
	var new_wave: Waves = preload("res://scenes/Events/Weather/Waves/waves.tscn").instantiate()
	new_wave.global_position = Vector2(randi() % 1000, randi() % 1000)
	new_wave.set_deferred("Size", Vector2(randi() % 500, randi() % 500))
	timer.start(15)


func _on_body_entered(_body: Node2D) -> void:
	for i in get_overlapping_bodies():
		if i is Ship:
			i.position -= i.position * .5
			i.fuel_consumption_rate *= 1.25


func _on_body_exited(body: Node2D) -> void:
	if body is Ship:
		body.fuel_consumption_rate /= 1.25
