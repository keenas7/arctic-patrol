extends Rain

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super._ready()
	
func _rain():
	if (randi() % 2) == 1:
		raining = true
		collision.disabled = false
		sprite.self_modulate.a = 0.6
		
		for i in get_overlapping_bodies():
			if i is Ship:
				i.fuel_consumption_rate *= 1.45
				
	stop_rain_time.start(25)
	
func _stop_raining():
	if raining:
		collision.disabled = true
		sprite.self_modulate.a = 0
		
		for i in get_overlapping_bodies():
			if i is Ship:
				i.fuel_consumption_rate /= 1.45
		
		raining = false
		
		rain_time.start(30)
