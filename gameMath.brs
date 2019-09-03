function Math_Clamp(number, min, max)
	if number < min
		return min
	else if number > max
		return max
	else
		return number
	end if
end function

function Math_PI()
	return 3.1415926535897932384626433832795
end function

function Math_Atan2(y as float, x as float)
    if x > 0
		angle = Atn(y/x)
	else if y >= 0 and x < 0
		angle = Atn(y/x)+3.14159265359
	else if y < 0 and x < 0
		angle = Atn(y/x)-3.14159265359
	else if y > 0 and x = 0
		angle = 3.14159265359/2
	else if y < 0 and x = 0
		angle = (3.14159265359/2)*-1
	else
		angle = 0
	end if

	return angle
end function

function Math_IsIntegerEven(number as integer) as boolean
	return (number MOD 2 = 0)
end function

function Math_IsIntegerOdd(number as integer) as boolean
	return (number MOD 2 <> 0)
end function

function Math_DegreesToRadians(degrees as float) as float
	return (degrees / 180) * Math_PI()
end function

function Math_RadiansToDegrees(radians as float) as float
	return (180 / Math_PI()) * radians
end function

function Math_RandomRange(lowest_int as integer, highest_int as integer) as integer
	return rnd(highest_int - (lowest_int - 1)) + (lowest_int - 1)
end function

' https://stackoverflow.com/questions/2259476/rotating-a-point-about-another-point-2d
function Math_RotateVectorAroundVector(vector1 as object, vector2 as object, radians as float) as object
	v = Math_NewVector(vector1.x, vector1.y)
	s = sin(radians)
	c = cos(radians)

    v.x -= vector2.x
    v.y -= vector2.y

    new_x = v.x * c - v.y * s
    new_y = v.x * s + v.y * c

    v.x = new_x + vector2.x
    v.y = new_y + vector2.y
    
    return v
end function

function Math_NewVector(x = 0, y = 0) as object
	vector = {
		x: x,
		y: y,
		Magnitude: invalid,
		DirectionInRadians: invalid,
		DirectionInDegrees: invalid
	}

	vector.Magnitude = function() as double
		return Sqr(m.x^2 + m.y^2)
	end function

	vector.DirectionInRadians = function() as double
		return Math_Atan2(m.y, m.x)
	end function

	vector.DirectionInDegrees = function() as double
		return Math_RadiansToDegrees(m.DirectionInRadians())
	end function

	return vector
end function

function Math_NewRectangle(x as integer, y as integer, width as integer, height as integer) as object
	rect = {
		x: x
		y: y
		width: width
		height: height
	}

	rect.Right = function() as integer
		return m.x + m.width
	end function

	rect.Left = function() as integer
		return m.x
	end function

	rect.Top = function() as integer
		return m.y
	end function

	rect.Bottom = function() as integer
		return m.y + m.height
	end function

	rect.Center = function() as object
		return {x: m.x + m.width / 2, y: m.y + m.height / 2}
	end function

	rect.TopLeft = function() as object
		return Math_NewVector(m.Left(), m.Top())
	end function

	rect.TopRight = function() as object
		return Math_NewVector(m.Right(), m.Top())
	end function

	rect.BottomLeft = function() as object
		return Math_NewVector(m.Left(), m.Bottom())
	end function

	rect.BottomRight = function() as object
		return Math_NewVector(m.Right(), m.Bottom())
	end function

	rect.Copy = function() as object
		return Math_NewRectangle(m.x, m.y, m.width, m.height)
	end function

	return rect
end function

function Math_NewCircle(x as integer, y as integer, radius as float) as object
	circle = {
		x: x,
		y: y,
		radius: radius,
		Center: invalid
	}

	circle.Center = function()
		return Math_NewVector(m.x, m.y)
	end function

	return circle
end function

function Math_TotalDistance(vector1 as object, vector2 as object) as object
	x_distance = vector1.x - vector2.x
	y_distance = vector1.y - vector2.y
	total_distance = Sqr(x_distance * x_distance + y_distance * y_distance)
	return total_distance
end function

function Math_GetAngle(vector1 as object, vector2 as object) as float
	x_distance = vector1.x - vector2.x
	y_distance = vector1.y - vector2.y
	return Math_Atan2(y_distance, x_distance) + Math_PI()
end function

function Math_HypotenuseToVector(hypotenuse as float, radians as float)
	x = Cos(radians) * hypotenuse
	y = Sin(radians) * hypotenuse
	return Math_NewVector(x,y)
end function

function Math_VectorToHypotenuse(vector as object) as object
	return sqr(vector.x * vector.x + vector.y * vector.y)
end function

function Math_AddVectors(vector1 as object, vector2 as object) as object
	return Math_NewVector(vector1.x + vector2.x, vector1.y + vector2.y)
end function

function Math_MultiplyVectors(vector1 as object, vector2 as object) as object
	return Math_NewVector(vector1.x * vector2.x, vector1.y * vector2.y)
end function
