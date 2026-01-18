extends StaticBody2D
class_name Port

# properties and default values

@export var port_name: String = "default port"
@export var port_type: String = "Resource"  # "Resource", "Research", "etc"
@export var max_berths: int = 3 #berths are docking spots for ships.
@export var fuel_capacity: float = 10000.0
@export var current_fuel: float = 10000.0

#i do not believe this will be implemented. but, i keep it in mind. 
#@export var refuel_rate: float = 20.0  # fuel per second
#@export var fuel_regeneration: float = 5.0  # fuel regenerated per second
#@export var refuel_cost_multiplier: float = 1.0  # 1.0 = normal, 2.0 = expensive

var docked_ships: Array[Ship] = []  # Ships currently refueling
var waiting_ships: Array[Ship] = []  # Ships in queue

@onready var berth_positions = $QueuePositions.get_children()
@onready var portUI : UiPort = get_node("%Ship Port UI")
	
func _process(delta): #automatically done every frame (delta is change in time since last call)
	# Regenerate fuel over time
	current_fuel = min(current_fuel * delta, fuel_capacity) 
	
	# TODO add timer possibly make ships wait longer

	# Process refueling for docked ships
	for ship in docked_ships:
		refuel_ship(ship, delta)

	# Try to assign berths to waiting ships
	assign_berths()

func request_docking(ship: Ship): # Berth slot available, insert ship to docking (berth) array
	if docked_ships.size() < max_berths:
		dock_ship(ship)
	else:
		# Add to wait queue
		# unnaceptable waste of time in some circumstances, that's for player to decide.
		waiting_ships.append(ship)
		ship.set_waiting_at_port(true) #current status = "waiting..."
		print("%s queue: %d ships waiting" % [port_name, waiting_ships.size()])

func dock_ship(ship: Ship):
	var berth_index = docked_ships.size()
	var berth_position = berth_positions[berth_index].global_position # note always use global position for moving objects in the world not relative to any other object.

	docked_ships.append(ship)
	ship.navigator.target_position = berth_position
	print("%s docked at %s (berth %d)" % [ship.ship_name, port_name, berth_index + 1])

func refuel_ship(ship: Ship, _delta):
	var refill : float = ship.fuel_capacity - ship.current_fuel 
	if current_fuel - refill <= 0:
		ship.show_message("Port out of fuel!")
		return
	
	current_fuel -= refill
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
func assign_berths():
	while waiting_ships.size() > 0 and docked_ships.size() < max_berths:
		var next_ship = waiting_ships.pop_front()
		dock_ship(next_ship)
		
#wait time... etc 

func clickedOn():
	if portUI.adding_to_route:
		pass
	else:
		portUI.openShipMenu(self, docked_ships)

func releaseShip(index: int, route):
	pass
