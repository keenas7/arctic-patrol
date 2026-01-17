extends Node

# Global game state - accessible from anywhere
var current_scenario: String = ""
var mission_time: float = 0.0
var total_fuel_consumed: float = 0.0
var total_budget: float = 1000000.0
var budget_spent: float = 0.0

# References to active entities (managed by managers)
var active_ships: Array = []
var active_ports: Array = []

# Configuration
var game_speed: float = 1.0
var difficulty: String = "Medium"

func reset():
	mission_time = 0.0
	total_fuel_consumed = 0.0
	budget_spent = 0.0
	active_ships.clear()
	active_ports.clear()
