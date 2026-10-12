/* --------------------------------------------------------------------------------
   DDL for table: t_ref_model_model_run_metric
   generated from Powerdesigner on Mittwoch, 14. Juni 2023 16:34:30
*/ --------------------------------------------------------------------------------

CREATE TABLE P_LEW_CORE.T_REF_MODEL_MODEL_RUN_METRIC (
   model_sid                           NUMBER(38,0)     NOT NULL COMMENT 'Surrogate Key MODEL',
   model_run_metric_type_cd            VARCHAR(50)      NOT NULL COMMENT 'technical code for the metric to be calculated on model level in a run',
   model_area_cd                       VARCHAR(100)     NOT NULL COMMENT 'sprechender Code, CX, LDL+,AP',
   model_group_cd                      VARCHAR(100)     NOT NULL COMMENT 'eindeutiger code, der mit dem area_cd beginnt z.b. AP_bakeoff or CX_store_rating',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'Identifier des letzten Ladelaufs, der den Datensatz eingfuegt oder veraendert hat',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Zeitstempel der Ersteinfuegung des Datensatzes ins DWH',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Zeitstempel der letzten Aenderung des Datensatzes im DWH',   
   CONSTRAINT PK_T_REF_MODEL_MODEL_RUN_METRIC PRIMARY KEY (model_sid, model_run_metric_type_cd) NOT ENFORCED 
)  COMMENT = '$Revision: 0000 $. this table contains the information which model run metric will be calculated for which model';