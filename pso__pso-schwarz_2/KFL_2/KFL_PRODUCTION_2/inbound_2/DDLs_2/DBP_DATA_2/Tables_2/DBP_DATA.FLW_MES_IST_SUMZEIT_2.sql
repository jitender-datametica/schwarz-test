--==============================================================
-- Table: flw_mes_ist_sumzeit_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: flw_mes_ist_sumzeit_2
   generated from Powerdesigner on Mittwoch, 13. April 2022 16:21:38
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.FLW_MES_IST_SUMZEIT_2 (
   mandant_id                          NUMBER(38,0)    NOT NULL COMMENT 'Mandant_2 im DWH',
   flw_werk_id                         NUMBER(38,0)    NOT NULL COMMENT 'plant where the meat is processed',
   flw_arbeitsplatz_id                 VARCHAR(8)      NOT NULL COMMENT 'identifier of the working place in production line',
   schicht_id                          VARCHAR(32)     NOT NULL COMMENT 'identifier of the shift in the production line',
   mes_prodmengetyp_gruppe             VARCHAR(4)      NOT NULL COMMENT 'productiontype description: PROD;RUES',
   mes_prodzeittyp_id                  NUMBER(38,0)    NOT NULL COMMENT 'type of the step of processing meat',
   dat_ist_prod                        DATE            COMMENT 'date of the production',
   ist_prod_dauer                      NUMBER(38,5)    COMMENT 'duration of production uptime',
   ist_prod_einh                       VARCHAR(1)      COMMENT 'measument unit_2 of duration uptime',
   datzeit_aenderung                   TIMESTAMP_NTZ   COMMENT 'Records update time in plant''s timezone ',
   TD_UPDATE 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_FLW_MES_IST_SUMZEIT PRIMARY KEY (mandant_id, flw_werk_id, schicht_id, flw_arbeitsplatz_id, mes_prodzeittyp_id, mes_prodmengetyp_gruppe) NOT ENFORCED
)  COMMENT = 'this table contains data for actual prodcution uptime ';
