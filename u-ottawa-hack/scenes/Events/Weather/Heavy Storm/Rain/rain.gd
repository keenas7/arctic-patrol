extends Area2D

var rain_time : Timer
var stop_rain_time : Timer
var collision : CollisionShape2D
var sprite : Sprite2D
var raining: bool


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	rain_time = get_node("Timer")
	collision = get_node("CollisionShape2D")
	sprite = get_node("Sprite2D")
	
	rain_time.timeout.connect(_rain)
	rain_time.start(30)
	stop_rain_time.timeout.connect(_stop_raining)
	

func _rain():
	if (randi() % 2) == 1:
		raining = true
		collision.disabled = false
		sprite.self_modulate.a = 0.6
		
		for i in get_overlapping_bodies():
			if i is Ship:
				i.fuel_consumption_rate *= 1.15
				
	stop_rain_time.start(25)
	
		
func _stop_raining():
	if raining:
		collision.disabled = true
		sprite.self_modulate.a = 0
		
		for i in get_overlapping_bodies():
			if i is Ship:
				i.fuel_consumption_rate /= 1.15
		
		raining = false
		
		rain_time.start(30)
	

	
	
