CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_ref_score_type (
score_type_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Surrogate Key SCORE TYPE'),
score_type_name STRING(100) OPTIONS(description='name of the score type'),
score_type_descr STRING(250) OPTIONS(description='description of the score type'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier des letzten Ladelaufs, der den Datensatz eingfuegt oder veraendert hat'),
dwh_created DATETIME NOT NULL OPTIONS(description='Zeitstempel der Ersteinfuegung des Datensatzes ins DWH'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Zeitstempel der letzten Aenderung des Datensatzes im DWH'),
PRIMARY KEY (score_type_sid) NOT ENFORCED
)
OPTIONS(description='$Revision: 0000 $. a score type is a certain well defined calculation result which will be calculated in a model run as intermediate or final result to allow the assignement of entities to segments');