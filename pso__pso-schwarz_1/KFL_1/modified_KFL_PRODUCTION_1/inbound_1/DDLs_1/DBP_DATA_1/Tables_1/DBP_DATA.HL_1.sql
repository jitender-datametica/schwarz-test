--==============================================================
-- Table: hl_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: hl_1
   generated from Powerdesigner on Thursday, July 11, 2024 10:50:44 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.HL_1 (
   hl_id                               INTEGER     NOT NULL COMMENT 'Hausleiter ID entspricht der Mitarbeiter ID
            ',
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant_1 im DWH',
   hl_name                             VARCHAR(40)      COLLATE 'en-ci' COMMENT 'Name des Hausleiters, i.d.R. bestehend aus Anrede, Vor- und Zuname (Herr Hans Mustermann)',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_HL PRIMARY KEY (hl_id, mandant_id) NOT ENFORCED
)  COMMENT = 'VIS - Lookup Tabelle der Hausleiter';
