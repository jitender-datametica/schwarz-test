/* --------------------------------------------------------------------------------
   DDL for table: t_model_run_1
   generated from Powerdesigner on Mittwoch, 14. Juni 2023 17:20:18
*/ --------------------------------------------------------------------------------

CREATE TABLE P_LEW_CORE.T_MODEL_RUN_1 (
   model_sid                           NUMBER(38,0)     NOT NULL COMMENT 'Surrogate Key MODEL',
   geo_area_sid                        NUMBER(38,0)     NOT NULL COMMENT 'Surrogate Key GEO AREA. Unique identifier of the geographical area.',
   run_tmsp                            TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Relevant timestamp of the model run.',
   active_from_dt                      DATE             NOT NULL COMMENT 'Start of the timeframe the model run result is valid for. This is in general the first day of a reference period, e.g. the Monday of the reference week for a weekly model.',
   active_to_dt                        DATE             COMMENT 'End of the timeframe the model run result is valid for. This is in general the last day of a reference period, e.g. the Sunday of the reference week for a weekly model.',
   cy_week                             NUMBER(38,0)     COMMENT 'YYYYKW; WAWI: x_data.t_cal_week.cy_week. Populated in the case that the model is a weekly model.',
   cy_month                            NUMBER(38,0)     COMMENT 'YYYYMM; WAWI: x_data.t_cal_month.cy_month. Populated in the case that the model is a monthly model.',
   model_area_cd                       VARCHAR(100)     NOT NULL COMMENT 'Sprechender Code, CX, LDL+, AP.',
   model_group_cd                      VARCHAR(100)     NOT NULL COMMENT 'Eindeutiger code, der mit dem model_area_cd beginnt, z.B. AP_bakeoff or CX_store_rating.',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'Identifier des letzten Ladelaufs, der den Datensatz eingefügt oder verändert hat.',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Zeitstempel der Ersteinfügung des Datensatzes ins DWH.',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Zeitstempel der letzten Änderung des Datensatzes im DWH.',   
   CONSTRAINT PK_T_MODEL_RUN PRIMARY KEY (model_sid, geo_area_sid, active_from_dt, run_tmsp) NOT ENFORCED 
)  COMMENT = '$Revision: 0000 $. This table contains the information about runs of models for certain geographical areas and related to a defined time key or range.';
