DROP TABLE IF EXISTS DBP_ETL.zlf_auslfel_1;
CREATE  TABLE DBP_ETL.zlf_auslfel_1  (
 mandant_id             BYTEINT
,auslieferungsgruppe_id CHAR(4) COLLATE 'de-ci'
,wg_id                  SMALLINT
,sortimentslistenart_id CHAR(1) COLLATE 'de-ci'
,td_insert              TIMESTAMP_LTZ(9)
) ;

