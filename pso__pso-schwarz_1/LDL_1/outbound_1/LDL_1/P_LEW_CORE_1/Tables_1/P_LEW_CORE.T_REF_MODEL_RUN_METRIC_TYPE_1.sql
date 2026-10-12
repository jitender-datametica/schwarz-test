CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_ref_model_run_metric_type_1 (
model_run_metric_type_cd STRING(50) NOT NULL
OPTIONS(description='technical code for the metric to be calculated on model level in a run'),
model_run_metric_type_descr STRING(250) NOT NULL
OPTIONS(description='description of the metric to be calculated on model level in a run'),
dwh_load_id INTEGER NOT NULL
OPTIONS(description='Identifier des letzten Ladelaufs, der den Datensatz eingfuegt oder veraendert hat'),
dwh_created DATETIME NOT NULL OPTIONS(description='Zeitstempel der Ersteinfuegung des Datensatzes ins DWH'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Zeitstempel der letzten Aenderung des Datensatzes im DWH'),
PRIMARY KEY (model_run_metric_type_cd) NOT ENFORCED
) OPTIONS(description='$Revision: 0000 $. a model run metric defines a model-level result of a model run');