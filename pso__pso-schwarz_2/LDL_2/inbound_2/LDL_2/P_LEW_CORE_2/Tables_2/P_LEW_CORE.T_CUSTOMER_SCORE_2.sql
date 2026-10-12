/* --------------------------------------------------------------------------------
   DDL for table: t_customer_score_2
   generated from Powerdesigner on Mittwoch, 14. Juni 2023 17:10:50
*/ --------------------------------------------------------------------------------

CREATE TABLE P_LEW_CORE.T_CUSTOMER_SCORE_2 CLUSTER BY (
     ACTIVE_FROM_DT,
     GEO_AREA_SID,
     MODEL_GROUP_CD 
) (
   customer_sid                        NUMBER(38,0)     NOT NULL COMMENT 'unique identifier of the customer (surrogate key)',
   score_type_sid                      NUMBER(38,0)     NOT NULL COMMENT 'Surrogate Key SCORE TYPE',
   model_sid                           NUMBER(38,0)     NOT NULL COMMENT 'Surrogate Key MODEL',
   geo_area_sid                        NUMBER(38,0)     NOT NULL COMMENT 'unique identifier of the geographical area (surrogate key)',
   run_tmsp                            TIMESTAMP_NTZ(9) NOT NULL COMMENT 'relevant timestamp of the model run',
   active_from_dt                      DATE             NOT NULL COMMENT 'begin of the timeframe the model run result is valid for. This is in general the first day of a reference period, e.g. the Monday of the reference week for a weekly model.',
   score_measure                       NUMBER(18,5)     COMMENT 'result of the calculation of a score type for an individual customer in a certain model run.',
   model_area_cd                       VARCHAR(100)     NOT NULL COMMENT 'sprechender Code, CX, LDL+,AP',
   model_group_cd                      VARCHAR(100)     NOT NULL COMMENT 'eindeutiger code, der mit dem area_cd beginnt z.b. AP_bakeoff or CX_store_rating',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'Identifier des letzten Ladelaufs, der den Datensatz eingfuegt oder veraendert hat',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Zeitstempel der Ersteinfuegung des Datensatzes ins DWH',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Zeitstempel der letzten Aenderung des Datensatzes im DWH',   
   CONSTRAINT PK_T_CUSTOMER_SCORE PRIMARY KEY (score_type_sid, model_sid, geo_area_sid, active_from_dt, run_tmsp, customer_sid) NOT ENFORCED 
)  COMMENT = '$Revision: 0000 $. this table contains the calculated scores for customers which have been calculated in model runs of models for customer segmentation';
