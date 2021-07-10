extends "res://Characters/NPCs/PlayerDetection.gd"

onready var navigation = get_tree().get_root().find_node("Navigation2D", true, false)
onready var destinations = navigation.get_node("Destinations")

var motion
var possible_destinations
var path

export var minimum_arrival_distance = 5
export var walk_speed = 0.5

func _ready():
	randomize()
	possible_destinations = destinations.get_children()
	make_path()

func _physics_process(delta):
	navigate()

func navigate():
	var distance_to_destination = position.distance_to(path[0])
	if distance_to_destination > minimum_arrival_distance:
		move()
	else:
		update_path()

func move():
	var angle_to_rotate = (path[0] - global_position).normalized().angle()
	rotation = lerp_angle(global_rotation, angle_to_rotate, 0.1)
	motion = (path[0] - position).normalized() * (MAX_SPEED * walk_speed)
	
	if is_on_wall():
		make_path()
	
	move_and_slide(motion)

func update_path():
	if path.size() == 1:
		if $Timer.is_stopped():
			$Timer.start()
	else:
		path.remove(0)

func make_path():
	var index = randi() % possible_destinations.size() - 1
	var new_destination = possible_destinations[index]
	path = navigation.get_simple_path(position, new_destination.position, false)

func _on_Timer_timeout():
	make_path()
