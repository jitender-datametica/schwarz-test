--==============================================================
-- Table: flw_l_codegruppe_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: flw_l_codegruppe_1
   generated from Powerdesigner on Monday, March 4, 2024 12:59:41 PM_1
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.FLW_L_CODEGRUPPE_1 (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant_1 im DWH. In der Regel länderbezogen',
   katalogart_id                       VARCHAR(1)       NOT NULL COLLATE 'en-ci' COMMENT 'Katalogart',
   codegruppe_id                       VARCHAR(10)      NOT NULL COLLATE 'en-ci' COMMENT 'ID der codegruppe',
   system_id                           INTEGER     NOT NULL COMMENT 'Spezifiziert das Quellsystem, aus dem die Daten kommen.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_FLW_L_CODEGRUPPE PRIMARY KEY (mandant_id, katalogart_id, codegruppe_id) NOT ENFORCED
)  COMMENT = 'FLW - Lookup-Tabelle der Codegruppen aus qpgr';

