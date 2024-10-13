extends VBoxContainer

@onready var highscore: RichTextLabel = $Highscore
@onready var highscore_2: RichTextLabel = $Highscore2
@onready var highscore_3: RichTextLabel = $Highscore3
@onready var highscore_4: RichTextLabel = $Highscore4
@onready var highscore_5: RichTextLabel = $Highscore5


func _ready() -> void:
	highscore.text = "[b] 1. 			[font_size=20]%s" % MatchData.high_score_save_data.high_score
	highscore_2.text = "[b] 2. 			[font_size=20]%s" % MatchData.high_score_save_data.high_score_2
	highscore_3.text = "[b] 3. 			[font_size=20]%s" % MatchData.high_score_save_data.high_score_3
	highscore_4.text = "[b] 4. 			[font_size=20]%s" % MatchData.high_score_save_data.high_score_4
	highscore_5.text = "[b] 5. 			[font_size=20]%s" % MatchData.high_score_save_data.high_score_5
