extends Node2D

# Called when the node enters the scene tree for the first time.

var temp: float = 0
var heatTarget: float = 5000
var heatOn := false
var updateHeatCounter = 0
var itemInFurnace: Node2D = null
@onready var level: Node2D = get_parent().get_parent()

@export var HEATING_SPEED: float
@onready var width: int = $CoalHolders/floor_ceiling/floor.shape.size.x
@onready var floorHeight = $CoalHolders/floor_ceiling/floor.position.x

var bucket = preload("res://Scenes/resources/liquid_metal.tscn")
var coal = preload("res://Scenes/coal.tscn")
var offImage = Image.load_from_file("res://Art/heatIconOff.png")
var offTexture = ImageTexture.create_from_image(offImage)
var onImage = Image.load_from_file("res://Art/heatIconOn.png")
var onTexture = ImageTexture.create_from_image(onImage)

var rng = RandomNumberGenerator.new()


func _ready() -> void:
	
	print(width)
	for i in range(30):
		var clone = coal.instantiate()

		clone.position = Vector2(rng.randf_range(-width/2.1, width/2.1), rng.randf_range(floorHeight - 10, floorHeight - 50))
		var scale = rng.randf_range(1, 3)
		clone.get_node("coalRB2D").get_node("CollisionShape2D").scale = Vector2(scale, scale)
		clone.get_node("coalRB2D").get_node("coalSprite").scale = Vector2(scale, scale)

		add_child(clone)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	updateHeatCounter += delta
	if (updateHeatCounter >= 0.1):
		updateHeatCounter -= 0.1
		$temperatureLabel.text = (str(snapped(temp, 1)) + " F")
		if (heatOn):
			temp += clamp((heatTarget - temp) * HEATING_SPEED, 0.1, 20)
		else:
			temp = max(temp - 3, 0)
		if (itemInFurnace):
			if (itemInFurnace.is_in_group("smeltable")):
				itemInFurnace.updateTemp(temp, self)


func toggleMenu():
	visible = not visible

func addMaterial(rawMetal: Node2D):
	if (itemInFurnace == null):
		var clonedObj = rawMetal.duplicate()
		clonedObj.position = $SmeltItemIcon.position
		clonedObj.remove_from_group("holdable")
		clonedObj.remove_from_group("selectable")
		add_child(clonedObj)
		itemInFurnace = clonedObj
	else:
		print("item already in furnace!")
		
func materialCooked():
	var newBucket = bucket.instantiate()
	add_child(newBucket)
	newBucket.position = $SmeltItemIcon.position
	newBucket.remove_from_group("holdable")
	newBucket.remove_from_group("selectable")
	newBucket.addLiquid(itemInFurnace.metalName, 1)
	
	var oldItem = itemInFurnace
	itemInFurnace = newBucket
	oldItem.queue_free()

func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if (event.is_pressed() && event.button_index == MOUSE_BUTTON_LEFT):
			heatOn = not heatOn
			if heatOn == true:
				$Area2D/HeatIcon.texture = onTexture
			else:
				$Area2D/HeatIcon.texture = offTexture


func _item_in_furnace_clicked(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if (event.is_pressed() && event.button_index == MOUSE_BUTTON_LEFT):
			if (itemInFurnace):
				itemInFurnace.add_to_group("selectable")
				itemInFurnace.add_to_group("holdable")
				level.spawnItem(itemInFurnace, level.get_node("Player").position)
				itemInFurnace.queue_free()
				itemInFurnace = null
				toggleMenu()
