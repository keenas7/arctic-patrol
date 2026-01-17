extends StaticBody2D

# properties and default values

@export var port_name: String = "default ship"

@export var port_type: String = "Resource"  # "Resource", "Research", "etc"
@export var max_berths: int = 3 #berths are docking spots for ships.
@export var fuel_capacity: float = 10000.0
@export var current_fuel: float = 10000.0
#@export var refuel_rate: float = 20.0  # fuel per second
#@export var fuel_regeneration: float = 5.0  # fuel regenerated per second
#@export var refuel_cost_multiplier: float = 1.0  # 1.0 = normal, 2.0 = expensive

var docked_ships: Array = []  # Ships currently refueling
#var waiting_ships: Array = []  # Ships in queue

@onready var berth_positions = $QueuePositions.get_children()
#func _ready(): #initializer
	# Connect signals for ships entering/exiting
	#body_entered.connect(_on_ship_entered)
	#body_exited.connect(_on_ship_exited)
	
func _process(delta): #automatically done every frame (delta is change in time since last call)
	# Regenerate fuel over time
	current_fuel = min(current_fuel + fuel_regeneration * delta, fuel_capacity)

	# Process refueling for docked ships
	for ship in docked_ships:
		refuel_ship(ship, delta)

	# Try to assign berths to waiting ships
	assign_berths()
	

func _on_ship_entered(ship):
	if ship.is_in_group("ships"):
		request_docking(ship)
func request_docking(ship):
	if docked_ships.size() < max_berths:
		# Berth available
		dock_ship(ship)
	else:
		# Add to queue
		waiting_ships.append(ship)
		ship.set_waiting_at_port(true)
		print("%s queue: %d ships waiting" % [port_name, waiting_ships.size()])
