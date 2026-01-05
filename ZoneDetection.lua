local ZoneDetection = {}

function ZoneDetection.IsBallDangerous(ball, playerRoot, radius)
	if not ball or not playerRoot then
		return false
	end

	local distance = (ball.Position - playerRoot.Position).Magnitude
	if distance > radius then
		return false
	end

	local velocity = ball.AssemblyLinearVelocity
	if velocity.Magnitude < 1 then
		return false
	end

	local directionToPlayer = (playerRoot.Position - ball.Position).Unit
	local dot = velocity.Unit:Dot(directionToPlayer)

	return dot > 0.8
end

return ZoneDetection
