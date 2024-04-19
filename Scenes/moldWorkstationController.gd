extends Node2D

var inputBucket: Node2D
var moldContents = {}
var moldShape: String
var selectedIndex: int
@export var moldIcons = {}
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func toggleMenu():
	visible = not visible
# Called every frame. 'delta' is the elapsed time since the previous frame.
func interact(heldItem: Node2D):
	if (heldItem):
		if (heldItem.is_in_group("pourable")):
			inputBucket = heldItem
		


func mold_selected(index: int) -> void:
	print("selected: " + $ItemList.get_item_text(index))
	if (moldContents.is_empty()):
		moldShape = $ItemList.get_item_text(index)
		$moldShape.texture = moldIcons[moldShape].moldTexture
		selectedIndex = index
	else:
		$ItemList.select(selectedIndex)
	
		


func pour() -> void:
	var amountOfLiquid = inputBucket.getTotalLiquid()
	if (moldShape):
		print("amt in bucket: " + str(amountOfLiquid) + ", capacity: " + str(moldIcons[moldShape].moldCapacity))
		if (amountOfLiquid >= moldIcons[moldShape].moldCapacity):
			var pouredLiquid = inputBucket.pourOutPercent(moldIcons[moldShape].moldCapacity / amountOfLiquid)
			for liquid in pouredLiquid:
				if (moldContents.has(liquid)):
					moldContents[liquid] += pouredLiquid[liquid]
				else:
					moldContents[liquid] = pouredLiquid[liquid]
			print("mold contents: " + str(moldContents))
