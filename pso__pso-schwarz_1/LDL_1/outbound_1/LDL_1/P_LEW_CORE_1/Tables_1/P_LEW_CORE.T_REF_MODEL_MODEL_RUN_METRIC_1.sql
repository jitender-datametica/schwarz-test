/* --------------------------------------------------------------------------------
   DDL for table: t_ref_model_model_run_metric_1
   generated from Powerdesigner on Mittwoch, 14. Juni 2023 16:34:30
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_ref_model_model_run_metric_1 (
model_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Surrogate Key MODEL'),
model_run_metric_type_cd STRING(50) NOT NULL
OPTIONS(description='technical code for the metric to be calculated on model level in a run'),
model_area_cd STRING(100) NOT NULL OPTIONS(description='sprechender Code, CX, LDL+,AP'),
model_group_cd STRING(100) NOT NULL
OPTIONS(description='eindeutiger code, der mit dem area_cd beginnt z.b. AP_bakeoff or CX_store_rating'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier des letzten Ladelaufs, der den Datensatz eingfuegt oder veraendert hat'),
dwh_created DATETIME NOT NULL OPTIONS(description='Zeitstempel der Ersteinfuegung des Datensatzes ins DWH'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Zeitstempel der letzten Aenderung des Datensatzes im DWH'),
PRIMARY KEY (model_sid, model_run_metric_type_cd) NOT ENFORCED
)
OPTIONS(description='$Revision: 0000 $. this table contains the information which model run metric will be calculated for which model');