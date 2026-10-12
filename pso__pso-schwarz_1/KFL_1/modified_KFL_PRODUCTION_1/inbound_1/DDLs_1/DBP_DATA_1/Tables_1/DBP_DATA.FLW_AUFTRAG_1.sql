--==============================================================
-- Table: flw_auftrag_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: flw_auftrag_1
   generated from Powerdesigner on Monday, March 4, 2024 12:59:39 PM_1
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.FLW_AUFTRAG_1 (
   auftrag_id                          VARCHAR(20)      NOT NULL COLLATE 'en-ci' COMMENT 'Auftragsnummer aus aufnr',
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant_1 im DWH. In der Regel länderbezogen',
   auftragsart_id                      VARCHAR(4)       COLLATE 'en-ci' COMMENT 'ID der Auftragsart aus auart',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_FLW_AUFTRAG PRIMARY KEY (auftrag_id, mandant_id) NOT ENFORCED
)  COMMENT = 'FLW - Auftragsstammdaten aus aufk';

