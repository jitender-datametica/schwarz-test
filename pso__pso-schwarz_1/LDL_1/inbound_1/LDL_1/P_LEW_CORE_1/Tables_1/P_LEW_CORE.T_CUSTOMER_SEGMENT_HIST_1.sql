/* --------------------------------------------------------------------------------
   DDL for table: t_customer_segment_hist_1
   generated from Powerdesigner on Mittwoch, 14. Juni 2023 16:48:23
*/ --------------------------------------------------------------------------------

CREATE TABLE P_LEW_CORE.T_CUSTOMER_SEGMENT_HIST_1 CLUSTER BY (
     ACTIVE_FROM_DT,
     GEO_AREA_SID,
     MODEL_GROUP_CD 
) (
   client_id                           NUMBER(38,0)     NOT NULL COMMENT 'Client_id: technically required ba the core loader for historized tables, contains 7 (=Stiftung) for all records',
   customer_sid                        NUMBER(38,0)     NOT NULL COMMENT 'unique identifier of the customer (surrogate key)',
   segmentation_sid                    NUMBER(38,0)     NOT NULL COMMENT 'Surrogate Key SEGMENTATION',
   segment_sid                         NUMBER(38,0)     NOT NULL COMMENT 'Surrogate Key SEGMENT',
   model_sid                           NUMBER(38,0)     NOT NULL COMMENT 'Surrogate Key MODEL',
   geo_area_sid                        NUMBER(38,0)     NOT NULL COMMENT 'unique identifier of the geographical area (surrogate key)',
   run_tmsp                            TIMESTAMP_NTZ(9) NOT NULL COMMENT 'relevant timestamp of the model run',
   active_from_dt                      DATE             NOT NULL COMMENT 'begin of the timeframe the model run result is valid for. This is in general the first day of a reference period, e.g. the Monday of the reference week for a weekly model. This is equal to the timeframe the customer is related to this specific segment.',
   active_to_dt                        DATE             COMMENT 'end of the timeframe the model run result is valid for. This is in general the last day of a reference period, e.g. the Sunday of the reference week for a weekly model. This is equal to the timeframe the customer is related to this specific segment.',
   model_area_cd                       VARCHAR(100)     NOT NULL COMMENT 'sprechender Code, CX, LDL+,AP',
   model_group_cd                      VARCHAR(100)     NOT NULL COMMENT 'eindeutiger code, der mit dem area_cd beginnt z.b. AP_bakeoff or CX_store_rating',
   deleted_fg                          NUMBER(38,0)     NOT NULL COMMENT 'Kunde ist im Falle deleted_fg = 1 im Zeitraum dwh_valid_from / dwh_valid_to nicht im Quellsystem bekannt; Hinweis: auch bei gesetztem Loeschkz im Quellsystem wird dieser Status_1 angenommen',
   dwh_valid_from                      DATE             NOT NULL COMMENT 'Gueltigkeitsbeginn; Teil der DWH-Historisierung; aeltester Satz der Historie erhaelt immer den Wert 01.01.1900 ("minus unendlich")',
   dwh_valid_to                        DATE             NOT NULL COMMENT 'Gueltigkeitsende; Teil der DWH-Historisierung; neuster Satz der Historie erhaelt immer den Wert 30.12.9999 ("plus unendlich")',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'Identifier des letzten Ladelaufs, der den Datensatz eingfuegt oder veraendert hat',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Zeitstempel der Ersteinfuegung des Datensatzes ins DWH',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Zeitstempel der letzten Aenderung des Datensatzes im DWH',   
   CONSTRAINT PK_T_CUSTOMER_SEGMENT_HIST PRIMARY KEY (customer_sid, segmentation_sid, geo_area_sid, active_from_dt, dwh_valid_from) NOT ENFORCED 
)  COMMENT = '$Revision: 0000 $. this table contains the assignements of customers to segments';
