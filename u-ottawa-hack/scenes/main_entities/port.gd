extends Area2D
class_name Port

# properties and default values

@export var port_name: String = "default port"
@export var port_type: String = "Resource"  # "Resource", "Research", "etc"
@export var max_docks: int = 3 #docks are docking spots for ships.
@export var fuel_capacity: float = 10000.0
@export var port_current_fuel: float = 10000.0

#i do not believe this will be implemented. but, i keep it in mind. 
#@export var refuel_rate: float = 20.0  # fuel per second
#@export var fuel_regeneration: float = 5.0  # fuel regenerated per second
#@export var refuel_cost_multiplier: float = 1.0  # 1.0 = normal, 2.0 = expensive

var docked_ships: Array = []  # Ships currently refueling
var waiting_ships: Array = []  # Ships in queue

@onready var dock_position = $DockPosition # TODO please put this as a Marker2D
#func _ready(): #initializer
	# Connect signals for ships entering/exiting
	#body_entered.connect(_on_ship_entered)
	#body_exited.connect(_on_ship_exited)
	
func _process(delta): #automatically done every frame (delta is change in time since last call)
	# Regenerate fuel over time
	port_current_fuel = min(port_current_fuel * delta, fuel_capacity) 
	
	# TODO add timer possibly make ships wait longer

	# Process refueling for docked ships
	for ship in docked_ships:
		refuel_ship(ship, delta)

	# Try to assign docks to waiting ships
	assign_docks()
	

# on action body_entered, signal sent to this function to request ship be docked (add to wait queue, or to dock array)
func _on_ship_entered(ship):
	request_docking(ship)

func request_docking(ship): # dock slot available, insert ship to docking (dock) array
	if docked_ships.size() < max_docks:
		dock_ship(ship)
	else:
		# Add to wait queue
		# unnaceptable waste of time in some circumstances, that's for player to decide.
		waiting_ships.append(ship)
		ship.set_waiting_at_port(true) #current status = "waiting..."
		print("%s queue: %d ships waiting" % [port_name, waiting_ships.size()])

func dock_ship(ship):
	var dock_index = docked_ships.size()

	docked_ships.append(ship)
	print("%s docked at %s (dock %d)" % [ship.ship_name, port_name, dock_index + 1])

#refuel a ship every frame with delta 
func refuel_ship(ship: Ship, delta):
	var refill : float = ship.fuel_capacity - ship.current_fuel 
	if port_current_fuel <= 0:
		ship.show_message("Port out of fuel!")
		return
	
	port_current_fuel -= refill
	ship.current_fuel += refill


# ATTEMP TO MODIFY SHIP FUEL ... TODO !!!!!
# var fuel_needed = ship.max_fuel - ship.fuel

#var fuel_to_transfer = min(
#		refuel_rate * delta,
#		fuel_needed,
#		current_fuel
#)

# ship.fuel += fuel_to_transfer
# current_fuel -= fuel_to_transfer


# Assign next ship in queue to the docking array
func assign_docks():
	while waiting_ships.size() > 0 and docked_ships.size() < max_docks:
		var next_ship = waiting_ships.pop_front()
		dock_ship(next_ship)
		
#wait time... etc 
