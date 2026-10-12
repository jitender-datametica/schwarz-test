/* --------------------------------------------------------------------------------
   DDL for table: t_model_rating_score_type_2
   generated from Powerdesigner on Montag, 9. Oktober 2023 16:52:53
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_model_rating_score_type_2 (
model_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Surrogate Key MODEL'),
rating_score_type_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Surrogate Key RATING SCORE TYPE'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier des letzten Ladelaufs, der den Datensatz eingfuegt oder veraendert hat'),
dwh_created DATETIME NOT NULL OPTIONS(description='Zeitstempel der Ersteinfuegung des Datensatzes ins DWH'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Zeitstempel der letzten Aenderung des Datensatzes im DWH'),
PRIMARY KEY (model_sid, rating_score_type_sid) NOT ENFORCED
)
OPTIONS(description='this table contains the information which rating score will be calculated and used in which model');