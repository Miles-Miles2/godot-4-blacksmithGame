extends Node2D

@export var metalName: String

@export var MIN_TEMP: int
@export var TEMP_SENSITIVITY: float

var temperature: float = 0



func updateTemp(furnaceTemp: float, furnaceObj: Node2D):
	
	temperature += clamp((furnaceTemp - temperature) * TEMP_SENSITIVITY, -5, 5)
	print(temperature)
	if (temperature > MIN_TEMP):
		furnaceObj.materialCooked()
