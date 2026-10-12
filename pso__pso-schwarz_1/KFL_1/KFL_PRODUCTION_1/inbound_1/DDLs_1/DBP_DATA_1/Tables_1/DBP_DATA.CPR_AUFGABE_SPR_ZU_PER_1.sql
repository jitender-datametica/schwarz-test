--==============================================================
-- Table: cpr_aufgabe_spr_zu_per_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: cpr_aufgabe_spr_zu_per_1
   generated from Powerdesigner on Tuesday, February 27, 2024 8:30:14 PM_1
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.CPR_AUFGABE_SPR_ZU_PER_1 (
   cpr_aufgabe_id                      VARCHAR(32)      NOT NULL COLLATE 'en-ci' COMMENT 'Eindeutige ID der Aufgabe aus xlctask',
   spr_id                              NUMBER(38,0)     NOT NULL COMMENT 'Referenz zu der Tabelle spr_1 fuer jede DWH Sprache = 1.',
   dat_von                             DATE             NOT NULL COMMENT 'Datum, ab dem der Datensatz gültig ist',
   dat_bis                             DATE             NOT NULL COMMENT 'Datum, bis zu dem der Datensatz gültig ist. Ist dieses Datum nicht bekannt, wird der 31.12.9999 eingestellt.',
   aufgabe_bez                         VARCHAR(40)      COLLATE 'en-ci' COMMENT 'Sprachabhängige Bezeichnung der Aufgabe aus txtmd',
   aufgabe_langtext                    VARCHAR(320)     COLLATE 'en-ci' COMMENT 'Sprachabhängiger Langtext einer Aufgabe',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_CPR_AUFGABE_SPR_ZU_PER PRIMARY KEY (cpr_aufgabe_id, spr_id, dat_von) NOT ENFORCED
)  COMMENT = 'IOS - Bezeichnung der Aufgabe';

