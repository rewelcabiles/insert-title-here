extends Node

class_name Stat

signal updated

var base = 1 
var add = 0 
var mult = 1.0

var stat_name

func compute():
	return (base+add)*mult