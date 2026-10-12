/* --------------------------------------------------------------------------------
   DDL for table: t_model_run_metric_2
   generated from Powerdesigner on Mittwoch, 14. Juni 2023 18:03:23
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_model_run_metric_2 (
model_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Surrogate Key MODEL'),
geo_area_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Surrogate Key GEO AREA. Unique identifier of the geographical area.'),
run_tmsp DATETIME NOT NULL OPTIONS(description='Relevant timestamp of the model run.'),
active_from_dt DATE NOT NULL
OPTIONS(description='Start of the timeframe the model run result is valid for. This is in general the first day of a reference period, e.g. the Monday of the reference week for a weekly model.'),
model_run_metric_type_cd STRING(50) NOT NULL
OPTIONS(description='Technical code for the metric to be calculated on model level in a run.'),
model_run_metric_measure NUMERIC(18,5) OPTIONS(description='Result of the calculation of the metric in a model run.'),
model_area_cd STRING(100) NOT NULL OPTIONS(description='Sprechender Code, CX, LDL+, AP.'),
model_group_cd STRING(100) NOT NULL
OPTIONS(description='Eindeutiger code, der mit dem area_cd beginnt, z.B. AP_bakeoff or CX_store_rating.'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier des letzten Ladelaufs, der den Datensatz eingefügt oder verändert hat.'),
dwh_created DATETIME NOT NULL OPTIONS(description='Zeitstempel der Ersteinfügung des Datensatzes ins DWH.'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Zeitstempel der letzten Änderung des Datensatzes im DWH.'),
PRIMARY KEY (model_sid, geo_area_sid, run_tmsp, active_from_dt, model_run_metric_type_cd) NOT ENFORCED
)
OPTIONS(description='$Revision: 0000 $. This table contains the model-level results of a model run for every specific model run metric type.');