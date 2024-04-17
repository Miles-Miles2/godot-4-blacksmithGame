extends Node2D


# Called when the node enters the scene tree for the first time.
func interact(heldItem: Node2D):
	print("furnace interacted with. held item: " + str(heldItem))
	if (heldItem != null):
		$workstation_view.addMaterial(heldItem)
	else:
		$workstation_view.position = position
		$workstation_view.openMenu()
