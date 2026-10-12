/* --------------------------------------------------------------------------------
   DDL for table: t_model_run_metric_1
   generated from Powerdesigner on Mittwoch, 14. Juni 2023 18:03:23
*/ --------------------------------------------------------------------------------

CREATE TABLE P_LEW_CORE.T_MODEL_RUN_METRIC_1 (
   model_sid                           NUMBER(38,0)     NOT NULL COMMENT 'Surrogate Key MODEL',
   geo_area_sid                        NUMBER(38,0)     NOT NULL COMMENT 'Surrogate Key GEO AREA. Unique identifier of the geographical area.',
   run_tmsp                            TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Relevant timestamp of the model run.',
   active_from_dt                      DATE             NOT NULL COMMENT 'Start of the timeframe the model run result is valid for. This is in general the first day of a reference period, e.g. the Monday of the reference week for a weekly model.',
   model_run_metric_type_cd            VARCHAR(50)      NOT NULL COMMENT 'Technical code for the metric to be calculated on model level in a run.',
   model_run_metric_measure            NUMBER(18,5)     COMMENT 'Result of the calculation of the metric in a model run.',
   model_area_cd                       VARCHAR(100)     NOT NULL COMMENT 'Sprechender Code, CX, LDL+, AP.',
   model_group_cd                      VARCHAR(100)     NOT NULL COMMENT 'Eindeutiger code, der mit dem area_cd beginnt, z.B. AP_bakeoff or CX_store_rating.',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'Identifier des letzten Ladelaufs, der den Datensatz eingefügt oder verändert hat.',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Zeitstempel der Ersteinfügung des Datensatzes ins DWH.',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Zeitstempel der letzten Änderung des Datensatzes im DWH.',   
   CONSTRAINT PK_T_MODEL_RUN_METRIC PRIMARY KEY (model_sid, geo_area_sid, run_tmsp, active_from_dt, model_run_metric_type_cd) NOT ENFORCED 
)  COMMENT = '$Revision: 0000 $. This table contains the model-level results of a model run for every specific model run metric type.';
