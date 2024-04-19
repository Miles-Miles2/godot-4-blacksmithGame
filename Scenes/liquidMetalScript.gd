extends Node2D

@export var storedLiquid = {}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	

func addLiquid(liquid: String, amount: float):
	if (storedLiquid.has(liquid)):
		storedLiquid[liquid] += amount
	else:
		storedLiquid[liquid] = amount
	print("stored Liquid: " + str(storedLiquid))
	
func getTotalLiquid() -> float:
	var total = 0
	for metal in storedLiquid:
		total += storedLiquid[metal]
	return total
	
func pourOutPercent(percent: float) -> Dictionary:
	var output = {}
	for metal in storedLiquid:
		output[metal] = storedLiquid[metal] * percent
	return output
