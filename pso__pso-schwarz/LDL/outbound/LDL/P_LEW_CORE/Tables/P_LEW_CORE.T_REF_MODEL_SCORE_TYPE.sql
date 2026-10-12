/* --------------------------------------------------------------------------------
   DDL for table: t_ref_model_score_type
   generated from Powerdesigner on Mittwoch, 14. Juni 2023 17:03:53
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_ref_model_score_type (
model_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Surrogate Key MODEL.'),
score_type_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Surrogate Key SCORE TYPE.'),
model_area_cd STRING(100) NOT NULL OPTIONS(description='Sprechender Code, CX, LDL+, AP.'),
model_group_cd STRING(100) NOT NULL
OPTIONS(description='Eindeutiger Code, der mit dem area_cd beginnt z.b. AP_bakeoff oder CX_store_rating.'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier des letzten Ladelaufs, der den Datensatz eingefuegt oder veraendert hat.'),
dwh_created DATETIME NOT NULL OPTIONS(description='Zeitstempel der Ersteinfuegung des Datensatzes ins DWH.'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Zeitstempel der letzten Aenderung des Datensatzes im DWH.'),
PRIMARY KEY (model_sid, score_type_sid) NOT ENFORCED
)
OPTIONS(description='$Revision: 0000 $. This table contains the information which score will be calculated and used in which model.');