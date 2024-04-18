extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.


func spawnItem(item: Node2D, pos: Vector2):
	var clonedItem = item.duplicate()
	add_child(clonedItem)
	clonedItem.position = pos
