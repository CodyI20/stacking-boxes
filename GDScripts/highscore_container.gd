extends VBoxContainer

@onready var highscore: RichTextLabel = $Highscore
@onready var highscore_2: RichTextLabel = $Highscore2
@onready var highscore_3: RichTextLabel = $Highscore3
@onready var highscore_4: RichTextLabel = $Highscore4
@onready var highscore_5: RichTextLabel = $Highscore5


func _ready() -> void:
	highscore.text = "%s" % MatchData.high_score_save_data.high_score
	highscore_2.text = "%s" % MatchData.high_score_save_data.high_score_2
	highscore_3.text = "%s" % MatchData.high_score_save_data.high_score_3
	highscore_4.text = "%s" % MatchData.high_score_save_data.high_score_4
	highscore_5.text = "%s" % MatchData.high_score_save_data.high_score_5
