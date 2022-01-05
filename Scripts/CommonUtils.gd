extends Node

func _ready():
	randomize()

func shuffle_and_draw(array: Array):
	array.shuffle()
	return array.pop_back()
