--==============================================================
-- Table: flw_l_pruefkatalog_code_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: flw_l_pruefkatalog_code_1
   generated from Powerdesigner on Tuesday, March 12, 2024 9:30:42 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.FLW_L_PRUEFKATALOG_CODE_1 (
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Mandant_1 im DWH. In der Regel länderbezogen',
   katalogart_id                       VARCHAR(1)       NOT NULL COLLATE 'en-ci' COMMENT 'Katalogart',
   codegruppe_id                       VARCHAR(10)      NOT NULL COLLATE 'en-ci' COMMENT 'ID der codegruppe',
   werk_id                             NUMBER(38,0)     NOT NULL COMMENT 'Numerischer Surrogate key für das Werk werks',
   pruefcode_id                        VARCHAR(4)       NOT NULL COLLATE 'en-ci' COMMENT 'ID des Prüfcodes aus code',
   auswahlmenge                        NUMBER(38,0)     NOT NULL COMMENT 'Auswahlmenge aus auswahlmge. Im DWH werden nur numerische Werte zugelassen',
   system_id                           NUMBER(38,0)     NOT NULL COMMENT 'Spezifiziert das Quellsystem, aus dem die Daten kommen.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_FLW_L_PRUEFKATALOG_CODE PRIMARY KEY (mandant_id, katalogart_id, codegruppe_id, werk_id, pruefcode_id, auswahlmenge) NOT ENFORCED
)  COMMENT = 'FLW - Lookuptabelle der Prüfcodes aus qpac';

