--==============================================================
-- Table: cpr_checkliste_spr_zu_per
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: cpr_checkliste_spr_zu_per
   generated from Powerdesigner on Tuesday, February 27, 2024 8:30:14 PM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.CPR_CHECKLISTE_SPR_ZU_PER (
   cpr_checkliste_id                   VARCHAR(32)      NOT NULL COLLATE 'en-ci' COMMENT 'Eindeutige ID einer Projekt-Checkliste aus xlccheckl',
   dat_von                             DATE             NOT NULL COMMENT 'Datum, ab dem der Datensatz gültig ist',
   spr_id                              INTEGER     NOT NULL COMMENT 'Referenz zu der Tabelle spr fuer jede DWH Sprache = 1.',
   dat_bis                             DATE             NOT NULL COMMENT 'Datum, bis zu dem der Datensatz gültig ist. Ist dieses Datum nicht bekannt, wird der 31.12.9999 eingestellt.',
   cpr_checkliste_bez                  VARCHAR(40)      NOT NULL COLLATE 'en-ci' COMMENT 'Sprachabhängige Bezeichnung der Checkliste',
   cpr_checkliste_langtext             VARCHAR(320)     COLLATE 'en-ci' COMMENT 'Sprachabhängiger Langtext zur Checkliste',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_CPR_CHECKLISTE_SPR_ZU_PER PRIMARY KEY (cpr_checkliste_id, dat_von, spr_id) NOT ENFORCED
)  COMMENT = 'IOS - Sprachabhängige Beschreibung der Checkliste';

