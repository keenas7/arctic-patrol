extends Ship

var begin_new_nav : bool = false


func clickedOn():
	begin_new_nav = true

func onClick():
	if begin_new_nav:
		navigator.target_position = get_global_mouse_position()
		begin_new_nav = false


#patroller-SPECIFIC PROPERTIES
var quick_click_active: bool = true


func _ready():
	# Call parent's _ready first
	super._ready()  # Runs Ship's _ready()
	
	# add frigate-specific setup
	ship_display_name = "little scout"
	ship_type = "patroller"
	fuel_capacity = 1000.0
	current_fuel = 1000.0
	fuel_consumption_rate = 0.01
	max_speed = 200.0
	speed = max_speed
	
