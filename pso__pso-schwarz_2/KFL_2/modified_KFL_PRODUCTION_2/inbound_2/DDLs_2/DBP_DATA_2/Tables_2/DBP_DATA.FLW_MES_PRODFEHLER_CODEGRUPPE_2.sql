--==============================================================
-- Table: flw_mes_prodfehler_codegruppe_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: flw_mes_prodfehler_codegruppe_2
   generated from Powerdesigner on Mittwoch, 13. April 2022 16:00:45
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.FLW_MES_PRODFEHLER_CODEGRUPPE_2 (
   mandant_id                          INTEGER    NOT NULL COMMENT 'Mandant_2 im DWH',
   fehler_katalog_id                   VARCHAR(1)      NOT NULL COMMENT 'Basic catalogue of faults - random letter taken by business to identify',
   fehler_code_gruppe_id               VARCHAR(9)      NOT NULL COMMENT 'group identifier of the code of a fault happened during production',
   TD_UPDATE 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_FLW_MES_PRODFEHLER_CODEGRUPPE PRIMARY KEY (mandant_id, fehler_code_gruppe_id) NOT ENFORCED
)  COMMENT = 'this table is about the fault code group and description of code group';
