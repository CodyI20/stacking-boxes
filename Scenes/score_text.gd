extends RichTextLabel


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	update_text()
	Events.raycast_position_update.connect(update_text)

func update_text() -> void:
	text = "[b][font_size=30][color=CYAN][i][wave amp=0.5] %s" % MatchData.current_score
