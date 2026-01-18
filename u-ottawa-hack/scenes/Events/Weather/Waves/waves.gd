extends Node2D

var waves = Area2D.new()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	waves.global_position = Vector2(randi() % 100, randi() % 100)
	#waves.global_position = Vector2.ZERO
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	await get_tree().create_timer(randi() % 30).timeout
	create_new_instance()


func _on_body_entered(body: Node2D) -> void:
	if body is Ship:
		body.position -= body.position * .5
		body.fuel_consumption_rate *= 1.25
		
func _on_body_exited(body: Node2D) -> void:
	if body is Ship:
		body.fuel_consumption_rate /= 2

func create_new_instance():
	var new_waves_sce: PackedScene = preload("res://scenes/Events/Weather/Waves/waves.tscn")
	var new_waves = new_waves_sce.instantiate()
	new_waves.global_position = Vector2(randi() % 100, randi() % 100)
	add_child(new_waves)
	
	
