CREATE TABLE P_LEW_CORE.T_REF_MODEL_RUN_METRIC_TYPE 
(
 model_run_metric_type_cd VARCHAR(50) NOT NULL COMMENT 'technical code for the metric to be calculated on model level in a run',
 model_run_metric_type_descr VARCHAR(250) NOT NULL COMMENT 'description of the metric to be calculated on model level in a run',
 dwh_load_id INTEGER NOT NULL COMMENT 'Identifier des letzten Ladelaufs, der den Datensatz eingfuegt oder veraendert hat',
 dwh_created TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Zeitstempel der Ersteinfuegung des Datensatzes ins DWH',
 dwh_updated TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Zeitstempel der letzten Aenderung des Datensatzes im DWH',
 CONSTRAINT PK_model_run_metric_type PRIMARY KEY (model_run_metric_type_cd)
 NOT enforced
) 
COMMENT = '$Revision: 0000 $. a model run metric defines a model-level result of a model run'
;