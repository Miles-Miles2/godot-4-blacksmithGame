extends Node2D

@export var smeltedVersionName: String

@export var MIN_TEMP: int
@export var TEMP_SENSITIVITY: float
@onready var smeltedVersion = load(smeltedVersionName)

var temperature: float = 0



func updateTemp(furnaceTemp: float):
	
	temperature += clamp((furnaceTemp - furnaceTemp) * TEMP_SENSITIVITY, -20, 20)
	print(temperature)
