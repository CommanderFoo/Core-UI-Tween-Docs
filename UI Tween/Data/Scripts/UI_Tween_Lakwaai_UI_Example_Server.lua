-- For the sake of the example, all movement is disabled

Game.playerJoinedEvent:Connect(function(player)
	player.movementControlMode = MovementControlMode.NONE
	player.lookControlMode = LookControlMode.NONE
	player.maxJumpCount = 0
	player.canMount = false
	player.isCrouchEnabled = false
end)