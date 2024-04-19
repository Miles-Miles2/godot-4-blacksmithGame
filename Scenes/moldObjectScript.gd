extends Node2D


# Called when the node enters the scene tree for the first time.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func interact(heldItem: Node2D):
	$workstation_view.position = position
	$workstation_view.toggleMenu()
	if ($workstation_view.visible == true):
		$workstation_view.interact(heldItem)
		
