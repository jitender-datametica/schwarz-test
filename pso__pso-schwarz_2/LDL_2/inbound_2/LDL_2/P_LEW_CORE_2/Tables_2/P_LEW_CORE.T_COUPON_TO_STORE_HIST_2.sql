/* --------------------------------------------------------------------------------
   DDL for table: t_coupon_to_store_hist_2
   generated from Powerdesigner on Wednesday, February 21, 2024 1:07:10 PM_2
*/ --------------------------------------------------------------------------------

CREATE TABLE P_LEW_CORE.T_COUPON_TO_STORE_HIST_2 CLUSTER BY (
     CLIENT_ID,
     COUPON_SID 
) (
   client_id                           NUMBER(38,0)     NOT NULL COMMENT 'unique identifier of the DWH client / slice',
   coupon_sid                          NUMBER(38,0)     NOT NULL COMMENT 'unique identifier of the Coupon (surrogate key)',
   loc_sid_store                       NUMBER(38,0)     NOT NULL COMMENT 'unique identifier of the store that accepts the coupon (surrogate key)',
   loyalty_prog_cd                     VARCHAR(5)       NOT NULL COLLATE 'en-ci' COMMENT 'identifier of the loyalty program the coupon belongs to',
   coupon_relation_type_cd             VARCHAR(6)       NOT NULL COLLATE 'en-ci' COMMENT 'code identifying how the item_2 is related to the coupon',
   deleted_fg                          NUMBER(38,0)     NOT NULL COMMENT 'Beziehung ist im Falle deleted_fg = 1 im Zeitraum dwh_valid_from / dwh_valid_to nicht im Quellsystem bekannt; Hinweis: auch bei gesetztem Loeschkz im Quellsystem wird dieser Status_2 angenommen',
   dwh_valid_from                      DATE             NOT NULL COMMENT 'Gueltigkeitsbeginn; Teil der DWH-Historisierung; aeltester Satz der Historie erhaelt immer den Wert 01.01.1900 ("minus unendlich")',
   dwh_valid_to                        DATE             NOT NULL COMMENT 'Gueltigkeitsende; Teil der DWH-Historisierung; neuster Satz der Historie erhaelt immer den Wert 30.12.9999 ("plus unendlich")',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'Identifier des letzten Ladelaufs, der den Datensatz eingfuegt oder veraendert hat',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Zeitstempel der Ersteinfuegung des Datensatzes ins DWH',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Zeitstempel der letzten Aenderung des Datensatzes im DWH',   
   CONSTRAINT PK_T_COUPON_TO_STORE_HIST PRIMARY KEY (coupon_sid, loc_sid_store, coupon_relation_type_cd, dwh_valid_from) NOT ENFORCED 
)  COMMENT = '$Revision: 0000 $. In general, coupons are valid in all stores within the country_2 the coupon belongs to - in this case no record is in the table for the coupon. Some coupons are only valid in certain stores - in this case those store that accept the coupon are listed explicitly.';

