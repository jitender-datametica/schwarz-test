--==============================================================
-- Table: in_l_pruefkatalog_code_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: in_l_pruefkatalog_code_2
   generated from Powerdesigner on Thursday, July 11, 2024 10:50:46 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.IN_L_PRUEFKATALOG_CODE_2 (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant_2 im DWH. In der Regel länderbezogen',
   katalogart_id                       VARCHAR(1)       NOT NULL COLLATE 'en-ci' COMMENT 'Katalogart aus qkatart',
   codegruppe_id                       VARCHAR(10)      NOT NULL COLLATE 'en-ci' COMMENT 'Codegruppe aus qcodegrp',
   pruefcode_id                        VARCHAR(4)       NOT NULL COLLATE 'en-ci' COMMENT 'ID des Prüfcodes aus qcode',
   version_id                          VARCHAR(7)       NOT NULL COLLATE 'en-ci' COMMENT 'ID der Version aus qversnr',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_IN_L_PRUEFKATALOG_CODE PRIMARY KEY (mandant_id, katalogart_id, codegruppe_id, pruefcode_id, version_id) NOT ENFORCED
)  COMMENT = 'LIS  - Lookuptabelle der Prüfcodes aus SAP Industrie qpct';
