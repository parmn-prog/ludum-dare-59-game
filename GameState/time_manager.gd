extends Node

@export var time_scale: float = 86400 * 365.25
var jd_start: float
var elapsed_days: float

signal time_updated(jd: float)

func _ready() -> void:
	var time_dict: Dictionary = Time.get_datetime_dict_from_system(true)
	jd_start = calculate_jd(time_dict["year"], time_dict["month"], time_dict["day"],
				time_dict["hour"], time_dict["minute"], time_dict["second"]
	)

func _process(delta: float) -> void:
	elapsed_days += (delta * time_scale)/86400.0
	emit_signal("time_updated", current_jd())

func current_jd() -> float:
	return jd_start + elapsed_days

func calculate_jd(year: int, month: int, day: int, hour: float = 0.0, 
					minute: float = 0.0, second: float = 0.0) -> float:
	if month <= 2:
		year -= 1
		month += 12
	var A: float = int(year / 100.0)
	var B: float = int(A / 4.0)
	var C: float = 2 - A + B
	var E: float = int(365.25 * (year + 4716))
	var F: float = int(30.6001 * (month + 1))
	
	var day_fraction: float = hour/24.0 + minute/1440.0 + second/86400.0
	
	return C + day + day_fraction + E + F - 1524.5
