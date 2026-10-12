/* --------------------------------------------------------------------------------
   DDL for table: t_ref_rating_score_type
   generated from Powerdesigner on Montag, 9. Oktober 2023 16:52:16
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_ref_rating_score_type (
rating_score_type_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Surrogate Key RATING SCORE TYPE'),
rating_score_type_name STRING(100) NOT NULL OPTIONS(description='Name of the rating score type'),
rating_score_type_descr STRING(250) NOT NULL OPTIONS(description='Description of the rating score type'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier des letzten Ladelaufs, der den Datensatz eingefügt oder verändert hat.'),
dwh_created DATETIME NOT NULL OPTIONS(description='Zeitstempel der Ersteinfügung des Datensatzes ins DWH.'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Zeitstempel der letzten Änderung des Datensatzes im DWH.'),
PRIMARY KEY (rating_score_type_sid) NOT ENFORCED
)
OPTIONS(description='This table contains rating score types. A rating score type is a certain well defined calculation which will be calculated if a rating model is applied. The result will be stored as an intermediate or final result to allow the assignement of entities to rating classes.');