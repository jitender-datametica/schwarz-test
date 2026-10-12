--==============================================================
-- Table: flw_mes_prodfehler_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: flw_mes_prodfehler_2
   generated from Powerdesigner on Mittwoch, 13. April 2022 16:03:37
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.FLW_MES_PRODFEHLER_2 (
   mandant_id                          NUMBER(38,0)    NOT NULL COMMENT 'Mandant_2 im DWH',
   schicht_id                          VARCHAR(32)     NOT NULL COMMENT 'identifier of the shift in the production line',
   mes_prodzeittyp_id                  NUMBER(38,0)    NOT NULL COMMENT 'type of the step of processing meat',
   fehler_katalog_id                   VARCHAR(1)      NOT NULL COMMENT 'Basic catalogue of faults - random letter taken by business to identify',
   fehler_code_gruppe_id               VARCHAR(9)      NOT NULL COMMENT 'group identifier of the code of a fault happened during production',
   fehler_code_id                      VARCHAR(4)      NOT NULL COMMENT 'code of a fault happened during production',
   datzeit_anfang                      TIMESTAMP_LTZ   COMMENT 'timestamp whet the fault started',
   datzeit_ende                        TIMESTAMP_LTZ   COMMENT 'timestamp when the fault ended',
   ist_fehler_dauer                    NUMBER(38,5)    COMMENT 'duration of the fault',
   ist_fehler_einh                     VARCHAR(1)      COMMENT 'Fault duration type (ex  S = seconds)',
   TD_UPDATE 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_FLW_MES_PRODFEHLER PRIMARY KEY (mandant_id, schicht_id, mes_prodzeittyp_id, fehler_katalog_id, fehler_code_gruppe_id, fehler_code_id) NOT ENFORCED
)  COMMENT = 'table is about a Basic catalogue of faults in production line';
