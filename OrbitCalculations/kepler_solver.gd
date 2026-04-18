class_name KeplerSolver extends RefCounted



func get_planet_position(body: OrbitalBody, jd: float) -> Vector3:
	#Number of centuries past J2000.0
	var T: float = (jd - 2451545.0) / 36525
	
	#Rate adjusted values
	var a: float = body.a + body.rate_a * T
	var e: float = body.e + body.rate_e * T
	var I: float = deg_to_rad(fmod(body.I + body.rate_I * T, 360.0))
	var L: float = deg_to_rad(fmod(body.L + body.rate_L * T, 360.0))
	var w: float = deg_to_rad(fmod(body.long_peri + body.rate_long_peri * T, 360.0))
	var ohm: float = deg_to_rad(fmod(body.long_node + body.rate_long_node * T, 360.0))
	var b: float = deg_to_rad(body.b)
	var c: float = deg_to_rad(body.c)
	var s: float = deg_to_rad(body.s)
	var f: float = deg_to_rad(body.f)
	
	var a_p: float = w - ohm
	var M: float = L - w + b * (T ** 2) + c * cos(f * T) + s * sin(f * T)
	M = normalize_angle(M)
	var E: float = solve_kepler(M, e)
	
	var x_orb: float = a * cos(E) - e
	var y_orb: float = a * sqrt(1 - e ** 2) * sin(E)
	
	var x_ecl: float = ((cos(a_p) * cos(ohm) - sin(a_p) * sin(ohm) * cos(I)) * x_orb
					+ (- sin(a_p) * cos(ohm) - cos(a_p) * sin(ohm) * cos(I)) * y_orb
					)
	var y_ecl: float = ((cos(a_p) * sin(ohm) + sin(a_p) * cos(ohm) * cos(I)) * x_orb
					+ (- sin(a_p) * sin(ohm) + cos(a_p) * cos(ohm) * cos(I)) * y_orb
					)
	var z_ecl: float = (sin(a_p) * sin(I)) * x_orb + (cos(a_p) * sin(I)) * y_orb
	
	return Vector3(x_ecl, z_ecl, y_ecl) * GameManager.CONVERSION_FACTOR
	

func solve_kepler(M: float, e: float) -> float:
	var E = M + e * sin(M)
	
	for i in range(10):
		var dM: float = M - (E - e * sin(E))
		var dE: float = dM / (1 - e * cos(E))
		E += dE
		if abs(dE) <= 10e-6:
			break
		
	return E

func normalize_angle(angle: float) -> float:
	angle = fmod(angle, 360.0)
	if angle > 180.0:
		angle -= 360.0
	elif angle < -180.0:
		angle += 360.0
	return angle
	
