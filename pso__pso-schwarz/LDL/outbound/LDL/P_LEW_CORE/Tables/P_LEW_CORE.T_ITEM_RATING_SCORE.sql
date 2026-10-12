/* --------------------------------------------------------------------------------
   DDL for table: t_item_rating_score
   generated from Powerdesigner on Montag, 9. Oktober 2023 16:50:49
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_item_rating_score (
item_rating_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Surrogate Key for rating of an item.'),
rating_score_type_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Surrogate Key RATING SCORE TYPE.'),
rating_score_meas BIGNUMERIC(38,5) NOT NULL OPTIONS(description='Value of the calculated rating score.'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier des letzten Ladelaufs, der den Datensatz eingefügt oder verändert hat.'),
dwh_created DATETIME NOT NULL OPTIONS(description='Zeitstempel der Ersteinfügung des Datensatzes ins DWH.'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Zeitstempel der letzten Änderung des Datensatzes im DWH.'),
PRIMARY KEY (rating_score_type_sid, item_rating_sid) NOT ENFORCED
) OPTIONS(description='This table contains the rating scores calculated for a certain item rating using a model.');