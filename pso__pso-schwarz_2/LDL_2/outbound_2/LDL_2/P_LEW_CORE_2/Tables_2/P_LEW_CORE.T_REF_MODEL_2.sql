CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_ref_model_2 (
model_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Surrogate Key MODEL'),
model_group_cd STRING(100) NOT NULL
OPTIONS(description='eindeutiger code, der mit dem area_cd beginnt z.b. AP_bakeoff or CX_store_rating'),
model_area_cd STRING(100) NOT NULL OPTIONS(description='sprechender Code, CX, LDL+,AP'),
model_name STRING(100) OPTIONS(description='name of the model'),
model_descr STRING(250) OPTIONS(description='description of the model'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier des letzten Ladelaufs, der den Datensatz eingfuegt oder veraendert hat'),
dwh_created DATETIME NOT NULL OPTIONS(description='Zeitstempel der Ersteinfuegung des Datensatzes ins DWH'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Zeitstempel der letzten Aenderung des Datensatzes im DWH'),
PRIMARY KEY (model_sid) NOT ENFORCED
)
OPTIONS(description='$Revision: 0000 $. a model consists of one or more segmentaions which are defined together and intended to run together');