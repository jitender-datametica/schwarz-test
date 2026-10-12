--==============================================================
-- Table: flw_mes_prodfehler_code_spr_zu_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: flw_mes_prodfehler_code_spr_zu_2
   generated from Powerdesigner on Donnerstag, 24. November 2022 14:04:22
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.FLW_MES_PRODFEHLER_CODE_SPR_ZU_2 (
   mandant_id                          INTEGER    NOT NULL COMMENT 'Mandant_2 im DWH',
   fehler_code_id                      VARCHAR(4)      NOT NULL COMMENT 'code of a fault happened during production',
   fehler_code_gruppe_id               VARCHAR(9)      NOT NULL COMMENT 'group identifier of the code of a fault happened during production',
   spr_id                              INTEGER    NOT NULL COMMENT 'ID der Sprache
            ',
   fehler_code_bez                     VARCHAR(500)    NOT NULL COMMENT 'Text about the code example: Wartung, Reinigung, Folienriss, what shows the faults in production',
   TD_UPDATE 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_FLW_MES_PRODFEHLER_CODE_SPR_ZU PRIMARY KEY (mandant_id, fehler_code_id, fehler_code_gruppe_id, spr_id) NOT ENFORCED
)  COMMENT = 'this table is about the fault code and description of the code';
