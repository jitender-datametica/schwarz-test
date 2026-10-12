--==============================================================
-- Table: aufgabenart_spr_zu_per
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: aufgabenart_spr_zu_per
   generated from Powerdesigner on Tuesday, February 20, 2024 3:55:28 PM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.AUFGABENART_SPR_ZU_PER (
   aufgabenart_id                      VARCHAR(20)      NOT NULL COLLATE 'en-ci' COMMENT 'ID der Aufgabenart. In der Regel werden nur 2 Byte benutzt',
   spr_id                              NUMBER(38,0)     NOT NULL COMMENT 'Referenz zu der Tabelle spr fuer jede DWH Sprache = 1.',
   dat_von                             DATE             NOT NULL COMMENT 'Datum, ab dem der Datensatz gültig ist',
   dat_bis                             DATE             NOT NULL COMMENT 'Datum, bis zu dem der Datensatz gültig ist. Ist dieses Datum nicht bekannt, wird der 31.12.9999 eingestellt.',
   aufgabenart_bez                     VARCHAR(40)      COLLATE 'en-ci' COMMENT 'Sprachabhängige Bezeichnung der Aufgabenart',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_AUFGABENART_SPR_ZU_PER PRIMARY KEY (aufgabenart_id, spr_id, dat_von) NOT ENFORCED
)  COMMENT = 'IOS - Sprachabhängige Bezeichnung der Aufgabenart';

