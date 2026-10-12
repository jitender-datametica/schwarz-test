--==============================================================
-- Table: flw_mes_prodfehler_code
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: flw_mes_prodfehler_code
   generated from Powerdesigner on Mittwoch, 13. April 2022 16:03:00
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.FLW_MES_PRODFEHLER_CODE (
   mandant_id                          NUMBER(38,0)    NOT NULL COMMENT 'Mandant im DWH',
   fehler_code_id                      CHAR(4)         NOT NULL COMMENT 'code of a fault happened during production',
   fehler_katalog_id                   VARCHAR(1)      NOT NULL COMMENT 'Basic catalogue of faults - random letter taken by business to identify',
   fehler_code_gruppe_id               VARCHAR(9)      NOT NULL COMMENT 'group identifier of the code of a fault happened during production',
   TD_UPDATE 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_FLW_MES_PRODFEHLER_CODE PRIMARY KEY (mandant_id, fehler_code_id, fehler_code_gruppe_id) NOT ENFORCED
)  COMMENT = 'this table is about the fault code and description of the code';
