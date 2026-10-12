--==============================================================
-- Table: flw_mes_prodfehler_spr_zu_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: flw_mes_prodfehler_spr_zu_2
   generated from Powerdesigner on Mittwoch, 13. April 2022 16:20:38
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.FLW_MES_PRODFEHLER_SPR_ZU_2 (
   mandant_id                          INTEGER    NOT NULL COMMENT 'Mandant_2 im DWH',
   mes_prodzeittyp_id                  INTEGER    NOT NULL COMMENT 'type of the step of processing meat',
   spr_id                              INTEGER    NOT NULL COMMENT 'Eindeutige Kennzeichnung der Sprache',
   mes_prodzeittyp_bez                 VARCHAR(255)    COMMENT 'description of the type of steps in meat processing ',
   TD_UPDATE 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_FLW_MES_PRODFEHLER_SPR_ZU PRIMARY KEY (mandant_id, mes_prodzeittyp_id, spr_id) NOT ENFORCED
)  COMMENT = 'translation table for type of steps in meat processing ';
